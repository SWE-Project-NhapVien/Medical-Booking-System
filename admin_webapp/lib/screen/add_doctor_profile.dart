import 'package:admin_webapp/bloc/doctor/CreateDoctorProfile/create_doctor_profile_bloc.dart';
import 'package:admin_webapp/widgets/common_date_field.dart';
import 'package:admin_webapp/widgets/common_dialogs.dart';
import 'package:admin_webapp/widgets/common_textfield.dart';
import 'package:admin_webapp/widgets/custom_dropdown.dart';
import 'package:admin_webapp/widgets/tap_effect.dart';
import 'package:admin_webapp/widgets/textfield_with_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/color_palette.dart';
import '../../../utils/text_styles.dart';
import '../../../widgets/common_appbar_with_title.dart';
import '../../../widgets/common_button.dart';

class CreateDoctorProfileScreen extends StatefulWidget {
  const CreateDoctorProfileScreen({super.key});

  @override
  State<CreateDoctorProfileScreen> createState() => _CreateDoctorProfileScreenState();
}

class _CreateDoctorProfileScreenState extends State<CreateDoctorProfileScreen> {
  final List<String> genders = ["Male", "Female", "None"];
  final List<String> bloodTypes = [
    "A+",
    "A-",
    "B+",
    "B-",
    "AB+",
    "AB-",
    "O+",
    "O-",
    "None"
  ];
  final List<String> specializations = [
    "Cardiology",
    "Neurology",
    "Orthopedics",
    "Pediatrics",
    "General Medicine",
  ];

  String selectedGender = 'None';
  String selectedBloodType = 'None';
  String selectedSpecialization = 'General Medicine';

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final addressController = TextEditingController();
  final educationController = TextEditingController();
  final careerController = TextEditingController();
  final descriptionController = TextEditingController();
  final profilePictureUrlController = TextEditingController();

  final Map<String, String> errors = {};

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    dateOfBirthController.dispose();
    addressController.dispose();
    educationController.dispose();
    careerController.dispose();
    descriptionController.dispose();
    profilePictureUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorPalette.whiteColor,
      body: BlocConsumer<CreateDoctorProfileBloc, CreateDoctorProfileState>(
        listener: (context, state) {
          if (state is CreateDoctorProfileProcess) {
            Dialogs(context).showLoadingDialog();
          } else if (state is CreateDoctorProfileSuccess) {
            Navigator.pop(context);
            Dialogs(context).showAnimatedDialog(
              title: 'Create Profile',
              content: 'Doctor profile has been created successfully.',
            );
          } else if (state is CreateDoctorProfileFailure) {
            Navigator.pop(context);
            Dialogs(context).showErrorDialog(message: state.error);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                children: [
                  CommonAppBarWithTitle(
                    title: 'Create Doctor Profile',
                    titleSize: 32,
                    topPadding: MediaQuery.of(context).padding.top,
                    prefixIconData: Icons.arrow_back_ios_new_rounded,
                    onPrefixIconClick: () => Navigator.pop(context),
                  ),
                  _buildDoctorInformationForm(size),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: CommonButton(
                      buttonTextWidget: Text(
                        'Complete',
                        style: TextStyles(context).getTitleStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onTap: () {
                        if (validateForm()) {
                          context.read<CreateDoctorProfileBloc>().add(
                                CreateDoctorProfileRequired(
                                  firstName: firstNameController.text,
                                  lastName: lastNameController.text,
                                  phoneNumber: phoneNumberController.text,
                                  dateOfBirth: dateOfBirthController.text,
                                  bloodType: selectedBloodType,
                                  gender: selectedGender,
                                  address: addressController.text,
                                  education: educationController.text,
                                  career: careerController.text,
                                  description: descriptionController.text,
                                  avaUrl: profilePictureUrlController.text,
                                  specialization: [selectedSpecialization],
                                ),
                              );
                        }
                      },
                      width: double.infinity,
                      height: size.height * 0.06,
                      radius: 30,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDoctorInformationForm(Size size) {
    return Column(
      children: [
        LabelAndTextField(
          context: context,
          label: 'First Name',
          controller: firstNameController,
          errorText: errors['firstName'] ?? '',
        ),
        LabelAndTextField(
          context: context,
          label: 'Last Name',
          controller: lastNameController,
          errorText: errors['lastName'] ?? '',
        ),
        CommonTextField(
          textEditingController: phoneNumberController,
          hintText: 'Phone Number',
          errorText: errors['phoneNumber'] ?? '',
        ),
        CommonDateField(
          controller: dateOfBirthController,
          hintText: 'Date of Birth',
        ),
        CustomDropdown<String>(
          label: 'Gender',
          items: genders,
          value: selectedGender,
          onChanged: (value) {
            setState(() {
              selectedGender = value ?? 'None';
            });
          },
        ),
        CustomDropdown<String>(
          label: 'Blood Type',
          items: bloodTypes,
          value: selectedBloodType,
          onChanged: (value) {
            setState(() {
              selectedBloodType = value ?? 'None';
            });
          },
        ),
        LabelAndTextField(
          context: context,
          label: 'Address',
          controller: addressController,
          errorText: errors['address'] ?? '',
        ),
        LabelAndTextField(
          context: context,
          label: 'Education',
          controller: educationController,
        ),
        LabelAndTextField(
          context: context,
          label: 'Career',
          controller: careerController,
        ),
        LabelAndTextField(
          context: context,
          label: 'Description',
          controller: descriptionController,
        ),
        CustomDropdown<String>(
          label: 'Specialization',
          items: specializations,
          value: selectedSpecialization,
          onChanged: (value) {
            setState(() {
              selectedSpecialization = value ?? 'General Medicine';
            });
          },
        ),
      ],
    );
  }

  bool validateForm() {
    errors.clear();
    bool isValid = true;

    if (firstNameController.text.isEmpty) {
      errors['firstName'] = 'First name is required';
      isValid = false;
    }
    if (lastNameController.text.isEmpty) {
      errors['lastName'] = 'Last name is required';
      isValid = false;
    }
    if (phoneNumberController.text.isEmpty) {
      errors['phoneNumber'] = 'Phone number is required';
      isValid = false;
    }
    return isValid;
  }
}
