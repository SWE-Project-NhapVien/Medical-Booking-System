import 'package:admin_webapp/utils/color_palette.dart';
import 'package:admin_webapp/utils/localfiles.dart';
import 'package:admin_webapp/utils/text_styles.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PatientDetailedInformation extends StatefulWidget {
  PatientDetailedInformation({
    super.key,
    required this.fullname,
    required this.email,
    required this.phoneNumber,
    required this.dob,
    required this.address,
    this.avaUrl = '',
    required this.allergies,
    required this.medicalHistory,
  });

  final String fullname;
  final String email;
  final String phoneNumber;
  final String dob;
  final String address;
  String avaUrl;
  final List<String> allergies;
  final List<String> medicalHistory;

  @override
  State<PatientDetailedInformation> createState() =>
      _PatientDetailedInformationState();
}

class _PatientDetailedInformationState
    extends State<PatientDetailedInformation> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.3,
      margin: EdgeInsets.only(right: size.width * 0.01),
      decoration: BoxDecoration(
        color: ColorPalette.deepBlue,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
        child: Column(
          children: [
            CircleAvatar(
              radius: size.width * 0.035,
              backgroundImage: widget.avaUrl.isNotEmpty
                  ? NetworkImage(widget.avaUrl)
                  : const AssetImage(Localfiles.defaultProfilePicture),
            ),
            SizedBox(height: size.height * 0.01),
            Text(
              widget.fullname,
              style: TextStyles(context).getRegularStyle(
                  size: 24,
                  color: ColorPalette.whiteColor, 
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: size.height * 0.01),
            Container(
              decoration: BoxDecoration(
                color: ColorPalette.whiteColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _inforBox(title: 'Email', info: widget.email, context: context, size: size),
                  _inforBox(title: 'Phone Number', info: widget.phoneNumber, context: context, size: size),
                  _inforBox(title: 'Date of Birth', info: widget.dob, context: context, size: size),
                  _inforBox(title: 'Address', info: widget.address, context: context, size: size),
                  _inforBox(title: 'Allergy', info: widget.allergies.join(', '), context: context, size: size),
                  _inforBox(title: 'Medical History', info: widget.medicalHistory.join(', '), context: context, size: size)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


Widget _inforBox(
      {required String title,
      required String info,
      required BuildContext context,
      required Size size,
      }) {
    return Container(
      width: size.width * 0.25,
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.02, vertical: size.height * 0.01),
      decoration: BoxDecoration(
        color: ColorPalette.whiteColor,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Center(
        child: Row(
          children: [
            Text(
              '$title:',
              style: TextStyles(context).getRegularStyle(
                  size: 14,
                  color: ColorPalette.deepBlue,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 6.0),
            Text(info,
                style: TextStyles(context)
                    .getRegularStyle(size: 14, color: ColorPalette.deepBlue)),
          ],
        ),
      ),
    );
  }