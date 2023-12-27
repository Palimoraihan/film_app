import 'package:film_app/domain/usecase/logout/logout.dart';
import 'package:film_app/presentations/provider/repositories/auth/auth_provvider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'logout_provider.g.dart';

@riverpod
Logout logout(LogoutRef ref) => Logout(auth: ref.watch(authProviderProvider));
