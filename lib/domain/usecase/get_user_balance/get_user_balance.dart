import 'package:film_app/data/repository/user_repository.dart';
import 'package:film_app/domain/entities/result.dart';
import 'package:film_app/domain/usecase/get_user_balance/get_user_balance_param.dart';
import 'package:film_app/domain/usecase/usecase.dart';

class GetUserBalance implements UseCase<Result<int>, GetUserBalanceParams> {
  final UserRepository _userRepository;

  GetUserBalance({required UserRepository userRepository})
      : _userRepository = userRepository;

  @override
  Future<Result<int>> call(GetUserBalanceParams param) =>
      _userRepository.getUserBalance(uid: param.uid);
}
