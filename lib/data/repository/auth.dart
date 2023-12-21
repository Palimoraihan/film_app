import 'package:film_app/domain/entities/result.dart';

abstract interface class Auth {
  Future<Result<String>> register(
      {required String email, required String password});

  Future<Result<String>> login(
      {required String email, required String password});
}
