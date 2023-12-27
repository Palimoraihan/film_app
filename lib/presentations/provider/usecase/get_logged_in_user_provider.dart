import 'package:film_app/domain/usecase/get_loged_in_user/get_loged_in_user.dart';
import 'package:film_app/presentations/provider/repositories/auth/auth_provvider.dart';
import 'package:film_app/presentations/provider/repositories/user_repository/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_logged_in_user_provider.g.dart';

@riverpod
GetLogedInUser getLogedInUser(GetLogedInUserRef ref) => GetLogedInUser(
    auth: ref.watch(authProviderProvider),
    userRepository: ref.watch(userRepositoryProvider));
