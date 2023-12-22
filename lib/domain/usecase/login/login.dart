import 'package:film_app/data/repository/auth.dart';
import 'package:film_app/data/repository/user_repository.dart';
import 'package:film_app/domain/entities/result.dart';
import 'package:film_app/domain/entities/user.dart';
import 'package:film_app/domain/usecase/usecase.dart';
part 'login_params.dart';

class Login implements UseCase<Result<User>, LoginParams> {
  final Auth auth;
  final UserRepository userRepository;
  Login({required this.auth, required this.userRepository});

  @override
  Future<Result<User>> call(LoginParams param) async {
    var idResult =
        await auth.login(email: param.email, password: param.password);

    if (idResult is Success) {
      var userResult = await userRepository.getUser(uid: idResult.resultValue!);
      return switch (userResult) {
        Success(value:final user)=>Result.success(user),
        Failed(:final message)=>Result.failed(message)
      };
    } else {
      return Result.failed(idResult.errorMessage!);
    }
  }
}
