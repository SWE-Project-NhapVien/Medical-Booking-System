import 'package:booking_doctor_project/utils/localfiles.dart';
import 'package:booking_doctor_project/utils/text_styles.dart';
import 'package:booking_doctor_project/utils/color_palette.dart';
import 'package:booking_doctor_project/widgets/tap_effect.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentCard extends StatelessWidget {
  final String doctorName;
  final String appointmentName;
  final String date;
  final String time;
  final String doctorImage;
  final String price;
  final VoidCallback onTap;

  const AppointmentCard({
    super.key,
    required this.doctorName,
    required this.appointmentName,
    required this.date,
    required this.time,
    required this.onTap,
    required this.doctorImage,
    this.price = '',
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return TapEffect(
      onClick: () => onTap(),
      child: Card(
        color: ColorPalette.mediumBlue,
        margin: EdgeInsets.symmetric(
          vertical: size.height * 0.02,
          horizontal: size.width * 0.02,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.03, vertical: size.height * 0.02),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundImage: doctorImage.isNotEmpty
                        ? NetworkImage(doctorImage)
                        : const AssetImage(Localfiles.defaultProfilePicture),
                  ),
                  SizedBox(width: size.width * 0.03),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctorName,
                        style: TextStyles(context).getTitleStyle(
                            size: 20,
                            fontWeight: FontWeight.w500,
                            color: ColorPalette.deepBlue),
                      ),
                      Text(
                        appointmentName,
                        style: TextStyles(context)
                            .getRegularStyle(fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.02),
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
                    _schedule(
                        iconData: Icons.money_off_csred_rounded,
                        info: price.isNotEmpty ? formatPrice(price) : '',
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
      child: Center(
        child: Row(
          children: [
            Icon(iconData, color: ColorPalette.deepBlue, size: 12.0),
            const SizedBox(width: 6.0),
            Text(info,
                style: TextStyles(context)
                    .getRegularStyle(size: 14, color: ColorPalette.deepBlue)),
          ],
        ),
      ),
    );
  }
}

String formatPrice(String price) {
  if (price.isEmpty) return '';
  final formatter = NumberFormat('#,##0', 'en_US');
  return '${formatter.format(int.parse(price))} VND';
}
