import 'package:doctor_webapp/screen/home/home_screen.dart';
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

  Future<dynamic> pushHomeScreen() {
    return _pushMaterialPageRoute(const HomeScreen());
  }
}
