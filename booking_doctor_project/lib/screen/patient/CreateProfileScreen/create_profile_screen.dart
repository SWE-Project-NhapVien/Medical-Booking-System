import 'package:booking_doctor_project/bloc/patient/CreateProfile/create_profile_bloc.dart';
import 'package:booking_doctor_project/services/authentication/auth_services.dart';
import 'package:booking_doctor_project/widgets/common_date_field.dart';
import 'package:booking_doctor_project/widgets/common_dialogs.dart';
import 'package:booking_doctor_project/widgets/common_textfield.dart';
import 'package:booking_doctor_project/widgets/custom_dropdown.dart';
import 'package:booking_doctor_project/widgets/textfield_with_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/color_palette.dart';
import '../../../utils/text_styles.dart';
import '../../../widgets/common_appbar_with_title.dart';
import '../../../widgets/common_button.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({super.key});

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  final List<String> genders = ["Male", "Female", "None"];
  String selectedGender = 'None';
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final nationalIDController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final addressController = TextEditingController();
  final bloodController = TextEditingController();
  final weightController = TextEditingController();
  final heightController = TextEditingController();

  final restrictedEmergencyContactController = TextEditingController();

  final List<TextEditingController> emergencyContactsControllers = [];
  final List<TextEditingController> medicalHistoryControllers = [];
  final List<TextEditingController> allergiesControllers = [];

  final Map<String, String> errors = {};

  int curStep = 0;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    nationalIDController.dispose();
    addressController.dispose();
    bloodController.dispose();
    weightController.dispose();
    heightController.dispose();
    restrictedEmergencyContactController.dispose();

    for (var element in emergencyContactsControllers) {
      element.dispose();
    }
    for (var element in medicalHistoryControllers) {
      element.dispose();
    }
    for (var element in allergiesControllers) {
      element.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorPalette.whiteColor,
      body: BlocConsumer<CreateProfileBloc, CreateProfileState>(
          listener: (context, state) {
        if (state is CreateProfileProcess) {
          Dialogs(context).showLoadingDialog();
        } else if (state is CreateProfileSuccess) {
          Navigator.pop(context);
          Dialogs(context).showAnimatedDialog(
            title: 'Create Profile',
            content: 'Profile has been created successfully.',
          );
        } else if (state is CreateProfileFailure) {
          Navigator.pop(context);
          Dialogs(context).showErrorDialog(message: state.error);
        }
      }, builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(children: [
                CommonAppBarWithTitle(
                  title: 'Create A Profile',
                  titleSize: 32,
                  topPadding: MediaQuery.of(context).padding.top,
                  prefixIconData: Icons.arrow_back_ios_new_rounded,
                  onPrefixIconClick: () {
                    if (curStep == 0) {
                      Navigator.pop(context);
                    } else {
                      setState(() {
                        curStep -= 1;
                      });
                    }
                  },
                ),
                if (curStep == 0) _buildPersonalInformationForm(size),
                if (curStep == 1) _buildHealthInformationForm(size),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: CommonButton(
                      buttonTextWidget: Text(
                        curStep == 0 ? 'Next' : 'Complete',
                        style: TextStyles(context).getTitleStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onTap: () {
                        if (curStep == 0) {
                          if (validatePage1()) {
                            setState(() {
                              curStep += 1;
                            });
                          }
                        } else {
                          if (validatePage2()) {
                            final userEmail =
                                AuthServices().getCurruentUserEmail();
                            context
                                .read<CreateProfileBloc>()
                                .add(CreateProfileRequired(
                                  firstName: firstNameController.text,
                                  lastName: lastNameController.text,
                                  email: userEmail ?? '',
                                  phoneNumber: phoneNumberController.text,
                                  dateOfBirth: dateOfBirthController.text,
                                  bloodType: bloodController.text,
                                  gender: selectedGender,
                                  address: addressController.text,
                                  nationalID: nationalIDController.text,
                                  height: double.parse(heightController.text),
                                  weight: double.parse(weightController.text),
                                  emergencyContact: [
                                    restrictedEmergencyContactController.text,
                                    ...emergencyContactsControllers
                                        .map((controller) => controller.text)
                                  ],
                                ));
                          }
                        }
                      },
                      width: double.infinity,
                      height: size.height * 0.06,
                      radius: 30,
                    ),
                  ),
                ),
              ])),
        );
      }),
    );
  }

  Widget _buildPersonalInformationForm(Size size) {
    return Column(
      children: [
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
                  isRestricted: true),
            ),
            SizedBox(width: size.width * 0.02),
            Expanded(
              child: LabelAndTextField(
                  context: context,
                  label: 'Last Name',
                  hintText: '',
                  controller: lastNameController,
                  errorText: errors['lastName'] ?? '',
                  isRestricted: true),
            )
          ],
        ),
        LabelAndTextField(
            context: context,
            label: 'Phone Number',
            hintText: '',
            controller: phoneNumberController,
            errorText: errors['phoneNumber'] ?? '',
            isRestricted: true),
        LabelAndTextField(
            context: context,
            label: 'National ID',
            hintText: '',
            controller: nationalIDController,
            errorText: errors['nationalID'] ?? '',
            isRestricted: true),
        LabelAndTextField(
          context: context,
          label: 'Address',
          hintText: '',
          controller: addressController,
          errorText: errors['address'] ?? '',
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
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
                  Container(
                    height: size.height * 0.06,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: ColorPalette.blueFormColor,
                        borderRadius: BorderRadius.circular(15)),
                    child: CustDropDown(
                        items: List<CustDropdownMenuItem<String>>.generate(
                          genders.length,
                          (index) => CustDropdownMenuItem<String>(
                            value: genders[index],
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                genders[index],
                                style: TextStyles(context).getRegularStyle(),
                              ),
                            ),
                          ),
                        ),
                        borderRadius: 10,
                        onChanged: (value) {
                          setState(() {
                            selectedGender = value as String;
                          });
                        }),
                  ),
                ],
              ),
            ),
            SizedBox(width: size.width * 0.02),
            Expanded(
              flex: 2,
              child: DateOfBirthPicker(
                label: 'Date of Birth',
                isRestricted: true,
                errorText: errors['dateOfBirth'] ?? '',
                controller: dateOfBirthController,
              ),
            ),
          ],
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        LabelAndTextField(
            context: context,
            label: 'Emergency Contacts',
            hintText: '',
            controller: restrictedEmergencyContactController,
            errorText: errors['restrictedEmergencyContact'] ?? '',
            isRestricted: true),
        Column(
          children: [
            ...List.generate(emergencyContactsControllers.length, (index) {
              return AdditionTextField(
                controller: emergencyContactsControllers[index],
                onRemove: () {
                  setState(() {
                    emergencyContactsControllers.removeAt(index);
                  });
                },
              );
            }),
            SizedBox(
              height: size.height * 0.01,
            ),
            CommonButton(
              buttonTextWidget: Text(
                '+\tAdd',
                style: TextStyles(context).getTitleStyle(
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                setState(() {
                  emergencyContactsControllers.add(TextEditingController());
                });
              },
              width: double.infinity,
              height: size.height * 0.06,
              radius: 15,
              backgroundColor: ColorPalette.lightBlueTextColor,
              bordeColor: ColorPalette.lightBlueTextColor,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHealthInformationForm(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: LabelAndTextField(
                context: context,
                label: 'Blood',
                hintText: '',
                controller: bloodController,
                errorText: '',
              ),
            ),
            SizedBox(width: size.width * 0.02),
            Expanded(
              child: LabelAndTextField(
                  context: context,
                  label: 'Weight',
                  hintText: '',
                  controller: weightController,
                  errorText: '',
                  suffixText: 'kg',
                  isRestricted: true),
            ),
            SizedBox(width: size.width * 0.02),
            Expanded(
              child: LabelAndTextField(
                  context: context,
                  label: 'Height',
                  hintText: '',
                  controller: heightController,
                  errorText: '',
                  suffixText: 'cm',
                  isRestricted: true),
            )
          ],
        ),
        Text(
          'Medical History',
          style: TextStyles(context).getTitleStyle(
            size: 20,
            fontWeight: FontWeight.w500,
            color: ColorPalette.blackColor,
          ),
        ),
        Column(
          children: [
            ...List.generate(medicalHistoryControllers.length, (index) {
              return AdditionTextField(
                controller: medicalHistoryControllers[index],
                onRemove: () {
                  setState(() {
                    medicalHistoryControllers.removeAt(index);
                  });
                },
              );
            }),
            SizedBox(
              height: size.height * 0.01,
            ),
            CommonButton(
              buttonTextWidget: Text(
                '+\tAdd',
                style: TextStyles(context).getTitleStyle(
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                setState(() {
                  medicalHistoryControllers.add(TextEditingController());
                });
              },
              width: double.infinity,
              height: size.height * 0.06,
              radius: 15,
              backgroundColor: ColorPalette.lightBlueTextColor,
              bordeColor: ColorPalette.lightBlueTextColor,
            ),
          ],
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        Text(
          'Allergies',
          style: TextStyles(context).getTitleStyle(
            size: 20,
            fontWeight: FontWeight.w500,
            color: ColorPalette.blackColor,
          ),
        ),
        Column(
          children: [
            ...List.generate(allergiesControllers.length, (index) {
              return AdditionTextField(
                controller: allergiesControllers[index],
                onRemove: () {
                  setState(() {
                    allergiesControllers.removeAt(index);
                  });
                },
              );
            }),
            SizedBox(
              height: size.height * 0.01,
            ),
            CommonButton(
              buttonTextWidget: Text(
                '+\tAdd',
                style: TextStyles(context).getTitleStyle(
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                setState(() {
                  allergiesControllers.add(TextEditingController());
                });
              },
              width: double.infinity,
              height: size.height * 0.06,
              radius: 15,
              backgroundColor: ColorPalette.lightBlueTextColor,
              bordeColor: ColorPalette.lightBlueTextColor,
            ),
          ],
        ),
      ],
    );
  }

  bool validatePage1() {
    bool isValid = true;
    errors.clear();

    if (firstNameController.text.isEmpty) {
      errors['firstName'] = 'First name is required.';
      isValid = false;
    } else if (!RegExp(r"^[a-zA-Z\s\t]+$").hasMatch(firstNameController.text)) {
      errors['firstName'] = 'Must not contain numbers or special characters.';
      isValid = false;
    }

    if (lastNameController.text.isEmpty) {
      errors['lastName'] = 'Last name is required.';
      isValid = false;
    } else if (!RegExp(r"^[a-zA-Z\s\t]+$").hasMatch(lastNameController.text)) {
      errors['lastName'] = 'Must not contain numbers or special characters.';
      isValid = false;
    }

    if (phoneNumberController.text.isEmpty) {
      errors['phoneNumber'] = 'Phone number is required.';
      isValid = false;
    } else if (!RegExp(r"^\d+$").hasMatch(phoneNumberController.text)) {
      errors['phoneNumber'] = 'Phone number must be numeric.';
      isValid = false;
    }

    if (nationalIDController.text.isEmpty) {
      errors['nationalID'] = 'National ID is required.';
      isValid = false;
    }

    if (dateOfBirthController.text.isEmpty) {
      errors['dateOfBirth'] = 'Date of birth is required.';
      isValid = false;
    }

    if (addressController.text.isEmpty) {
      errors['address'] = 'Address is required.';
      isValid = false;
    }

    if (restrictedEmergencyContactController.text.isEmpty) {
      errors['restrictedEmergencyContact'] =
          'At least one emergency contact is required.';
      isValid = false;
    } else if (!RegExp(r"^\d+$")
        .hasMatch(restrictedEmergencyContactController.text)) {
      errors['restrictedEmergencyContact'] =
          'Emergency contact must be numeric.';
      isValid = false;
    }

    for (var i = 0; i < emergencyContactsControllers.length; i++) {
      final contact = emergencyContactsControllers[i].text;
      if (contact.isEmpty) {
        errors['emergencyContact$i'] = 'Emergency contact is required.';
        isValid = false;
      } else if (!RegExp(r"^\d+$").hasMatch(contact)) {
        errors['emergencyContact$i'] = 'Emergency contact must be numeric.';
        isValid = false;
      }
    }

    setState(() {});
    return isValid;
  }

  bool validatePage2() {
    bool isValid = true;
    errors.clear();

    if (bloodController.text.isEmpty) {
      errors['blood'] = 'Blood is required.';
      isValid = false;
    }

    if (weightController.text.isEmpty) {
      errors['weight'] = 'Weight is required.';
      isValid = false;
    } else if (!RegExp(r"^\d+$").hasMatch(weightController.text)) {
      errors['weight'] = 'Weight must be numeric.';
      isValid = false;
    }

    if (heightController.text.isEmpty) {
      errors['height'] = 'Height is required.';
      isValid = false;
    } else if (!RegExp(r"^\d+$").hasMatch(heightController.text)) {
      errors['height'] = 'Height must be numeric.';
      isValid = false;
    }

    setState(() {});
    return isValid;
  }
}

class AdditionTextField extends StatelessWidget {
  const AdditionTextField({
    super.key,
    required this.controller,
    required this.onRemove,
  });

  final TextEditingController controller;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CommonTextField(
          textEditingController: controller,
          contentPadding: const EdgeInsets.all(14),
          textFieldPadding: const EdgeInsets.only(top: 5, bottom: 2),
          radius: 15,
          hintText: '',
        ),
        Positioned(
          right: 0,
          top: 5,
          child: IconButton(
            onPressed: onRemove,
            icon: Icon(
              Icons.close,
              color: ColorPalette.deepBlue,
              size: 15,
            ),
          ),
        ),
      ],
    );
  }
}
