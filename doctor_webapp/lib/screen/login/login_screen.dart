import 'package:doctor_webapp/bloc/DoctorLogin/doctor_login_bloc.dart';
import 'package:doctor_webapp/bloc/ForgotPassword/forgot_password_bloc.dart';
import 'package:doctor_webapp/routes/navigation_services.dart';
import 'package:doctor_webapp/utils/color_palette.dart';
import 'package:doctor_webapp/utils/localfiles.dart';
import 'package:doctor_webapp/utils/text_styles.dart';
import 'package:doctor_webapp/widgets/common_dialogs.dart';
import 'package:doctor_webapp/widgets/comon_button.dart';
import 'package:doctor_webapp/widgets/tap_effect.dart';
import 'package:doctor_webapp/widgets/textfield_with_label.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

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
  void dispose() {
    passwordController.dispose();
    emailAccountController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(children: [
      Expanded(
        child: _buildLeftSide(size),
      ),
      Expanded(
        child: _buildLoginForm(size),
      ),
    ]);
  }

  Widget _buildLeftSide(Size size) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
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
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: size.width / 6,
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
    );
  }

  Widget _buildLoginForm(Size size) {
    return BlocConsumer<DoctorLoginBloc, DoctorLoginState>(
      listener: (context, state) async {
        if (state is DoctorLoginProcess) {
          Dialogs(context).showLoadingDialog();
        } else if (state is DoctorLoginSuccess) {
          Navigator.of(context).pop();
          await Dialogs(context).showAnimatedDialog(
            title: 'Success',
            content: 'Login Successful',
          );
          NavigationServices(context).pushHomeScreen();
        } else if (state is DoctorLoginFailure) {
          Navigator.of(context).pop();
          Dialogs(context).showErrorDialog(message: state.error);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorPalette.whiteColor,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(size.width * 0.1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome",
                    style: TextStyles(context).getTitleStyle(
                        fontWeight: FontWeight.w500,
                        color: ColorPalette.deepBlue),
                  ),
                  Text(
                    "“Wear the white coat with dignity and pride—it is an honor and privilege to get to serve the public as a physician.”  - Bill H. Warren",
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
                      await showAnimatedForgotPasswordForm(context, size);
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
                          BlocProvider.of<DoctorLoginBloc>(context).add(
                            DoctorLoginRequired(
                              email: emailController.text,
                              password: passwordController.text,
                            ),
                          );
                        }
                      },
                      width: size.width / 6,
                      height: size.height * 0.07,
                      radius: 30,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.001),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don’t have an account? ',
                          style: TextStyles(context)
                              .getRegularStyle(fontWeight: FontWeight.w200),
                        ),
                        TapEffect(
                          onClick: () {
                            //
                          },
                          child: Text(
                            'Contact the Admin',
                            style: TextStyles(context).getRegularStyle(
                              color: ColorPalette.deepBlue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
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

  Future<dynamic> showAnimatedForgotPasswordForm(
      BuildContext context, Size size) {
    return showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: '',
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (content, animation1, animation2) {
          return Container();
        },
        transitionBuilder: (context, a1, a2, widget) {
          return ScaleTransition(
            scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
            child: FadeTransition(
              opacity: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
              child: StatefulBuilder(
                builder: (context, setDialogState) {
                  return AlertDialog(
                    backgroundColor: ColorPalette.whiteColor,
                    icon: Icon(
                      Icons.lock,
                      size: 20,
                      color: ColorPalette.deepBlue,
                    ),
                    iconPadding: const EdgeInsets.only(top: 16),
                    title: Text(
                      'Enter your email to reset password',
                      style: TextStyles(context).getTitleStyle(
                          size: 20,
                          fontWeight: FontWeight.w500,
                          color: ColorPalette.deepBlue),
                    ),
                    titlePadding: const EdgeInsets.only(top: 16),
                    scrollable: true,
                    content: SizedBox(
                      height: size.height * 0.25,
                      width: size.width * 0.3,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            LabelAndTextField(
                                context: context,
                                height: size.height * 0.13,
                                label: 'Email',
                                hintText: 'example@gmail.com',
                                controller: emailAccountController,
                                errorText: ''),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: CommonButton(
                                buttonTextWidget: Text(
                                  'Send',
                                  style: TextStyles(context).getTitleStyle(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                textColor: ColorPalette.whiteColor,
                                fontSize: 16,
                                radius: 15,
                                onTap: () {
                                  final email =
                                      emailAccountController.text.trim();
                                  context.read<ForgotPasswordBloc>().add(
                                      ForgotPasswordRequired(email: email));
                                },
                              ),
                            ),
                            BlocBuilder<ForgotPasswordBloc,
                                ForgotPasswordState>(
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
                                  Navigator.of(context).pop();
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    showAnimatedOTPForm(context, size,
                                        emailAccountController.text.trim());
                                  });
                                } else if (state is ForgotPasswordFailure) {
                                  return Text(
                                    state.error,
                                    style: TextStyles(context)
                                        .getRegularStyle(
                                          size: 16,
                                          color: ColorPalette.redColor,
                                        )
                                        .copyWith(fontStyle: FontStyle.italic),
                                  );
                                }
                                return Container();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none),
                  );
                },
              ),
            ),
          );
        });
  }

  Future<dynamic> showAnimatedOTPForm(
      BuildContext context, Size size, String email) {
    final otpController = TextEditingController();
    String otpError = '';
    String otpCode = '';

    return showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: '',
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (content, animation1, animation2) {
          return Container();
        },
        transitionBuilder: (context, a1, a2, widget) {
          return ScaleTransition(
            scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
            child: FadeTransition(
              opacity: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
              child: StatefulBuilder(
                builder: (context, setDialogState) {
                  return AlertDialog(
                    backgroundColor: ColorPalette.whiteColor,
                    icon: Icon(
                      Icons.lock,
                      size: 20,
                      color: ColorPalette.deepBlue,
                    ),
                    iconPadding: const EdgeInsets.only(top: 16),
                    title: Text(
                      'OTP Verification',
                      style: TextStyles(context).getTitleStyle(
                          size: 20,
                          fontWeight: FontWeight.w500,
                          color: ColorPalette.deepBlue),
                    ),
                    titlePadding: const EdgeInsets.only(top: 16),
                    scrollable: true,
                    content: SizedBox(
                      height: size.height * 0.25,
                      width: size.width * 0.3,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              'Please check your email for OTP',
                              style: TextStyles(context)
                                  .getRegularStyle(
                                    size: 16,
                                    color: ColorPalette.deepBlue,
                                  )
                                  .copyWith(fontStyle: FontStyle.italic),
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Pinput(
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: CommonButton(
                                buttonTextWidget: Text(
                                  'Send',
                                  style: TextStyles(context).getTitleStyle(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                textColor: ColorPalette.whiteColor,
                                fontSize: 16,
                                radius: 15,
                                onTap: () {
                                  final otpCode = otpController.text;
                                  context.read<ForgotPasswordBloc>().add(
                                      ForgotPasswordVerifyOTP(
                                          email: email, otp: otpCode));
                                },
                              ),
                            ),
                            BlocBuilder<ForgotPasswordBloc,
                                ForgotPasswordState>(
                              builder: (context, state) {
                                if (state is ForgotPasswordOTPVerified) {
                                  Navigator.of(context).pop();
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    NavigationServices(context)
                                        .pushResetPasswordScreen();
                                  });
                                } else if (state is ForgotPasswordFailure) {
                                  return Text(
                                    state.error,
                                    style: TextStyles(context)
                                        .getRegularStyle(
                                          size: 16,
                                          color: ColorPalette.redColor,
                                        )
                                        .copyWith(fontStyle: FontStyle.italic),
                                  );
                                }
                                return Container();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none),
                  );
                },
              ),
            ),
          );
        });
  }
}
