import 'package:booking_doctor_project/bloc/patient/ForgotPassword/forgot_password_bloc.dart';
import 'package:booking_doctor_project/bloc/patient/LogIn/log_in_bloc.dart';
import 'package:booking_doctor_project/routes/patient/navigation_services.dart';
import 'package:booking_doctor_project/utils/localfiles.dart';
import 'package:booking_doctor_project/widgets/common_dialogs.dart';
import 'package:booking_doctor_project/widgets/textfield_with_label.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/color_palette.dart';
import '../../../utils/text_styles.dart';
import '../../../widgets/common_appbar_with_title.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/tap_effect.dart';

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
  final emailAccountController = TextEditingController(); //Forgot Pass
  bool obscurePassword = true;
  String emailError = '';
  String passwordError = '';
  String error = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<ForgotPasswordBloc>().add(ForgotPasswordReset());
    context.read<LogInBloc>().add(const LogInReset());
  }

  @override
  void dispose() {
    passwordController.dispose();
    emailAccountController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorPalette.whiteColor,
      body: BlocConsumer<LogInBloc, LogInState>(listener: (context, state) {
        if (state is LogInSuccess) {
          NavigationServices(context).pushChooseProfileScreen();
        } else if (state is LogInFailure) {
          setState(() {
            error = state.error;
          });
        }
      }, builder: (context, state) {
        if (state is LogInProcess) {
          return AlertDialog(
              backgroundColor: Colors.transparent,
              content: Lottie.asset(
                Localfiles.loading,
                width: size.width * 0.2,
              ));
        }
        return SingleChildScrollView(
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
                      fontWeight: FontWeight.w500,
                      color: ColorPalette.deepBlue),
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
                  errorText: emailError,
                ),
                LabelAndTextField(
                  context: context,
                  label: 'Password',
                  hintText: '********',
                  controller: passwordController,
                  errorText: passwordError,
                  suffixIconData: CupertinoIcons.eye_slash_fill,
                  selectedIconData: CupertinoIcons.eye_fill,
                  isObscured: obscurePassword,
                ),
                TapEffect(
                  onClick: () async {
                    await forgotPasswordBottomSheet(context);
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      'Forgot Password',
                      style: TextStyles(context).getRegularStyle(
                        color: ColorPalette.deepBlue,
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
                      _validateAndLogin();
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
                        NavigationServices(context).pushSignUpScreen();
                      },
                      child: Text(
                        'Sign Up',
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
      }),
    );
  }

  void _validateAndLogin() {
    final email = emailController.text.trim();
    final password = passwordController.text;

    setState(() {
      emailError = '';
      passwordError = '';
    });

    if (email.isEmpty) {
      setState(() {
        emailError = "Email cannot be empty.";
      });
      return;
    }

    if (password.isEmpty) {
      setState(() {
        passwordError = "Password cannot be empty.";
      });
      return;
    }

    if (error.isNotEmpty) {
      Dialogs(context).showAnimatedDialog(title: 'Error', content: error);
      return;
    }

    BlocProvider.of<LogInBloc>(context).add(LogInRequired(
      email: email,
      password: password,
    ));
  }

  Future<dynamic> forgotPasswordBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: ColorPalette.whiteColor,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabelAndTextField(
                      context: context,
                      label: 'Email',
                      hintText: 'example@gmail.com',
                      controller: emailAccountController,
                      errorText: ''),
                  CommonButton(
                    buttonTextWidget: Text(
                      'Send',
                      style: TextStyles(context).getTitleStyle(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    textColor: ColorPalette.whiteColor,
                    fontSize: 16,
                    radius: 30,
                    onTap: () {
                      final email = emailAccountController.text;
                      context
                          .read<ForgotPasswordBloc>()
                          .add(ForgotPasswordRequired(email: email));
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                    builder: (context, state) {
                      if (state is ForgotPasswordProcess) {
                        return Center(
                          child: AlertDialog(
                            backgroundColor: Colors.transparent,
                            content: Lottie.asset(
                              Localfiles.loading,
                              width: 100,
                            ),
                          ),
                        );
                      } else if (state is ForgotPasswordSuccess) {
                        return Center(
                            child: Text(
                          'Please check your email to reset password.',
                          style: TextStyles(context)
                              .getRegularStyle(color: ColorPalette.deepBlue),
                        ));
                      } else if (state is ForgotPasswordFailure) {
                        return Center(
                            child: Text(
                          state.error,
                          style: TextStyles(context)
                              .getRegularStyle(color: ColorPalette.redColor),
                        ));
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
