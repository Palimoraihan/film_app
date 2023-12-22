import 'package:film_app/data/dummyes/dummy_auth.dart';
import 'package:film_app/data/dummyes/dummy_user_repository.dart';
import 'package:film_app/data/firebase/firebase_auth.dart';
import 'package:film_app/data/firebase/firebase_user_repository.dart';
import 'package:film_app/domain/usecase/login/login.dart';
import 'package:film_app/presentations/provider/usecase/login_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:film_app/presentations/page/main_page/main_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              // Login login = Login(
              //     auth: FirebaseAuths(), userRepository: FirebaseUserRepository());

              Login login = ref.watch(loginProvider);

              login(LoginParams(email: 'test@test.com', password: '123456789'))
                  .then((value) {
                if (value.isSuccess) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MainPage(user: value.resultValue!),
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(value.errorMessage!)));
                }
              });
            },
            child: Text('Login')),
      ),
    );
  }
}
