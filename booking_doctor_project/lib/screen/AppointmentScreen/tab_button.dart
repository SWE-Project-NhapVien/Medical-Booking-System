import 'package:flutter/material.dart';

import '../../utils/color_palette.dart';

class TabButton extends StatelessWidget {
  final Function()? onTap;
  final bool isSelected;
  final String text;
  const TabButton(
      {super.key, this.onTap, required this.isSelected, required this.text});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: isSelected ? ColorPalette.deepBlue : ColorPalette.mediumBlue,
            borderRadius: BorderRadius.circular(18.0),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: isSelected
                    ? ColorPalette.whiteColor
                    : ColorPalette.deepBlue,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
