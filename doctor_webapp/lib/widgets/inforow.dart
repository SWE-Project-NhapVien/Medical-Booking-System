import 'package:doctor_webapp/utils/color_palette.dart';
import 'package:doctor_webapp/utils/text_styles.dart';
import 'package:flutter/material.dart';

Widget _buildInfoRow(BuildContext context, TextStyles textStyles,
      String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: textStyles.getRegularStyle(
              size: 20,
              fontWeight: FontWeight.w500,
              color: ColorPalette.blackColor,
            ),
          ),
          Expanded(
            child: Text(
              value ?? "N/A",
              style: textStyles.getRegularStyle(),
            ),
          ),
        ],
      ),
    );
  }