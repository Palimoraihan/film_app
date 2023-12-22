import 'package:film_app/data/repository/auth.dart';
import 'package:film_app/data/repository/user_repository.dart';
import 'package:film_app/domain/entities/result.dart';
import 'package:film_app/domain/entities/user.dart';
import 'package:film_app/domain/usecase/usecase.dart';

class GetLogedInUser implements UseCase<Result<User>, void> {
  final Auth _auth;
  final UserRepository _userRepository;

  GetLogedInUser({required Auth auth, required UserRepository userRepository})
      : _auth = auth,
        _userRepository = userRepository;
  @override
  Future<Result<User>> call(void _) async {
    String? loggedId = _auth.getLoggedUserId();
    if (loggedId != null) {
      var userResult = await _userRepository.getUser(uid: loggedId);
      if (userResult.isSuccess) {
        return Result.success(userResult.resultValue!);
      } else {
        return Result.failed(userResult.errorMessage!);
      }
    } else {
      return const Result.failed('No user loged in');
    }
  }
}
