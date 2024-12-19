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
import 'package:pinput/pinput.dart';

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
        if (state is LogInProcess) {
          Dialogs(context).showLoadingDialog();
        } else if (state is LogInSuccess) {
          Navigator.of(context).pop();
          NavigationServices(context).pushChooseProfileScreen();
        } else if (state is LogInFailure) {
          Navigator.of(context).pop();
          Dialogs(context).showErrorDialog(message: state.error);
        }
      }, builder: (context, state) {
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
                      if (_validateAndLogin()) {
                        BlocProvider.of<LogInBloc>(context).add(LogInRequired(
                          email: emailController.text.trim(),
                          password: passwordController.text,
                        ));
                      }
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

  bool _validateAndLogin() {
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
      return false;
    }

    if (password.isEmpty) {
      setState(() {
        passwordError = "Password cannot be empty.";
      });
      return false;
    }

    return true;
  }

  Future<dynamic> forgotPasswordBottomSheet(BuildContext context) {
    String otpError = '';
    String otpCode = '';
    final otpController = TextEditingController();

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
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Text(
                              'Enter OTP',
                              style: TextStyles(context).getTitleStyle(
                                fontWeight: FontWeight.w500,
                                color: ColorPalette.deepBlue,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Center(
                              child: Pinput(
                                controller: otpController,
                                length: 6,
                                onCompleted: (pin) {
                                  otpCode = pin;
                                },
                                errorText: otpError,
                                defaultPinTheme: PinTheme(
                                  width: 50,
                                  height: 50,
                                  textStyle: const TextStyle(
                                      fontSize: 20, color: Colors.black),
                                  decoration: BoxDecoration(
                                    color: ColorPalette.whiteColor,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            CommonButton(
                              buttonTextWidget: Text(
                                'Verify OTP',
                                style: TextStyles(context).getTitleStyle(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              textColor: ColorPalette.whiteColor,
                              fontSize: 16,
                              radius: 30,
                              onTap: () {
                                if (otpCode.isEmpty || otpCode.length != 6) {
                                  setState(() {
                                    otpError =
                                        'Please enter a valid 6-digit OTP';
                                  });
                                  return;
                                }
                                // Verify OTP
                                context.read<ForgotPasswordBloc>().add(
                                    ForgotPasswordVerifyOTP(
                                        email: emailAccountController.text,
                                        otp: otpCode));
                              },
                            ),
                            BlocListener<ForgotPasswordBloc,
                                ForgotPasswordState>(
                              listener: (context, state) {
                                if (state is ForgotPasswordOTPVerified) {
                                  Navigator.pop(context);
                                  NavigationServices(context)
                                      .pushResetPasswordScreen();
                                } else if (state is ForgotPasswordOTPFailure) {
                                  Dialogs(context)
                                      .showErrorDialog(message: state.error);
                                }
                              },
                              child: Container(),
                            ),
                          ],
                        );
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
