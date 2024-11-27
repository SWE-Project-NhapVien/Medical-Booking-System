import 'package:booking_doctor_project/utils/text_styles.dart';
import 'package:booking_doctor_project/utils/color_palette.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CommonAppBarView extends StatelessWidget {
  final EdgeInsets? padding;
  final IconData iconData;
  final VoidCallback? onBackClick;
  final double iconTextSize;
  final String? title;
  const CommonAppBarView({
    super.key,
    this.padding,
    required this.iconData,
    this.onBackClick,
    this.iconTextSize = 24,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ??
          EdgeInsets.fromLTRB(
            MediaQuery.of(context).size.width * 0.05,
            AppBar().preferredSize.height,
            MediaQuery.of(context).size.width * 0.1,
            MediaQuery.of(context).size.height * 0.01,
          ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              onBackClick!();
            },
            child: Icon(iconData,
                color: ColorPalette.deepBlue, size: iconTextSize),
          ),
          Expanded(
            child: Center(
              child: Text(title!,
                  style: TextStyles(context).getBoldStyle(
                      fontSize: 24.0, color: ColorPalette.deepBlue)),
            ),
          )
        ],
      ),
    );
  }
}
