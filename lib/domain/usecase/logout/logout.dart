import 'package:film_app/data/repository/auth.dart';
import 'package:film_app/domain/entities/result.dart';
import 'package:film_app/domain/usecase/usecase.dart';

class Logout implements UseCase<Result<void>, void> {
  final Auth _auth;

  Logout({required Auth auth}) : _auth = auth;

  @override
  Future<Result<void>> call(void _) {
    return _auth.logout();
  }
}
