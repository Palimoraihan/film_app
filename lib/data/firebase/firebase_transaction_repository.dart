import 'package:film_app/data/firebase/firebase_user_repository.dart';
import 'package:film_app/data/repository/transaction_repository.dart';
import 'package:film_app/domain/entities/result.dart';
import 'package:film_app/domain/entities/transactions.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;

class FirebaseTransactionRepository implements TransactionRepository {
  final firestore.FirebaseFirestore _firebaseFirestore;

  FirebaseTransactionRepository(
      {firestore.FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firestore.FirebaseFirestore.instance;

  @override
  Future<Result<Transaction>> createTransaction(
      {required Transaction transaction}) async {
    firestore.CollectionReference<Map<String, dynamic>> transactions =
        _firebaseFirestore.collection('transaction');
    try {
      var balanceResault =
          await FirebaseUserRepository().getUserBalance(uid: transactions.id);
      if (balanceResault.isSuccess) {
        int previusBalance = balanceResault.resultValue!;
        if (previusBalance - transaction.total >= 0) {
          await transactions.doc(transaction.id).set(transaction.toJson());
          var resault = await transactions.doc(transaction.id).get();
          if (resault.exists) {
            await FirebaseUserRepository().updateUserBalance(
                uid: transaction.uid,
                balance: previusBalance - transaction.total);
            return Result.success(Transaction.fromJson(resault.data()!));
          } else {
            return const Result.failed('Failed to create transaction data');
          }
        } else {
          return const Result.failed('Insufficient balance');
        }
      } else {
        return const Result.failed('Failed to create trabsaction data');
      }
    } catch (e) {
      return const Result.failed('Failed to create transaction');
    }
  }

  @override
  Future<Result<List<Transaction>>> getUserTransaction(
      {required String uid}) async {
    firestore.CollectionReference<Map<String, dynamic>> transactions =
        _firebaseFirestore.collection('transaction');

    try {
      var result = await transactions.where('uid', isEqualTo: uid).get();

      if (result.docs.isNotEmpty) {
        return Result.success(
            result.docs.map((e) => Transaction.fromJson(e.data())).toList());
      } else {
        return Result.success([]);
      }
    } catch (e) {
      return const Result.failed('Failed to get user transaction');
    }
  }
}
