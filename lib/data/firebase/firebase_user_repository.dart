import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:film_app/data/repository/user_repository.dart';
import 'package:film_app/domain/entities/result.dart';
import 'package:film_app/domain/entities/user.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class FirebaseUserRepository implements UserRepository {
  final FirebaseFirestore _firebaseFirestore;

  FirebaseUserRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<Result<User>> createUser(
      {required String uid,
      required String email,
      required String name,
      String? photoUrl,
      int balance = 0}) async {
    CollectionReference<Map<String, dynamic>> user =
        _firebaseFirestore.collection('users');
    await user.doc(uid).set({
      'uid': uid,
      'email': email,
      'name': name,
      'photoUrl': photoUrl,
      'balance': balance
    });
    DocumentSnapshot<Map<String, dynamic>> result = await user.doc(uid).get();

    if (result.exists) {
      return Result.success(User.fromJson(result.data()!));
    } else {
      return const Result.failed('Filed to create user');
    }
  }

  @override
  Future<Result<User>> getUser({required String uid}) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        _firebaseFirestore.doc('users/$uid');
    DocumentSnapshot<Map<String, dynamic>> result =
        await documentReference.get();
    if (result.exists) {
      return Result.success(User.fromJson(result.data()!));
    } else {
      return const Result.failed('User Not Found');
    }
  }

  @override
  Future<Result<int>> getUserBalance({required String uid}) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        _firebaseFirestore.doc('user/$uid');
    DocumentSnapshot<Map<String, dynamic>> result =
        await documentReference.get();
    if (result.exists) {
      return Result.success(result.data()!['balance']);
    } else {
      return const Result.failed('User not found');
    }
  }

  @override
  Future<Result<User>> udateUser({required User user}) async {
    try {
      DocumentReference<Map<String, dynamic>> documentReference =
          _firebaseFirestore.doc('user/${user.uid}');

      await documentReference.update(user.toJson());
      DocumentSnapshot<Map<String, dynamic>> result =
          await documentReference.get();

      if (result.exists) {
        User updateUser = User.fromJson(result.data()!);
        if (updateUser == user) {
          return Result.success(updateUser);
        } else {
          return const Result.failed('Filed Update User Data');
        }
      } else {
        return const Result.failed('Filed Update User Data');
      }
    } on FirebaseException catch (e) {
      return Result.failed(e.message ?? 'Filed Update User Data');
    }
  }

  @override
  Future<Result<User>> updateUserBalance(
      {required String uid, required int balance}) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        _firebaseFirestore.doc('user/$uid');
    DocumentSnapshot<Map<String, dynamic>> result =
        await documentReference.get();

    if (result.exists) {
      await documentReference.update({'balance': balance});

      DocumentSnapshot<Map<String, dynamic>> updateResult =
          await documentReference.get();

      if (updateResult.exists) {
        User updatedUser = User.fromJson(updateResult.data()!);

        if (updatedUser.balance == balance) {
          return Result.success(updatedUser);
        } else {
          return const Result.failed('Failed to Update user balance');
        }
      } else {
        return const Result.failed('Failed to update user balance');
      }
    } else {
      return const Result.failed('User not found');
    }
  }

  @override
  Future<Result<User>> uploadProfilePictur(
      {required User user, required File imageFile}) async {
    String fileName = basename(imageFile.path);

    Reference reference = FirebaseStorage.instance.ref().child(fileName);

    try {
      await reference.putFile(imageFile);
      String downloadUrl = await reference.getDownloadURL();
      var updateResault =
          await udateUser(user: user.copyWith(photoUrl: downloadUrl));
      if (updateResault.isSuccess) {
        return Result.success(updateResault.resultValue!);
      } else {
        return Result.failed(updateResault.errorMessage!);
      }
    } catch (e) {
      return const Result.failed('Filed to upload profile picture');
    }
  }
}
