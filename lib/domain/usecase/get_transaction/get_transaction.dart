import 'package:film_app/data/repository/transaction_repository.dart';
import 'package:film_app/domain/entities/result.dart';
import 'package:film_app/domain/entities/transactions.dart';
import 'package:film_app/domain/usecase/get_transaction/get_transaction_params.dart';
import 'package:film_app/domain/usecase/usecase.dart';

class GetTransaction
    implements UseCase<Result<List<Transaction>>, GetTransactionParams> {
  final TransactionRepository _transactionRepository;

  GetTransaction({required TransactionRepository transactionRepository})
      : _transactionRepository = transactionRepository;

  @override
  Future<Result<List<Transaction>>> call(GetTransactionParams param) async {
    var transactionResult =
        await _transactionRepository.getUserTransaction(uid: param.uid);

    return switch (transactionResult) {
      Success(value:final transactionList)=> Result.success(transactionList),
      Failed(:final message) => Result.failed(message)
    };
  }
}
