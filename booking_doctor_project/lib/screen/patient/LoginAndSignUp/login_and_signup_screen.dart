import 'package:flutter/material.dart';

import '../LoginScreen/login_screen.dart';
import '../SignUpScreen/sign_up_screen.dart';

// ignore: must_be_immutable
class LoginOrSignUpScreen extends StatefulWidget {
  bool showLoginScreen;
  LoginOrSignUpScreen({super.key, required this.showLoginScreen});

  @override
  State<LoginOrSignUpScreen> createState() =>
      // ignore: no_logic_in_create_state
      _LoginOrSignUpScreenState(showLoginScreen: showLoginScreen);
}

class _LoginOrSignUpScreenState extends State<LoginOrSignUpScreen> {
  bool showLoginScreen;

  _LoginOrSignUpScreenState({required this.showLoginScreen});

  void toggleScreen() {
    setState(() {
      showLoginScreen = !showLoginScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginScreen) {
      return LoginScreen(
        onTap: toggleScreen,
      );
    } else {
      return SignUpScreen(
        onTap: toggleScreen,
      );
    }
  }
}
