import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/screens/login_screen.dart';
import 'package:news_app/screens/signup_screen.dart';

class SignuporLogin extends ConsumerWidget {
  const SignuporLogin({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(isLoginorSignupProvider) ? SignupScreen() : LoginScreen();
  }
}

final isLoginorSignupProvider = StateProvider<bool>((ref) {
  return false;
});
