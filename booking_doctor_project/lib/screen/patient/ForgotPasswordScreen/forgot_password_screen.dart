import 'package:booking_doctor_project/bloc/patient/ResetPassword/reset_password_bloc.dart';
import 'package:booking_doctor_project/utils/color_palette.dart';
import 'package:booking_doctor_project/utils/text_styles.dart';
import 'package:booking_doctor_project/widgets/common_appbar_with_title.dart';
import 'package:booking_doctor_project/widgets/common_button.dart';
import 'package:booking_doctor_project/widgets/common_dialogs.dart';
import 'package:booking_doctor_project/widgets/textfield_with_label.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String error = '';
  bool newPassObscure = true;
  bool confirmPassObscure = true;

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: ColorPalette.whiteColor,
        body: BlocProvider(
          create: (context) => ResetPasswordBloc(),
          child: BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
              listener: (context, state) async {
            if (state is ResetPasswordProcess) {
              Dialogs(context).showLoadingDialog();
            } else if (state is ResetPasswordSuccess) {
              Navigator.of(context).pop();
              await Dialogs(context).showAnimatedDialog(
                title: 'Reset Password',
                content: 'Your password has been reset successfully.',
              );
              Navigator.of(context).popUntil((route) => route.isFirst);
            } else if (state is ResetPasswordFailure) {
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
                      title: 'Reset Password',
                      titleSize: 32,
                      topPadding: MediaQuery.of(context).padding.top,
                      prefixIconData: Icons.arrow_back_ios_new_rounded,
                      onPrefixIconClick: () {
                        Navigator.of(context)
                            .popUntil((route) => route.settings.name == '/login');
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    LabelAndTextField(
                        context: context,
                        label: 'New Password',
                        hintText: '',
                        controller: newPasswordController,
                        errorText: '',
                        suffixIconData: CupertinoIcons.eye_slash_fill,
                        selectedIconData: CupertinoIcons.eye_fill,
                        isObscured: newPassObscure),
                    LabelAndTextField(
                        context: context,
                        label: 'Confirm Password',
                        hintText: '',
                        controller: confirmPasswordController,
                        errorText: error,
                        suffixIconData: CupertinoIcons.eye_slash_fill,
                        selectedIconData: CupertinoIcons.eye_fill,
                        isObscured: confirmPassObscure),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Center(
                      child: CommonButton(
                        buttonTextWidget: Text(
                          'Reset Password',
                          style: TextStyles(context).getTitleStyle(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        onTap: () {
                          if (newPasswordController.text ==
                              confirmPasswordController.text) {
                            context.read<ResetPasswordBloc>().add(
                                  ResetPasswordRequired(
                                      newPassword: newPasswordController.text),
                                );
                          } else {
                            setState(() {
                              error = 'Confirm Password does not match.';
                            });
                          }
                        },
                        height: size.height * 0.06,
                        radius: 30,
                      ),
                    ),
                  ]),
            ));
          }),
        ));
  }
}
