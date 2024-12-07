import 'package:flutter/material.dart';
import '../utils/text_styles.dart';
import 'tap_effect.dart';

// ignore: must_be_immutable
class CommonButton extends StatelessWidget {
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final String? buttonText;
  final Widget? buttonTextWidget;
  final Color? textColor, backgroundColor, bordeColor;
  bool isClickable;
  final double radius;
  double height, width, fontSize;
  bool isVisibility;
  final IconData? icon;

  CommonButton(
      {super.key,
      this.onTap,
      this.padding,
      this.buttonText,
      this.buttonTextWidget,
      this.textColor = Colors.white,
      this.backgroundColor = const Color(0xFF2260FF),
      this.bordeColor = const Color(0xFF2260FF),
      this.isClickable = true,
      this.radius = 20.0,
      this.height = 57,
      this.fontSize = 18,
      this.width = double.infinity,
      this.isVisibility = true,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(),
      child: TapEffect(
        isClickable: isClickable,
        onClick: onTap ?? () {},
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            border:
                Border.all(color: bordeColor ?? Theme.of(context).primaryColor),
            color: backgroundColor ?? Theme.of(context).primaryColor,
          ),
          child: isVisibility
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    icon != null
                        ? Icon(
                            icon,
                            color: Colors.white,
                          )
                        : const SizedBox(),
                    icon != null
                        ? const SizedBox(
                            width: 16.0,
                          )
                        : const SizedBox(),
                    buttonTextWidget ??
                        Text(
                          buttonText != null ? buttonText! : "",
                          style: TextStyles(context).getTitleStyle(
                            size: fontSize,
                            color: textColor ?? Colors.black,
                          ),
                        ),
                  ],
                )
              : const SizedBox(),
        ),
      ),
    );
  }
}
