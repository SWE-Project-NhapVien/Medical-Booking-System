import 'package:booking_doctor_project/utils/color_palette.dart';
import 'package:booking_doctor_project/utils/text_styles.dart';
import 'package:booking_doctor_project/widgets/tap_effect.dart';
import 'package:flutter/material.dart';

class DateOfBirthPicker extends StatefulWidget {
  final String label;
  final String errorText;
  final bool isRestricted;
  final TextEditingController controller;

  const DateOfBirthPicker({
    super.key,
    required this.label,
    required this.controller,
    required this.errorText,
    this.isRestricted = false,
  });

  @override
  DateOfBirthPickerState createState() => DateOfBirthPickerState();
}

class DateOfBirthPickerState extends State<DateOfBirthPicker> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: 103,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: widget.label,
              style: TextStyles(context).getTitleStyle(
                size: 20,
                fontWeight: FontWeight.w500,
                color: ColorPalette.blackColor,
              ),
              children: widget.isRestricted == true
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
          Container(
            height: size.height * 0.06,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: ColorPalette.blueFormColor,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.controller.text,
                      style: TextStyles(context).getRegularStyle(),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TapEffect(
                        onClick: () async {
                          DateTime? selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          if (selectedDate != null) {
                            setState(() {
                              widget.controller.text =
                                  "${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year}";
                            });
                          }
                        },
                        child: Icon(
                          Icons.calendar_today,
                          color: ColorPalette.deepBlue,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (widget.errorText.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 8),
              child: Text(
                widget.errorText,
                style: TextStyles(context).getSmallStyle().copyWith(
                      color: ColorPalette.redColor,
                      fontStyle: FontStyle.italic,
                    ),
              ),
            ),
        ],
      ),
    );
  }
}
