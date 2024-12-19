import 'package:booking_doctor_project/utils/color_palette.dart';
import 'package:booking_doctor_project/widgets/common_button.dart';
import 'package:flutter/material.dart';

class PaymentSuccesfulScreen extends StatelessWidget {
  const PaymentSuccesfulScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.deepBlue,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * 0.05,
              AppBar().preferredSize.height,
              MediaQuery.of(context).size.width * 0.1,
              MediaQuery.of(context).size.height * 0.01,
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back_ios,
                      color: ColorPalette.whiteColor),
                ),
                const Expanded(
                  child: Center(
                    child: Text(
                      '',
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Icon(
            Icons.check_circle_outline,
            size: 200,
            color: ColorPalette.whiteColor,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Congratulations',
            style: TextStyle(
              color: ColorPalette.whiteColor,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Booking Successful!',
            style: TextStyle(
              color: ColorPalette.whiteColor,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
            height: 160,
            width: 300,
            decoration: BoxDecoration(
              color: ColorPalette.deepBlue,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: ColorPalette.whiteColor,
                width: 2,
              ),
            ),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'You have successfully booked an',
                    style: TextStyle(color: ColorPalette.whiteColor),
                  ),
                  Text(
                    'appointment with',
                    style: TextStyle(color: ColorPalette.whiteColor),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Dr. Olivia Turner, M.D.',
                    style: TextStyle(
                        color: ColorPalette.whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: ColorPalette.whiteColor,
                      ),
                      Text(
                        'December 24, 2024',
                        style: TextStyle(color: ColorPalette.whiteColor),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Icon(
                        Icons.alarm,
                        color: ColorPalette.whiteColor,
                      ),
                      Text(
                        '10:00 AM',
                        style: TextStyle(color: ColorPalette.whiteColor),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          CommonButton(
            width: 300,
            height: 48,
            onTap: () {},
            backgroundColor: ColorPalette.lightBlue,
            buttonTextWidget: Text(
              'Back to HomePage',
              style: TextStyle(
                color: ColorPalette.deepBlue,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
