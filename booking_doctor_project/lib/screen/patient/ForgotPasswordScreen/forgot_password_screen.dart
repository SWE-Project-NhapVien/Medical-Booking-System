import 'package:booking_doctor_project/routes/patient/navigation_services.dart';
import 'package:booking_doctor_project/utils/color_palette.dart';
import 'package:booking_doctor_project/utils/text_styles.dart';
import 'package:booking_doctor_project/widgets/common_appbar_with_title.dart';
import 'package:booking_doctor_project/widgets/common_button.dart';
import 'package:booking_doctor_project/widgets/common_dialogs.dart';
import 'package:booking_doctor_project/widgets/textfield_with_label.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: ColorPalette.whiteColor,
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CommonAppBarWithTitle(
              title: 'Reset Password',
              titleSize: 32,
              topPadding: MediaQuery.of(context).padding.top,
              prefixIconData: Icons.arrow_back_ios_new_rounded,
              onPrefixIconClick: () {
                NavigationServices(context).popUntilLoginScreen();
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
                isObscured: true),
            LabelAndTextField(
                context: context,
                label: 'Confirm Password',
                hintText: '',
                controller: confirmPasswordController,
                errorText: error,
                isObscured: true),
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
                    resetPassword();
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
        )));
  }

  void resetPassword() async {
    try {
      await Supabase.instance.client.auth
          .updateUser(UserAttributes(password: newPasswordController.text));
      await Dialogs(context).showAnimatedDialog(
        title: 'Reset Password',
        content: 'Password has been reset successfully.',
      );
      NavigationServices(context).popUntilLoginScreen();
    } catch (e) {
      throw Exception('Failed to reset password: $e');
    }
  }
}
