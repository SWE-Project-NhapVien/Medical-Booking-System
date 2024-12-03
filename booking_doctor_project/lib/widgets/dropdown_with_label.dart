import 'package:booking_doctor_project/utils/color_palette.dart';
import 'package:booking_doctor_project/utils/text_styles.dart';
import 'package:booking_doctor_project/widgets/custom_dropdown.dart';
import 'package:flutter/material.dart';

class LabelAndDropDown extends StatelessWidget {
  const LabelAndDropDown({
    super.key,
    required this.title,
    required this.items,
    required this.isRestricted,
  });

  final String title;
  final List<String> items;
  final bool isRestricted;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
              text: title,
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
                  : []),
        ),
        Container(
          height: size.height * 0.06,
          width: double.infinity,
          decoration: BoxDecoration(
              color: ColorPalette.blueFormColor,
              borderRadius: BorderRadius.circular(15)),
          child: CustDropDown(
              items: List<CustDropdownMenuItem<int>>.generate(
                items.length,
                (index) => CustDropdownMenuItem<int>(
                  value: index,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      items[index],
                      style: TextStyles(context).getRegularStyle(),
                    ),
                  ),
                ),
              ),
              borderRadius: 10,
              onChanged: () {}),
        ),
      ],
    );
  }
}
