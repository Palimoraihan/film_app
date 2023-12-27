import 'package:film_app/presentations/extensions/build_extensions.dart';
import 'package:film_app/presentations/misc/method.dart';
import 'package:film_app/presentations/provider/router/router_provider.dart';
import 'package:film_app/presentations/provider/user_data/user_data_provider.dart';
import 'package:film_app/presentations/widget/custome_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class LoginPage extends ConsumerWidget {
  final TextEditingController emailController =
      TextEditingController(text: 'test@test.com');
  final TextEditingController passwordController =
      TextEditingController(text: '123456789');

  LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      userDataProvider,
      (previous, next) {
        if (next is AsyncData) {
          if (next.value != null) {
            ref.read(routerProvider).goNamed('main');
          }
        } else if (next is AsyncError) {
          context.showSnacBar(next.error.toString());
        }
      },
    );
    return Scaffold(
      body: ListView(
        children: [
          verticalSpace(100),
          Center(
            child: Image.asset(
              'assets/image/flix_logo.png',
              width: 150,
            ),
          ),
          verticalSpace(100),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            child: Column(
              children: [
                CustomeTextField(
                    labelText: 'email', controller: emailController),
                verticalSpace(24),
                CustomeTextField(
                  labelText: 'password',
                  controller: passwordController,
                  obsecureText: true,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Forgot Password ?',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      )),
                ),
                verticalSpace(24),
                switch (ref.watch(userDataProvider)) {
                  AsyncData(:final value) => value == null
                      ? SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                ref.read(userDataProvider.notifier).login(
                                    email: emailController.text,
                                    password: passwordController.text);

                                ///DOCUMENTATION EXAMPLE
                                // Login login = Login(
                                //     auth: FirebaseAuths(), userRepository: FirebaseUserRepository());

                                // Login login = ref.watch(loginProvider);

                                // login(LoginParams(email: 'test@test.com', password: '123456789'))
                                //     .then((value) {
                                //   if (value.isSuccess) {
                                //     Navigator.of(context).push(MaterialPageRoute(
                                //       builder: (context) => MainPage(user: value.resultValue!),
                                //     ));
                                //   } else {
                                //     ScaffoldMessenger.of(context).showSnackBar(
                                //         SnackBar(content: Text(value.errorMessage!)));
                                //   }
                                // });
                              },
                              child: const Text('Login')),
                        )
                      : const CircularProgressIndicator(),
                  _ => const CircularProgressIndicator()
                },
                verticalSpace(24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have account'),
                    TextButton(
                        onPressed: () {
                          ref.read(routerProvider).goNamed('register');
                        },
                        child: const Text(
                          'Register here',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ))
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
