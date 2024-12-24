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
  final double? height, fontSize;
  bool isVisibility;
  final IconData? icon;

  CommonButton({
    super.key,
    this.onTap,
    this.padding,
    this.buttonText,
    this.buttonTextWidget,
    this.textColor = Colors.white,
    this.backgroundColor = const Color(0xFF2260FF),
    this.bordeColor = const Color(0xFF2260FF),
    this.isClickable = true,
    this.radius = 20.0,
    this.height,
    this.fontSize = 18,
    this.isVisibility = true,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisibility,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(0),
        child: TapEffect(
          isClickable: isClickable,
          onClick: onTap ?? () {},
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                height: height ?? 50, // Default height for web layout
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius),
                  border: Border.all(
                    color: bordeColor ?? Theme.of(context).primaryColor,
                  ),
                  color: backgroundColor ?? Theme.of(context).primaryColor,
                ),
                child: IntrinsicWidth(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (icon != null)
                        Icon(
                          icon,
                          color: textColor ?? Colors.white,
                        ),
                      if (icon != null) const SizedBox(width: 10.0),
                      buttonTextWidget ??
                          Text(
                            buttonText ?? "",
                            style: TextStyles(context).getTitleStyle(
                              size: fontSize ?? 18,
                              color: textColor ?? Colors.white,
                            ),
                          ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
