import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/screens/signuporlogin.dart';
import 'package:news_app/services/auth_service.dart';
import 'package:news_app/utils/colors.dart';
import 'package:news_app/utils/responsive.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  final formkey = GlobalKey<FormState>();
  String? validatePassword(String password) {
    RegExp passregex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (password.isEmpty) {
      return "Please enter a password";
    } else {
      if (!passregex.hasMatch(password)) {
        return "Please enter a valid password";
      } else {
        return null;
      }
    }
  }

  String? validateEmail(String email) {
    RegExp emailregex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (email.isEmpty) {
      return "email is not coreect";
    } else {
      if (!emailregex.hasMatch(email)) {
        return "Password is not correct";
      } else {
        return null;
      }
    }
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Form(
          key: formkey,
          child: Column(
            children: [
              SizedBox(
                height: R.sh(30, context),
              ),
              SizedBox(
                height: R.sh(200, context),
                child: Image.asset("assets/logo.png"),
              ),
              SizedBox(
                height: R.sh(20, context),
              ),
              Text(
                'Welcome back',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: R.sw(28, context),
                    color: primaryColor),
              ),
              SizedBox(
                height: R.sh(16, context),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: R.sw(20, context)),
                child: TextFormField(
                  cursorColor: primaryColor,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email), hintText: "Email"),
                  validator: (email) => validateEmail(email!),
                ),
              ),
              SizedBox(
                height: R.sh(10, context),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: R.sw(20, context)),
                child: TextFormField(
                  obscureText: true,
                  cursorColor: primaryColor,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      hintText: "Password",
                      errorMaxLines: 3),
                  validator: (password) => validatePassword(password!),
                ),
              ),
              SizedBox(
                height: R.sh(30, context),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: tertiaryColor,
                      fixedSize: Size(R.sw(200, context), R.sh(50, context))),
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      await ref
                          .read(authServiceProvider)
                          .login(emailController.text, passwordController.text);
                    }
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: R.sw(20, context)),
                  )),
              SizedBox(
                height: R.sh(30, context),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: R.sw(6, context),
                  ),
                  GestureDetector(
                    onTap: () =>
                        ref.read(isLoginorSignupProvider.notifier).state = true,
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: primaryColor),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
