
import 'package:film_app/domain/usecase/login/login.dart';
import 'package:film_app/presentations/provider/repositories/auth/auth_provvider.dart';
import 'package:film_app/presentations/provider/repositories/user_repository/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_provider.g.dart';

@riverpod
Login login(LoginRef ref)=> Login(auth: ref.watch(authProviderProvider), userRepository: ref.watch(userRepositoryProvider));