import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'enum.dart';
import 'themes.dart';

class TextStyles {
  final BuildContext context;

  TextStyles(this.context);

  TextStyle getTitleStyle(
      {double size = 24,
      FontWeight fontWeight = FontWeight.w300,
      Color color = Colors.white}) {
    return getTextStyle(
        FontFamilyType.LeagueSpartan,
        Theme.of(context).textTheme.titleLarge!.copyWith(
              fontSize: size,
              fontWeight: fontWeight,
              color: color,
            ));
  }

  TextStyle getDescriptionStyle() {
    return getTextStyle(
        FontFamilyType.LeagueSpartan,
        Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w300,
              color: ColorPalette.blackTextColor,
            ));
  }

  TextStyle getHintTextStyle({double size = 18}) {
    return getTextStyle(
        FontFamilyType.LeagueSpartan,
        Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontSize: size,
              fontWeight: FontWeight.w300,
              color: ColorPalette.lightBlueTextColor,
            ));
  }

  TextStyle getRegularStyle(
      {FontWeight fontWeight = FontWeight.w400,
      Color color = const Color.fromARGB(255, 0, 0, 0)}) {
    return getTextStyle(
        FontFamilyType.LeagueSpartan,
        Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontSize: 18,
              fontWeight: fontWeight,
              color: color,
            ));
  }

  TextStyle getBoldStyle() {
    return Theme.of(context).textTheme.titleMedium!.copyWith(
          fontSize: 14,
          color: ColorPalette.blackTextColor,
        );
  }

  TextStyle getSmallStyle() {
    return Theme.of(context).textTheme.bodySmall!.copyWith(
          color: ColorPalette.blackTextColor,
        );
  }

  TextStyle getCategoryButtonStyle(bool isSelected) {
    return Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: isSelected ? Colors.white : Colors.black,
        );
  }

  TextStyle getTextFieldHintStyle() {
    return Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: ColorPalette.greyTextColor,
        );
  }

  TextStyle getSubtitleStyle() {
    return Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontSize: 14,
          color: ColorPalette.greyTextColor,
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
      case FontFamilyType.LeagueSpartan:
        return GoogleFonts.leagueSpartan(textStyle: textStyle);
      default:
        return GoogleFonts.roboto(textStyle: textStyle);
    }
  }
}
