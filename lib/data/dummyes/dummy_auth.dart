import 'package:film_app/data/repository/auth.dart';
import 'package:film_app/domain/entities/result.dart';

class DummyAuth implements Auth {
  @override
  String? getLoggedUserId() {
    // TODO: implement getLoggedUserId
    throw UnimplementedError();
  }

  @override
  Future<Result<String>> login(
      {required String email, required String password}) async {
    await Future.delayed(Duration(seconds: 1));
    // return Result.success('ID-123');
    return Result.failed('Gagal Login');
  }

  @override
  Future<Result<void>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<Result<String>> register(
      {required String email, required String password}) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
