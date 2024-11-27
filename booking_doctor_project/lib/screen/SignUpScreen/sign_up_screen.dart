import 'package:booking_doctor_project/screen/CreateProfileScreen/create_profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/text_styles.dart';
import '../../utils/themes.dart';
import '../../widgets/common_appbar_with_title.dart';
import '../../widgets/common_button.dart';
import '../../widgets/tap_effect.dart';
import '../../widgets/textfield_with_label.dart';
import '../LoginAndSignUp/login_and_signup_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key, required this.onTap});

  final Function() onTap;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final emailController = TextEditingController();
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorPalette.whiteColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CommonAppBarWithTitle(
                title: 'New Account',
                titleSize: 32,
                topPadding: MediaQuery.of(context).padding.top,
                prefixIconData: Icons.arrow_back_ios_new_rounded,
                onPrefixIconClick: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: size.height * 0.03,
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
              LabelAndTextField(
                context: context,
                label: 'Confirm Password',
                hintText: '********',
                controller: confirmPasswordController,
                errorText: '',
                suffixIconData: CupertinoIcons.eye_slash_fill,
                selectedIconData: CupertinoIcons.eye_fill,
                isObscured: obscureConfirmPassword,
              ),
              Text('By continuing, you agree to',
                  style: TextStyles(context).getRegularStyle(
                    fontWeight: FontWeight.w300,
                  )),
              Text.rich(TextSpan(children: [
                TextSpan(
                  text: 'Terms of Service',
                  style: TextStyles(context).getRegularStyle(
                    color: ColorPalette.blueColor,
                  ),
                ),
                TextSpan(
                    text: ' and ',
                    style: TextStyles(context).getRegularStyle(
                      fontWeight: FontWeight.w300,
                    )),
                TextSpan(
                  text: 'Privacy Policy',
                  style: TextStyles(context).getRegularStyle(
                    color: ColorPalette.blueColor,
                  ),
                ),
              ])),
              SizedBox(
                height: size.height * 0.02,
              ),
              Center(
                child: CommonButton(
                  buttonTextWidget: Text(
                    'Sign Up',
                    style: TextStyles(context).getTitleStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CreateProfileScreen(),
                      ),
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
                    'Already have an account? ',
                    style: TextStyles(context)
                        .getRegularStyle(fontWeight: FontWeight.w200),
                  ),
                  TapEffect(
                    onClick: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginOrSignUpScreen(
                            showLoginScreen: true,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'Log In',
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
