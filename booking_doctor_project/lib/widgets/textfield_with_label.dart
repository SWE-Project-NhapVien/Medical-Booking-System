import 'package:booking_doctor_project/utils/themes.dart';
import 'package:booking_doctor_project/widgets/common_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../utils/text_styles.dart';

// ignore: non_constant_identifier_names
Widget LabelAndTextField(
    {required BuildContext context,
    required String label,
    required String hintText,
    required TextEditingController controller,
    required String errorText,
    IconData? suffixIconData,
    IconData? selectedIconData,
    bool? isObscured}) {
  return SizedBox(
    height: 105,
    child: Column(children: [
      Align(
        alignment: Alignment.topLeft,
        child: Text(
          label,
          style: TextStyles(context).getTitleStyle(
            size: 20,
            fontWeight: FontWeight.w500,
            color: ColorPalette.blackTextColor,
          ),
        ),
      ),
      CommonTextField(
        isObscureText: isObscured ?? false,
        textEditingController: controller,
        contentPadding: const EdgeInsets.all(14),
        hintTextStyle: TextStyles(context).getHintTextStyle(),
        focusColor: ColorPalette.blueColor,
        hintText: hintText,
        radius: 15,
        textFieldPadding: const EdgeInsets.only(top: 5, bottom: 2),
        errorText: errorText,
        suffixIconData: suffixIconData,
        selectedIconData: selectedIconData,
        cursorColor: ColorPalette.blueColor,
      ),
    ]),
  );
}
