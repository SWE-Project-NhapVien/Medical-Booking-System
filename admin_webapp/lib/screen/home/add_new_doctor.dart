import 'package:admin_webapp/bloc/CreateNewAccount/create_new_account_bloc.dart';
import 'package:admin_webapp/utils/text_styles.dart';
import 'package:admin_webapp/widgets/common_button.dart';
import 'package:admin_webapp/widgets/textfield_with_label.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewDoctor extends StatefulWidget {
  const AddNewDoctor({super.key});

  @override
  State<AddNewDoctor> createState() => _AddNewDoctorState();
}

class _AddNewDoctorState extends State<AddNewDoctor> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final emailController = TextEditingController();
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  String? emailError;
  String? passwordError;
  String? confirmPasswordError;
  String? error;

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
    return SizedBox(
      width: size.width * 0.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LabelAndTextField(
            context: context,
            label: 'Email',
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
          SizedBox(
            height: size.height * 0.02,
          ),
          Center(
            child: SizedBox(
              width: size.width * 0.2,
              child: CommonButton(
                buttonTextWidget: Text(
                  'Create',
                  style: TextStyles(context).getTitleStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                onTap: () {
                  _onSignUp();
                },
                height: size.height * 0.06,
                radius: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onSignUp() {
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
      context.read<CreateNewAccountBloc>().add(
            CreateNewAccountRequired(
              email: emailController.text.trim(),
              password: passwordController.text,
            ),
          );
    } else {
      setState(() {});
    }
  }
}
