import 'package:film_app/presentations/extensions/build_extensions.dart';
import 'package:film_app/presentations/misc/method.dart';
import 'package:film_app/presentations/provider/router/router_provider.dart';
import 'package:film_app/presentations/provider/user_data/user_data_provider.dart';
import 'package:film_app/presentations/widget/custome_text_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ref.listen(userDataProvider, (previous, next) {
      if (next is AsyncData && next.value != null) {
        ref.read(routerProvider).goNamed('main');
      } else if (next is AsyncError) {
        context.showSnacBar(next.error.toString());
      }
    });
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              verticalSpace(50),
              Center(
                child: Image.asset(
                  'assets/image/flix_logo.png',
                  width: 150,
                ),
              ),
              verticalSpace(50),
              const CircleAvatar(
                radius: 50,
                child: Icon(
                  Icons.add_a_photo,
                  size: 50,
                  color: Colors.white,
                ),
              ),
              verticalSpace(24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    CustomeTextField(
                        labelText: 'Email', controller: emailController),
                    verticalSpace(24),
                    CustomeTextField(
                        labelText: 'Name', controller: nameController),
                    verticalSpace(24),
                    CustomeTextField(
                      labelText: 'Password',
                      controller: passwordController,
                      obsecureText: true,
                    ),
                    verticalSpace(24),
                    CustomeTextField(
                      labelText: 'Confirm Password',
                      controller: confirmPasswordController,
                      obsecureText: true,
                    ),
                    verticalSpace(24),
                    switch (ref.watch(userDataProvider)) {
                      AsyncData(:final value) => value == null
                          ? SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: () {
                                    if (passwordController.text ==
                                        confirmPasswordController.text) {
                                      ref
                                          .read(userDataProvider.notifier)
                                          .register(
                                              email: emailController.text,
                                              password: passwordController.text,
                                              name: nameController.text);
                                    } else {
                                      context.showSnacBar(
                                          'Please add same value password');
                                    }
                                  },
                                  child: const Text(
                                    'Register',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  )),
                            )
                          : const Center(
                              child: CircularProgressIndicator(),
                            ),
                      _ => const Center(
                          child: CircularProgressIndicator(),
                        )
                    },
                    verticalSpace(24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Alredy have an account ?'),
                        TextButton(
                            onPressed: () {
                              ref.read(routerProvider).goNamed('login');
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
