import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/screens/signuporlogin.dart';
import 'package:news_app/services/auth_service.dart';
import 'package:news_app/services/user_service.dart';
import 'package:news_app/utils/colors.dart';
import 'package:news_app/utils/responsive.dart';

class SignupScreen extends ConsumerWidget {
  SignupScreen({super.key});
  final formkey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? validateEmail(String email) {
    RegExp emailregex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (email.isEmpty) {
      return "Please enter a email";
    } else {
      if (!emailregex.hasMatch(email)) {
        return "Please enter valid email";
      } else {
        return null;
      }
    }
  }

  String? validatePassword(String password) {
    RegExp passregex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (password.isEmpty) {
      return "Please enter a password";
    } else {
      if (!passregex.hasMatch(password)) {
        return "Please enter a valid password : It must contain at least one uppercase letter,one lowercase letter,one digit,one special character from the set !@#\$&*~,8 characters in length";
      } else {
        return null;
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              children: [
                Icon(
                  Icons.account_circle_outlined,
                  size: R.sw(120, context),
                ),
                Text(
                  'Create an account',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: R.sw(32, context)),
                ),
                SizedBox(
                  height: R.sh(20, context),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: R.sw(20, context)),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: usernameController,
                        cursorColor: primaryColor,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            hintText: "Username"),
                        validator: (name) => name!.length < 3
                            ? "username should be atleast 3 characters"
                            : null,
                      ),
                      SizedBox(
                        height: R.sh(20, context),
                      ),
                      TextFormField(
                        controller: emailController,
                        cursorColor: primaryColor,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.email), hintText: "Email"),
                        validator: (email) => validateEmail(email!),
                      ),
                      SizedBox(
                        height: R.sh(20, context),
                      ),
                      TextFormField(
                        controller: phoneController,
                        cursorColor: primaryColor,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.phone),
                            hintText: "Phone number"),
                        validator: (phone) => phone!.length != 10
                            ? "Mobile Number must be of 10 digit"
                            : null,
                      ),
                      SizedBox(
                        height: R.sh(20, context),
                      ),
                      TextFormField(
                        controller: countryController,
                        cursorColor: primaryColor,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.flag), hintText: "Country"),
                        validator: (country) {
                          if (country!.isEmpty) {
                            return "Please enter a country";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: R.sh(20, context),
                      ),
                      TextFormField(
                        controller: pinController,
                        cursorColor: primaryColor,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.pin), hintText: "Pin"),
                        validator: (pin) =>
                            pin!.length != 6 ? "Enter a valid pin" : null,
                      ),
                      SizedBox(
                        height: R.sh(20, context),
                      ),
                      TextFormField(
                        controller: passwordController,
                        cursorColor: primaryColor,
                        obscureText: true,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          hintText: "Password",
                          // helperMaxLines: 3,
                          errorMaxLines: 3,
                        ),
                        validator: (password) => validatePassword(password!),
                      ),
                      SizedBox(
                        height: R.sh(20, context),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: R.sh(10, context),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: tertiaryColor,
                        fixedSize: Size(R.sw(200, context), R.sh(50, context))),
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        UserCredential userCredential = await ref
                            .read(authServiceProvider)
                            .signup(
                                emailController.text, passwordController.text);
                        log(userCredential.user!.uid);
                        await ref.read(userServiceProvider).addUser(
                            usernameController.text,
                            emailController.text,
                            phoneController.text,
                            countryController.text,
                            pinController.text,
                            userCredential.user!.uid);
                      }
                    },
                    child: Text(
                      'Sign up',
                      style: TextStyle(fontSize: R.sw(20, context)),
                    )),
                SizedBox(
                  height: R.sh(24, context),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account!",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: R.sw(6, context),
                    ),
                    GestureDetector(
                      onTap: () {
                        ref.read(isLoginorSignupProvider.notifier).state =
                            false;
                      },
                      child: Text(
                        'Login',
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
      ),
    );
  }
}
