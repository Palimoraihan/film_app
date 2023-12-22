import 'package:film_app/data/repository/auth.dart';
import 'package:film_app/data/repository/user_repository.dart';
import 'package:film_app/domain/entities/result.dart';
import 'package:film_app/domain/entities/user.dart';
import 'package:film_app/domain/usecase/register/register_param.dart';
import 'package:film_app/domain/usecase/usecase.dart';

class Register implements UseCase<Result<User>, RegisterParam> {
  final Auth _auth;
  final UserRepository _userRepository;

  Register({required Auth auth, required UserRepository userRepository})
      : _auth = auth,
        _userRepository = userRepository;

  @override
  Future<Result<User>> call(RegisterParam param) async {
    var uidResult =
        await _auth.register(email: param.email, password: param.password);

    if (uidResult.isSuccess) {
      var userResult = await _userRepository.createUser(
          uid: uidResult.resultValue!,
          email: param.email,
          name: param.name,
          photoUrl: param.photoUrl);
      if (userResult.isSuccess) {
        return Result.success(userResult.resultValue!);
      } else {
        return Result.failed(userResult.errorMessage!);
      }
    } else {
      return Result.failed(uidResult.errorMessage!);
    }
  }
}
