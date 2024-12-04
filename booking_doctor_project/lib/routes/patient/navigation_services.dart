import 'package:booking_doctor_project/screen/patient/CreateProfileScreen/create_profile_screen.dart';
import 'package:flutter/material.dart';

import '../../screen/patient/LoginAndSignUp/login_and_signup_screen.dart';

class NavigationServices {
  final BuildContext context;
  NavigationServices(this.context);

  Future<dynamic> _pushMaterialPageRoute(Widget widget,
      {bool fullscreenDialog = false}) async {
    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => widget, fullscreenDialog: fullscreenDialog));
  }

  Future<dynamic> pushLogInScreen() async {
    return _pushMaterialPageRoute(LoginOrSignUpScreen(showLoginScreen: true));
  }

  Future<dynamic> pushSignUpScreen() async {
    return _pushMaterialPageRoute(LoginOrSignUpScreen(showLoginScreen: false));
  }

  Future<dynamic> pushCompleteProfileScreen() async {
    return _pushMaterialPageRoute(const CreateProfileScreen());
  }

  void popUntilLoginScreen() {
    Navigator.of(context).popUntil((route) => route.settings.name == '/login');
    // Navigator.popUntil(context, ModalRoute.withName('/login'));
  }
}
