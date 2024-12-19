import 'package:booking_doctor_project/utils/color_palette.dart';
import 'package:booking_doctor_project/widgets/common_app_bar_view.dart';
import 'package:booking_doctor_project/widgets/common_button.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.whiteColor,
      body: Column(
        children: [
          const CommonAppBarView(
            iconData: Icons.arrow_back_ios,
            title: '',
          ),
          const SizedBox(
            height: 40,
          ),
          SizedBox(
              height: 400,
              width: 400,
              child: Image.asset('assets/images/payment.jpg')),
          const SizedBox(
            height: 40,
          ),
          CommonButton(
            width: 350,
            height: 48,
            onTap: () {},
            backgroundColor: ColorPalette.deepBlue,
            buttonTextWidget: Text(
              'Finish',
              style: TextStyle(
                color: ColorPalette.whiteColor,
                fontSize: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
