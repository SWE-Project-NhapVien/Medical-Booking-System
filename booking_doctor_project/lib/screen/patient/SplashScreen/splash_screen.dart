import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:booking_doctor_project/utils/text_styles.dart';
import 'package:booking_doctor_project/utils/localfiles.dart';
import 'package:flutter/material.dart';
import '../WelcomeScreen/welcome_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FlutterSplashScreen.scale(
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white,
          Color.fromARGB(255, 212, 235, 248),
          Color.fromARGB(255, 128, 196, 233),
          Color.fromARGB(255, 31, 80, 154),
          Color.fromARGB(255, 10, 57, 129),
        ],
      ),
      childWidget: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: size.width / 3.5,
            child: Image.asset(
              Localfiles.logo,
              fit: BoxFit.fitWidth,
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Text(
            'NhapVien',
            style: TextStyles(context).getTitleStyle(size: 36),
          ),
          SizedBox(
            height: size.height * 0.001,
          ),
          Text(
            'Medical Booking System',
            style: TextStyles(context)
                .getTitleStyle(size: 18, fontWeight: FontWeight.w500),
          ),
        ],
      ),
      duration: const Duration(milliseconds: 2500),
      animationDuration: const Duration(milliseconds: 2000),
      nextScreen: const WelcomeScreen(),
    );
  }
}