import 'package:flutter/material.dart';

import '../utils/color_palette.dart';
import '../utils/text_styles.dart';
import 'tap_effect.dart';

class CommonAppBarWithTitle extends StatelessWidget {
  final double? topPadding;
  final IconData? prefixIconData;
  final IconData? suffixIconData;
  final String title;
  final VoidCallback? onSuffixIconClick;
  final VoidCallback? onPrefixIconClick;
  final Color? iconColor;
  final Color? backgroundColor;
  final int iconSize;
  final double titleSize;
  const CommonAppBarWithTitle({
    super.key,
    this.topPadding,
    required this.title,
    this.prefixIconData,
    this.suffixIconData,
    this.onPrefixIconClick,
    this.onSuffixIconClick,
    this.iconColor,
    this.iconSize = 25,
    this.backgroundColor,
    this.titleSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    final double tmp = topPadding ?? MediaQuery.of(context).padding.top;
    return Padding(
      padding: EdgeInsets.only(top: tmp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: AppBar().preferredSize.height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                prefixIconData != null ? AppBarButton(
                    onClick: onPrefixIconClick,
                    backgroundColor: backgroundColor ?? ColorPalette.whiteColor,
                    iconData: prefixIconData!,
                    iconColor: ColorPalette.deepBlue,
                    iconSize: iconSize) : const SizedBox(width: 40),
                Text(title, style: TextStyles(context).getTitleStyle(
                  size: titleSize,
                  color: ColorPalette.deepBlue,
                  fontWeight: FontWeight.w500
                )),
                suffixIconData != null
                    ? AppBarButton(
                        onClick: onSuffixIconClick,
                        backgroundColor: backgroundColor ?? ColorPalette.whiteColor,
                        iconData: suffixIconData!,
                        iconColor: iconColor,
                        iconSize: iconSize)
                    : const SizedBox(width: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AppBarButton extends StatelessWidget {
  const AppBarButton({
    super.key,
    required this.onClick,
    required this.backgroundColor,
    required this.iconData,
    required this.iconColor,
    required this.iconSize,
  });

  final VoidCallback? onClick;
  final Color backgroundColor;
  final IconData iconData;
  final Color? iconColor;
  final int iconSize;

  @override
  Widget build(BuildContext context) {
    return TapEffect(
      onClick: () {
        onClick!();
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(iconData, color: iconColor, size: iconSize.toDouble()),
        ),
      ),
    );
  }
}
