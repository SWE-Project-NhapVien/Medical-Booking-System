import 'package:admin_webapp/bloc/doctor/CreateDoctorProfile/create_doctor_profile_bloc.dart';
import 'package:admin_webapp/widgets/common_date_field.dart';
import 'package:admin_webapp/widgets/common_dialogs.dart';
import 'package:admin_webapp/widgets/custom_dropdown.dart';
import 'package:admin_webapp/widgets/textfield_with_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/color_palette.dart';
import '../../../utils/text_styles.dart';
import '../../../widgets/common_button.dart';

class CreateDoctorProfileScreen extends StatefulWidget {
  final String doctorId;

  const CreateDoctorProfileScreen({super.key, required this.doctorId});

  @override
  State<CreateDoctorProfileScreen> createState() =>
      _CreateDoctorProfileScreenState();
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorPalette.blueFormColor,
      body: Row(
        children: [
          Container(
            width: 88,
          ),
          Expanded(
            child:
                BlocConsumer<CreateDoctorProfileBloc, CreateDoctorProfileState>(
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
                    child: _buildDoctorInformationForm(size),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorInformationForm(Size size) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(30),
      child: Container(
        decoration: BoxDecoration(
          color: ColorPalette.whiteColor,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Title and Back Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  onPressed: () => Navigator.pop(context),
                ),
                Text(
                  'Create Doctor Profile',
                  style: TextStyles(context).getTitleStyle(size: 32),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Profile Picture
            Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundColor: ColorPalette.greyColor,
                  backgroundImage: const AssetImage('assets/placeholder.png'),
                ),
                Positioned(
                  bottom: 0,
                  right: 20,
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: ColorPalette.deepBlue,
                    child:
                        const Icon(Icons.edit, color: Colors.white, size: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Name Fields
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: LabelAndTextField(
                    context: context,
                    label: 'First Name',
                    hintText: '',
                    controller: firstNameController,
                    errorText: errors['firstName'] ?? '',
                    isRestricted: true,
                  ),
                ),
                SizedBox(width: size.width * 0.02),
                Expanded(
                  child: LabelAndTextField(
                    context: context,
                    label: 'Last Name',
                    hintText: '',
                    controller: lastNameController,
                    errorText: errors['lastName'] ?? '',
                    isRestricted: true,
                  ),
                ),
              ],
            ),

            // Phone Number Field
            LabelAndTextField(
              context: context,
              label: 'Phone Number',
              hintText: '',
              controller: phoneNumberController,
              errorText: errors['phoneNumber'] ?? '',
              isRestricted: true,
            ),

            // Date of Birth and Gender
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: DateOfBirthPicker(
                    label: 'Date of Birth',
                    isRestricted: true,
                    errorText: errors['dateOfBirth'] ?? '',
                    controller: dateOfBirthController,
                  ),
                ),
                SizedBox(width: size.width * 0.02),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 101,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Gender',
                          style: TextStyles(context).getTitleStyle(
                            size: 20,
                            fontWeight: FontWeight.w500,
                            color: ColorPalette.blackColor,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          height: size.height * 0.06,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: ColorPalette.blueFormColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: CustDropDown(
                            items: List<CustDropdownMenuItem<String>>.generate(
                              genders.length,
                              (index) => CustDropdownMenuItem<String>(
                                value: genders[index],
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    genders[index],
                                    style:
                                        TextStyles(context).getRegularStyle(),
                                  ),
                                ),
                              ),
                            ),
                            borderRadius: 10,
                            onChanged: (value) {
                              setState(() {
                                selectedGender = value as String;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Address Field
            LabelAndTextField(
              context: context,
              label: 'Address',
              hintText: '',
              controller: addressController,
              errorText: errors['address'] ?? '',
            ),

            // Education Field
            LabelAndTextField(
              context: context,
              label: 'Education',
              hintText: '',
              controller: educationController,
              errorText: errors['education'] ?? '',
              isRestricted: true,
            ),

            // Career Field
            LabelAndTextField(
              context: context,
              label: 'Career',
              hintText: '',
              controller: careerController,
              errorText: errors['career'] ?? '',
              isRestricted: true,
            ),

            // Specialization Dropdown
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Specialization',
                  style: TextStyles(context).getTitleStyle(
                    size: 20,
                    fontWeight: FontWeight.w500,
                    color: ColorPalette.blackColor,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  height: size.height * 0.06,
                  decoration: BoxDecoration(
                    color: ColorPalette.blueFormColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: CustDropDown(
                    items: List<CustDropdownMenuItem<String>>.generate(
                      specializations.length,
                      (index) => CustDropdownMenuItem<String>(
                        value: specializations[index],
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            specializations[index],
                            style: TextStyles(context).getRegularStyle(),
                          ),
                        ),
                      ),
                    ),
                    borderRadius: 10,
                    onChanged: (value) {
                      setState(() {
                        selectedSpecialization = value as String;
                      });
                    },
                  ),
                ),
              ],
            ),

            // Profile Description Field
            LabelAndTextField(
              context: context,
              label: 'Profile Description',
              hintText: 'Enter a brief description',
              controller: descriptionController,
              errorText: errors['description'] ?? '',
              height: 111,
            ),

            // Complete Button
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
                  if (validateDoctorForm()) {
                    context.read<CreateDoctorProfileBloc>().add(
                          CreateDoctorProfileRequired(
                            doctorId: widget.doctorId,
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
                            avaUrl: ' ', //add later
                            specialization: [selectedSpecialization],
                          ),
                        );
                  }
                },
                height: size.height * 0.06,
                radius: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool validateDoctorForm() {
    bool isValid = true;
    errors.clear();

    if (firstNameController.text.isEmpty) {
      errors['firstName'] = 'First name is required.';
      isValid = false;
    }

    if (lastNameController.text.isEmpty) {
      errors['lastName'] = 'Last name is required.';
      isValid = false;
    }

    if (phoneNumberController.text.isEmpty ||
        !RegExp(r"^\d+$").hasMatch(phoneNumberController.text)) {
      errors['phoneNumber'] = 'Valid phone number is required.';
      isValid = false;
    }

    if (educationController.text.isEmpty) {
      errors['education'] = 'Education is required.';
      isValid = false;
    }

    if (careerController.text.isEmpty) {
      errors['career'] = 'Career is required.';
      isValid = false;
    }

    if (selectedSpecialization.isEmpty) {
      errors['specialization'] = 'Specialization is required.';
      isValid = false;
    }

    setState(() {});
    return isValid;
  }
}
