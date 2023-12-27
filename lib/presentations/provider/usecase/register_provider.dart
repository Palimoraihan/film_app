import 'package:film_app/domain/usecase/register/register.dart';
import 'package:film_app/presentations/provider/repositories/auth/auth_provvider.dart';
import 'package:film_app/presentations/provider/repositories/user_repository/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'register_provider.g.dart';

@riverpod
Register register(RegisterRef ref) => Register(
    auth: ref.watch(authProviderProvider),
    userRepository: ref.watch(userRepositoryProvider));
