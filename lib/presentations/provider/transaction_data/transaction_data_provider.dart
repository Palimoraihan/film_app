import 'package:film_app/domain/entities/result.dart';
import 'package:film_app/domain/entities/transactions.dart';
import 'package:film_app/domain/entities/user.dart';
import 'package:film_app/domain/usecase/get_transaction/get_transaction.dart';
import 'package:film_app/domain/usecase/get_transaction/get_transaction_params.dart';
import 'package:film_app/presentations/provider/usecase/get_transaction_provider.dart';
import 'package:film_app/presentations/provider/user_data/user_data_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transaction_data_provider.g.dart';

@Riverpod(keepAlive: true)
class TransactionData extends _$TransactionData {
  @override
  Future<List<Transaction>> build() async {
    User? user = ref.read(userDataProvider).valueOrNull;
    if (user != null) {
      state = const AsyncLoading();
      GetTransaction getTransaction = ref.read(getTransactionProvider);
      var resault = getTransaction(GetTransactionParams(uid: user.uid));
      if (resault case Success(value: final transaction)) {
        return transaction;
      }
    }
    return const [];
  }

  Future<void> refreshTransaction() async {
    User? user = ref.read(userDataProvider).valueOrNull;
    if (user != null) {
      state = const AsyncLoading();
      GetTransaction getTransaction = ref.read(getTransactionProvider);
      var resault = await getTransaction(GetTransactionParams(uid: user.uid));
      switch (resault) {
        case Success(value: final transaction):
          state = AsyncData(transaction);
        case Failed(:final message):
          state = AsyncError(FlutterError(message), StackTrace.current);
          state = AsyncData(state.valueOrNull ?? const []);
      }
    }
  }
}
