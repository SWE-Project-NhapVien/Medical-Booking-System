import 'package:admin_webapp/bloc/CreateNewAccount/create_new_account_bloc.dart';
import 'package:admin_webapp/bloc/GetAllPatients/get_all_patients_bloc.dart';
import 'package:admin_webapp/class/patient.dart';
import 'package:admin_webapp/screen/home/information_card.dart';
import 'package:admin_webapp/utils/color_palette.dart';
import 'package:admin_webapp/utils/text_styles.dart';
import 'package:admin_webapp/widgets/common_button.dart';
import 'package:admin_webapp/widgets/common_dialogs.dart';
import 'package:admin_webapp/widgets/textfield_with_label.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final emailController = TextEditingController();
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  String? emailError;
  String? passwordError;
  String? confirmPasswordError;
  String? error;
  List<Patient> patients = [];

  @override
  void initState() {
    context.read<GetAllPatientsBloc>().add(const GetAllPatientsEvent());
    super.initState();
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
    final TextStyle tabStyle =
        TextStyles(context).getRegularStyle(fontWeight: FontWeight.w400);
    return BlocProvider(
      create: (context) => CreateNewAccountBloc(),
      child: BlocListener<GetAllPatientsBloc, GetAllPatientsState>(
        listener: (context, state) {
          if (state is GetAllPatientsLoading) {
            Dialogs(context).showLoadingDialog();
          } else if (state is GetAllPatientsSuccessfully) {
            Navigator.of(context).pop();
            patients = state.patients;
          } else if (state is GetAllPatientsFailure) {
            Navigator.of(context).pop();
            Dialogs(context).showErrorDialog(message: state.error);
          }
        },
        child: Scaffold(
          backgroundColor: ColorPalette.blueFormColor,
          body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.01, vertical: size.height * 0.02),
              child: Text(
                "User Management",
                style: TextStyles(context).getTitleStyle(
                    size: 40,
                    color: ColorPalette.deepBlue,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Expanded(
                child: Container(
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.01),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: ColorPalette.whiteColor,
              ),
              child: DefaultTabController(
                  length: 3,
                  child: Column(
                    children: [
                      TabBar(
                        labelColor: ColorPalette.deepBlue,
                        labelStyle: tabStyle,
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: ColorPalette.deepBlue,
                        tabs: const [
                          Tab(text: "Doctors"),
                          Tab(text: "Patients"),
                          Tab(text: "+ Add New Doctor"),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            const Center(child: Text("Content for Tab 1")),
                            const Center(child: Text("Content for Tab 2")),
                            Center(child: _addNewDoctorAccount(size)),
                          ],
                        ),
                      ),
                    ],
                  )),
            ))
          ]),
        ),
      ),
    );
  }

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

  Widget _addNewDoctorAccount(Size size) {
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
                  _onSignUp(context);
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

  Widget _allPatients(Size size) {
    return SizedBox(
      width: size.width * 0.3,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Expanded(
          child: ListView.builder(
            itemCount: patients.length,
            itemBuilder: (context, index) {
              final patient = patients[index];
              // return InformationCard(
              //   name: patient.name,
              //   avaUrl: patient.avaUrl,
              //   onTap: () {
              //     // Navigator.of(context).pushNamed(
              //     //   '/patient_detail',
              //     //   arguments: patient,
              //     // );
              //   },
              // );
            },
          ),
        ),
      ]),
    );
  }
}
