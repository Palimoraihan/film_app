import 'package:film_app/data/firebase/firebase_auth.dart';
import 'package:film_app/data/repository/auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth_provvider.g.dart';

@riverpod
Auth authProvider(AuthProviderRef ref) => FirebaseAuths();
