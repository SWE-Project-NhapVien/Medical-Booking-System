import 'package:booking_doctor_project/routes/patient/navigation_services.dart';
import 'package:booking_doctor_project/utils/localfiles.dart';
import 'package:booking_doctor_project/utils/text_styles.dart';
import 'package:booking_doctor_project/widgets/common_button.dart';
import 'package:flutter/material.dart';

import '../../../utils/color_palette.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: size.width / 3.5,
                child: Image.asset(
                  Localfiles.logoBlue,
                  fit: BoxFit.fitWidth,
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Text(
                'NhapVien',
                style: TextStyles(context).getTitleStyle(
                    size: 36, fontWeight: FontWeight.w100,color: ColorPalette.deepBlue),
              ),
              SizedBox(
                height: size.height * 0.001,
              ),
              Text(
                'Medical Booking System',
                style: TextStyles(context).getTitleStyle(
                    size: 18,
                    fontWeight: FontWeight.w400,
                    color: ColorPalette.deepBlue),
              ),
              SizedBox(
                height: size.height * 0.2,
              ),
              Text(
                '“A healthy outside starts from the inside.” -\nRobert Urich',
                textAlign: TextAlign.center,
                style: TextStyles(context).getDescriptionStyle(),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              CommonButton(
                buttonTextWidget: Text(
                  'Log In',
                  style: TextStyles(context).getTitleStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                onTap: () {
                  NavigationServices(context).pushLogInScreen();
                },
                width: size.width / 2,
                height: size.height * 0.06,
                radius: 30,
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              CommonButton(
                buttonTextWidget: Text(
                  'Sign Up',
                  style: TextStyles(context).getTitleStyle(
                    color: ColorPalette.deepBlue,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                onTap: () {
                  NavigationServices(context).pushSignUpScreen();
                },
                width: size.width / 2,
                height: size.height * 0.06,
                radius: 30,
                backgroundColor: ColorPalette.lightdeepBlue,
                bordeColor: ColorPalette.lightdeepBlue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
