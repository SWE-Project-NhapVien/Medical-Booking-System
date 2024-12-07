import 'package:booking_doctor_project/bloc/patient/SignUp/sign_up_bloc.dart';
import 'package:booking_doctor_project/routes/patient/navigation_services.dart';
import 'package:booking_doctor_project/widgets/common_dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/color_palette.dart';
import '../../../utils/text_styles.dart';
import '../../../widgets/common_appbar_with_title.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/tap_effect.dart';
import '../../../widgets/textfield_with_label.dart';
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

  String? emailError;
  String? passwordError;
  String? confirmPasswordError;
  String? error;

  void _onSignUp(BuildContext context) {
    setState(() {
      emailError = null;
      passwordError = null;
      confirmPasswordError = null;
      error = null;
    });

    bool isValid = true;

    if (emailController.text.isEmpty) {
      emailError = 'Email is required';
      isValid = false;
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(emailController.text)) {
      emailError = 'Enter a valid email';
      isValid = false;
    }

    if (passwordController.text.isEmpty) {
      passwordError = 'Password is required';
      isValid = false;
    } else if (passwordController.text.length < 6) {
      passwordError = 'Password must be at least 6 characters';
      isValid = false;
    } else if (!passwordController.text.contains(RegExp(r'[0-9]')) ||
        !passwordController.text.contains(RegExp(r'[A-Z]')) ||
        !passwordController.text.contains(RegExp(r'[a-z]'))) {
      passwordError =
          'Password must contain at least 1 uppercase, 1 lowercase letter and a number';
      isValid = false;
    }

    if (confirmPasswordController.text.isEmpty) {
      confirmPasswordError = 'Confirm password is required';
      isValid = false;
    } else if (confirmPasswordController.text != passwordController.text) {
      confirmPasswordError = 'Passwords do not match';
      isValid = false;
    }

    if (isValid) {
      context.read<SignUpBloc>().add(
            SignUpRequired(
              email: emailController.text.trim(),
              password: passwordController.text,
            ),
          );
    } else {
      setState(() {});
    }
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: ColorPalette.whiteColor,
        body: BlocConsumer<SignUpBloc, SignUpState>(
            listener: (context, state) async {
          if (state is SignUpSuccess) {
            await Dialogs(context).showAnimatedDialog(
              title: 'Sign Up Successful',
              content: 'Please complete your profile to continue.',
            );
            NavigationServices(context).pushCompleteProfileScreen();
          } else if (state is SignUpFailure) {
            Dialogs(context).showErrorDialog(message: state.error);
          }
        }, builder: (context, state) {
          return SingleChildScrollView(
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
                    errorText: emailError ?? '',
                  ),
                  LabelAndTextField(
                    context: context,
                    label: 'Password',
                    hintText: '********',
                    controller: passwordController,
                    errorText: passwordError ?? '',
                    suffixIconData: CupertinoIcons.eye_slash_fill,
                    selectedIconData: CupertinoIcons.eye_fill,
                    isObscured: obscurePassword,
                  ),
                  LabelAndTextField(
                    context: context,
                    label: 'Confirm Password',
                    hintText: '********',
                    controller: confirmPasswordController,
                    errorText: confirmPasswordError ?? '',
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
                        color: ColorPalette.deepBlue,
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
                        color: ColorPalette.deepBlue,
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
                        _onSignUp(context);
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
                            color: ColorPalette.deepBlue,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }));
  }
}
