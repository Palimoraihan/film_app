import 'package:film_app/data/repository/transaction_repository.dart';
import 'package:film_app/domain/entities/result.dart';
import 'package:film_app/domain/usecase/create_transaction/create_transaction_params.dart';
import 'package:film_app/domain/usecase/usecase.dart';

class CreateTransaction
    implements UseCase<Result<void>, CreateTransactionParams> {
  final TransactionRepository _transactionRepository;

  CreateTransaction({required TransactionRepository transactionRepository})
      : _transactionRepository = transactionRepository;

  @override
  Future<Result<void>> call(CreateTransactionParams param) async {
    int transactionTime = DateTime.now().millisecondsSinceEpoch;
    var result = await _transactionRepository.createTransaction(
        transaction: param.transaction.copyWith(transactionTime: transactionTime, id:(param.transaction.id== null) ?'FP-$transactionTime-${param.transaction.uid}':param.transaction.id));

    return switch (result) {
      Success(value: _) => const Result.success(null),
      Failed(:final message) => Result.failed(message)
    };
  }
}
