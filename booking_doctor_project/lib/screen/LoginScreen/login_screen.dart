import 'package:booking_doctor_project/screen/LoginAndSignUp/login_and_signup_screen.dart';
import 'package:booking_doctor_project/screen/LoginScreen/choose_profile_screen.dart';
import 'package:booking_doctor_project/utils/themes.dart';
import 'package:booking_doctor_project/widgets/bottom_move_top_animation.dart';
import 'package:booking_doctor_project/widgets/textfield_with_label.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/text_styles.dart';
import '../../widgets/common_appbar_with_title.dart';
import '../../widgets/common_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
    required this.onTap,
  });

  final Function() onTap;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorPalette.whiteColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonAppBarWithTitle(
                title: 'Log In',
                titleSize: 32,
                topPadding: MediaQuery.of(context).padding.top,
                prefixIconData: Icons.arrow_back_ios_new_rounded,
                onPrefixIconClick: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Text(
                "Welcome",
                style: TextStyles(context).getTitleStyle(
                    fontWeight: FontWeight.w500, color: ColorPalette.blueColor),
              ),
              Text(
                "“A healthy outside starts from the inside.” - Robert Urich",
                style: TextStyles(context).getDescriptionStyle(),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              LabelAndTextField(
                context: context,
                label: 'Email Or Phone Number',
                hintText: 'example@example.com',
                controller: emailController,
                errorText: '',
              ),
              LabelAndTextField(
                context: context,
                label: 'Password',
                hintText: '********',
                controller: passwordController,
                errorText: '',
                suffixIconData: CupertinoIcons.eye_slash_fill,
                selectedIconData: CupertinoIcons.eye_fill,
                isObscured: obscurePassword,
              ),
              TapEffect(
                onClick: () {},
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    'Forget Password',
                    style: TextStyles(context).getRegularStyle(
                      color: ColorPalette.blueColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Center(
                child: CommonButton(
                  buttonTextWidget: Text(
                    'Log In',
                    style: TextStyles(context).getTitleStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChooseProfileScreen()),
                    );
                  },
                  width: size.width / 2,
                  height: size.height * 0.06,
                  radius: 30,
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don’t have an account? ',
                    style: TextStyles(context)
                        .getRegularStyle(fontWeight: FontWeight.w200),
                  ),
                  TapEffect(
                    onClick: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginOrSignUpScreen(
                            showLoginScreen: false,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyles(context).getRegularStyle(
                        color: ColorPalette.blueColor,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
