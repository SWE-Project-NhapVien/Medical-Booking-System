import 'package:booking_doctor_project/widgets/common_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../utils/color_palette.dart';
import '../utils/text_styles.dart';

// ignore: non_constant_identifier_names
Widget LabelAndTextField(
    {required BuildContext context,
    required String label,
    required String hintText,
    required TextEditingController controller,
    required String errorText,
    double? height = 111,
    String? suffixText,
    IconData? suffixIconData,
    IconData? selectedIconData,
    bool? isObscured,
    bool? isRestricted}) {
  return SizedBox(
      height: height,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        RichText(
          text: TextSpan(
            text: label,
            style: TextStyles(context).getTitleStyle(
              size: 20,
              fontWeight: FontWeight.w500,
              color: ColorPalette.blackColor,
            ),
            children: isRestricted == true
                ? [
                    TextSpan(
                      text: ' *',
                      style: TextStyles(context).getTitleStyle(
                        size: 20,
                        fontWeight: FontWeight.w500,
                        color: ColorPalette.redColor,
                      ),
                    ),
                  ]
                : [],
          ),
        ),
        CommonTextField(
          isObscureText: isObscured ?? false,
          textEditingController: controller,
          contentPadding: const EdgeInsets.all(14),
          hintTextStyle: TextStyles(context).getHintTextStyle(),
          focusColor: ColorPalette.deepBlue,
          hintText: hintText,
          suffixText: suffixText,
          radius: 15,
          textFieldPadding: const EdgeInsets.only(top: 5, bottom: 2),
          errorText: errorText,
          suffixIconData: suffixIconData,
          selectedIconData: selectedIconData,
          cursorColor: ColorPalette.deepBlue,
        ),
      ]));
}
