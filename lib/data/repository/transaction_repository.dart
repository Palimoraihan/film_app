import 'package:film_app/domain/entities/result.dart';
import 'package:film_app/domain/entities/transactions.dart';

abstract interface class TransactionRepository {
  Future<Result<Transaction>>createTransaction({required Transaction transaction});
  Future<Result<List<Transaction>>> getUserTransaction(
      {required String uid});


} 