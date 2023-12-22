import 'package:film_app/data/repository/transaction_repository.dart';
import 'package:film_app/data/repository/user_repository.dart';
import 'package:film_app/domain/entities/result.dart';
import 'package:film_app/domain/entities/transactions.dart';
import 'package:film_app/domain/usecase/create_transaction/create_transaction.dart';
import 'package:film_app/domain/usecase/create_transaction/create_transaction_params.dart';
import 'package:film_app/domain/usecase/top_up/top_up_param.dart';
import 'package:film_app/domain/usecase/usecase.dart';

class TopUp implements UseCase<Result<void>, TopUpParam> {
  final TransactionRepository _transactionRepository;

  TopUp({required TransactionRepository transactionRepository})
      : _transactionRepository = transactionRepository;
  @override
  Future<Result<void>> call(TopUpParam param) async {
    CreateTransaction createTransaction =
        CreateTransaction(transactionRepository: _transactionRepository);

    int transactionTime = DateTime.now().millisecondsSinceEpoch;
    var createTransactionResult = await createTransaction(
        CreateTransactionParams(
            transaction: Transaction(
                id: 'FPtp-$transactionTime-${param.userId}',
                uid: param.userId,
                title: 'Top Up',
                adminFee: 0,
                total: -param.amount,
                transactionTime: transactionTime)));

    return switch (createTransactionResult) {
      Success(value: _) => const Result.success(null),
      Failed(:final message) => Result.failed('Failed Top Up')
    };
  }
}
