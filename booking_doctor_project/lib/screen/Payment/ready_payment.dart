import 'package:booking_doctor_project/utils/color_palette.dart';
import 'package:booking_doctor_project/utils/text_styles.dart';
import 'package:booking_doctor_project/widgets/common_button.dart';
import 'package:flutter/material.dart';

class ReadyPaymentScreen extends StatelessWidget {
  const ReadyPaymentScreen({super.key});

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
                Expanded(
                  child: Center(
                    child: Text('Payment',
                        style: TextStyles(context).getBoldStyle(
                            fontSize: 24.0, color: ColorPalette.whiteColor)),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
              vertical: MediaQuery.of(context).size.height * 0.01,
            ),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text('125.000 VND',
                    style: TextStyles(context).getBoldStyle(
                        fontSize: 48.0, color: ColorPalette.whiteColor)),
                const SizedBox(height: 20),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: ColorPalette.whiteColor,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: Image.network(
                                'https://www.shutterstock.com/image-vector/male-doctor-smiling-happy-face-600nw-2481032615.jpg',
                              ).image)),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Xuan Thanh Dao",
                              style: TextStyle(
                                  color: ColorPalette.deepBlue,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              'Artificial Intelligence',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Container(
                          height: 28,
                          width: 28,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorPalette.lightBlue,
                          ),
                          child: Icon(
                            Icons.star,
                            color: ColorPalette.deepBlue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Divider(
                      color: ColorPalette.deepBlue,
                      thickness: 2,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 10),
                        Text('Date / Hour',
                            style: TextStyle(color: ColorPalette.deepBlue)),
                        const Spacer(),
                        Text('Month 24, Year / 10:00 AM',
                            style: TextStyle(color: ColorPalette.blackColor)),
                        const SizedBox(width: 10),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 10),
                        Text('Duration',
                            style: TextStyle(color: ColorPalette.deepBlue)),
                        const Spacer(),
                        Text('30 minutes',
                            style: TextStyle(color: ColorPalette.blackColor)),
                        const SizedBox(width: 10),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Divider(
                      color: ColorPalette.deepBlue,
                      thickness: 2,
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    CommonButton(
                      height: 48,
                      onTap: () {},
                      backgroundColor: ColorPalette.deepBlue,
                      buttonTextWidget: Text(
                        'Pay Now',
                        style: TextStyle(
                          color: ColorPalette.whiteColor,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
