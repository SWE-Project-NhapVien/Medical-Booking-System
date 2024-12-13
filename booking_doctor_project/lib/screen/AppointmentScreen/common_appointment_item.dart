import 'package:booking_doctor_project/utils/text_styles.dart';
import 'package:booking_doctor_project/utils/color_palette.dart';
import 'package:flutter/material.dart';

class AppointmentCard extends StatelessWidget {
  final String doctorName;
  final String appointmentName;
  final String date;
  final String time;
  final String doctorImage;
  final VoidCallback onTap;

  const AppointmentCard({
    super.key,
    required this.doctorName,
    required this.appointmentName,
    required this.date,
    required this.time,
    required this.onTap,
    required this.doctorImage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Card(
        color: ColorPalette.mediumBlue,
        margin: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.02,
          horizontal: MediaQuery.of(context).size.width * 0.02,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.008),
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 32,
                    backgroundImage:
                        AssetImage(''), // Replace with a valid image
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.008),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctorName,
                        style: TextStyles(context).getBoldStyle(
                            fontSize: 16, color: ColorPalette.deepBlue),
                      ),
                      Text(appointmentName),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.width * 0.008),
                child: Row(
                  children: [
                    _schedule(
                        iconData: Icons.calendar_today,
                        info: date,
                        context: context),
                    _schedule(
                        iconData: Icons.access_time,
                        info: time,
                        context: context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _schedule(
      {required IconData iconData,
      required String info,
      required BuildContext context}) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
      decoration: BoxDecoration(
        color: ColorPalette.whiteColor,
        borderRadius: BorderRadius.circular(13.0),
      ),
      child: Row(
        children: [
          Icon(iconData, color: ColorPalette.deepBlue, size: 12.0),
          const SizedBox(width: 6.0),
          Text(info,
              style: TextStyles(context)
                  .getRegularStyle(size: 12, color: ColorPalette.deepBlue)),
        ],
      ),
    );
  }
}
