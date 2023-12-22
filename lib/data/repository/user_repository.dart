import 'dart:io';

import 'package:film_app/domain/entities/result.dart';

import '../../domain/entities/user.dart';

abstract interface class UserRepository {
  Future<Result<User>> createUser(
      {required String uid,
      required String email,
      required String name,
      String? photoUrl,
      int balance = 0});

  Future<Result<User>> getUser({
    required String uid,
  });
  Future<Result<User>> udateUser({
    required User user,
  });
  Future<Result<int>> getUserBalance({required String uid});
  Future<Result<User>> updateUserBalance(
      {required String uid, required int balance});
  Future<Result<User>> uploadProfilePictur(
      {required User user, required File imageFile});
  // Future<Result<int>> deleteUser({
  //   required String uid,
  // });
}
