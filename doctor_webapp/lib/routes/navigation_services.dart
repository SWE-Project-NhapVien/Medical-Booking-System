import 'package:doctor_webapp/screen/handle_page_view.dart';
import 'package:doctor_webapp/screen/login/login_screen.dart';
import 'package:doctor_webapp/screen/reset_password/reset_password.dart';
import 'package:flutter/material.dart';

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

  Future<dynamic> pushResetPasswordScreen() {
    return _pushMaterialPageRoute(const ResetPasswordScreen());
  }

  Future<dynamic> pushHandlePageView() {
    return _pushMaterialPageRoute(const HandlePageView());
  }

  void popUntilLogin() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (Route<dynamic> route) => false,
    );
  }
}
