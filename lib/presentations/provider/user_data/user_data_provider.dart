import 'dart:io';

import 'package:film_app/domain/entities/result.dart';
import 'package:film_app/domain/usecase/get_loged_in_user/get_loged_in_user.dart';
import 'package:film_app/domain/usecase/login/login.dart';
import 'package:film_app/domain/usecase/register/register.dart';
import 'package:film_app/domain/usecase/register/register_param.dart';
import 'package:film_app/domain/usecase/top_up/top_up.dart';
import 'package:film_app/domain/usecase/top_up/top_up_param.dart';
import 'package:film_app/domain/usecase/upload_profile_picture/upload_profile_picture.dart';
import 'package:film_app/domain/usecase/upload_profile_picture/upload_profile_picture_params.dart';
import 'package:film_app/presentations/provider/movie/now_playing_provider.dart';
import 'package:film_app/presentations/provider/movie/upcoming_provider.dart';
import 'package:film_app/presentations/provider/transaction_data/transaction_data_provider.dart';
import 'package:film_app/presentations/provider/usecase/get_logged_in_user_provider.dart';
import 'package:film_app/presentations/provider/usecase/login_provider.dart';
import 'package:film_app/presentations/provider/usecase/logout_provider.dart';
import 'package:film_app/presentations/provider/usecase/register_provider.dart';
import 'package:film_app/presentations/provider/usecase/top_up_provider.dart';
import 'package:film_app/presentations/provider/usecase/upload_profile_picture_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/entities/user.dart';
part 'user_data_provider.g.dart';

@Riverpod(keepAlive: true)
class UserData extends _$UserData {
  @override
  Future<User?> build() async {
    GetLogedInUser getLogedInUser = ref.read(getLogedInUserProvider);
    var userResult = await getLogedInUser(null);
    switch (userResult) {
      case Success(value: final user):
        _getMovie();
        return user;
      case Failed(message: _):
        return null;
    }
  }

  Future<void> login({required String email, required String password}) async {
    state = const AsyncLoading();
    Login login = ref.read(loginProvider);
    var result = await login(LoginParams(email: email, password: password));
    switch (result) {
      case Success(value: final user):
        _getMovie();
        state = AsyncData(user);
      case Failed(:final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = const AsyncData(null);
    }
  }

  Future<void> register(
      {required String email,
      required String password,
      required String name,
      String? image}) async {
    state = const AsyncLoading();
    Register register = ref.read(registerProvider);
    var resault = await register(
        RegisterParam(name: name, email: email, password: password));
    switch (resault) {
      case Success(value: final user):
        _getMovie();
        state = AsyncData(user);
      case Failed(:final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = const AsyncData(null);
    }
  }

  Future<void> refreshUserData() async {
    GetLogedInUser getLogedInUser = ref.read(getLogedInUserProvider);
    var resault = getLogedInUser(null);
    if (resault case Success(value: final user)) {
      state = AsyncData(user);
    }
  }

  Future<void> logout() async {
    var logout = ref.read(logoutProvider);
    var result = await logout(null);

    switch (result) {
      case Success(value: _):
        state = const AsyncData(null);
      case Failed(:final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = AsyncData(state.valueOrNull);
    }
  }

  Future<void> topUp(int amount) async {
    TopUp topUp = ref.read(topUpProvider);
    String? userId = state.valueOrNull?.uid;
    if (userId != null) {
      var resault = await topUp(TopUpParam(amount: amount, userId: userId));
      if (resault.isSuccess) {
        refreshUserData();
        ref.read(transactionDataProvider.notifier).refreshTransaction();
      }
    }
  }

  Future<void> uploadProfilePicture(
      {required User user, required File imageFile}) async {
    UploadProfilePicture uploadProfilePicture =
        ref.read(uploadProfilePictureProvider);

    var resault = await uploadProfilePicture(
        UploadProfilePictureParam(imageFile: imageFile, user: user));

    if (resault case Success(value: final user)) {
      state = AsyncData(user);
    }
  }

  void _getMovie() {
    ref.read(nowPlayingProvider.notifier).getMovies();
    ref.read(upcomingProvider.notifier).getMovies();
  }
}
