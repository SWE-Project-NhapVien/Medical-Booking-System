import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'enum.dart';
import 'themes.dart';

class TextStyles {
  final BuildContext context;

  TextStyles(this.context);

  TextStyle getTitleStyle([double size = 24]) {
    return Theme.of(context).textTheme.titleLarge!.copyWith(
          fontSize: size,
          color: ColorPalette.blackColor,
        );
  }

  TextStyle getDescriptionStyle() {
    return getTextStyle(
        FontFamilyType.Inter,
        Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: ColorPalette.greyColor,
            ));
  }

  TextStyle getRegularStyle({double fontSize = 14.0, Color? color}) {
    return Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontSize: fontSize,
          color: color ?? ColorPalette.blackColor,
        );
  }

  TextStyle getBoldStyle({double fontSize = 14.0, Color? color}) {
    return Theme.of(context).textTheme.titleMedium!.copyWith(
          fontSize: fontSize,
          color: color ?? ColorPalette.blackColor,
        );
  }

  TextStyle getSmallStyle() {
    return Theme.of(context).textTheme.bodySmall!.copyWith(
          color: ColorPalette.blackColor,
        );
  }

  TextStyle getCategoryButtonStyle(bool isSelected) {
    return Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: isSelected
              ? ColorPalette.whiteColor
              : ColorPalette.blackColor,
        );
  }

  TextStyle getTextFieldHintStyle() {
    return Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: ColorPalette.greyColor,
        );
  }

  TextStyle getSubtitleStyle() {
    return Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontSize: 14,
          color: ColorPalette.greyColor,
        );
  }

  static TextStyle getTextStyle(
      FontFamilyType fontFamilyType, TextStyle textStyle) {
    switch (fontFamilyType) {
      case FontFamilyType.Montserrat:
        return GoogleFonts.montserrat(textStyle: textStyle);
      case FontFamilyType.WorkSans:
        return GoogleFonts.workSans(textStyle: textStyle);
      case FontFamilyType.Varela:
        return GoogleFonts.varela(textStyle: textStyle);
      case FontFamilyType.Satisfy:
        return GoogleFonts.satisfy(textStyle: textStyle);
      case FontFamilyType.DancingScript:
        return GoogleFonts.dancingScript(textStyle: textStyle);
      case FontFamilyType.KaushanScript:
        return GoogleFonts.kaushanScript(textStyle: textStyle);
      case FontFamilyType.Inter:
        return GoogleFonts.inter(textStyle: textStyle);
      case FontFamilyType.DmSerifDisplay:
        return GoogleFonts.dmSerifDisplay(textStyle: textStyle);
      default:
        return GoogleFonts.roboto(textStyle: textStyle);
    }
  }
}
