import 'package:booking_doctor_project/utils/color_palette.dart';
import 'package:booking_doctor_project/widgets/common_app_bar_view.dart';
import 'package:flutter/material.dart';

class DoctorInfoScreen extends StatelessWidget {
  const DoctorInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CommonAppBarView(
            iconData: Icons.arrow_back_ios,
            title: "Doctor Info",
            onBackClick: () {
              Navigator.pop(context);
            },
          ),
          Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
                vertical: MediaQuery.of(context).size.height * 0.01,
              ),
              child: Column(
                children: [
                  Container(
                    height: 360,
                    decoration: BoxDecoration(
                      color: ColorPalette.mediumBlue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
