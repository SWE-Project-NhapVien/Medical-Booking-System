import 'package:booking_doctor_project/utils/color_palette.dart';
import 'package:booking_doctor_project/widgets/common_app_bar_view.dart';
import 'package:booking_doctor_project/widgets/comon_button.dart';
import 'package:flutter/material.dart';

class DoctorInfoScreen extends StatelessWidget {
  const DoctorInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 335,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: ColorPalette.mediumBlue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: Image.network(
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2F8DoZLvVpkbPZs1z1dBzXKLvgRNwgUrstA&s',
                              ).image)),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: 40,
                          width: 210,
                          decoration: BoxDecoration(
                            color: ColorPalette.deepBlue,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 10),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
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
                              ),
                              const SizedBox(width: 10),
                              Text(
                                '15 years',
                                style: TextStyle(
                                    color: ColorPalette.whiteColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                ' of experience',
                                style:
                                    TextStyle(color: ColorPalette.whiteColor),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Container(
                            height: 80,
                            decoration: BoxDecoration(
                              color: ColorPalette.whiteColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                const SizedBox(height: 15),
                                Align(
                                  child: Text(
                                    'Dr. Alexander Bennett, Ph.D.',
                                    style: TextStyle(
                                        color: ColorPalette.deepBlue,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const Text(
                                  'Dermato-Genetics',
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Profile',
                    style: TextStyle(
                      color: ColorPalette.deepBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'),
                  const SizedBox(height: 10),
                  Text(
                    'Education & Certification',
                    style: TextStyle(
                      color: ColorPalette.deepBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'),
                  const SizedBox(height: 10),
                  Text(
                    'Career Path',
                    style: TextStyle(
                      color: ColorPalette.deepBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'),
                  const SizedBox(height: 10),
                  Text(
                    'General description',
                    style: TextStyle(
                      color: ColorPalette.deepBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'),
                  const SizedBox(height: 40),
                  Center(
                    child: SizedBox(
                      width: 180,
                      child: CommonButton(
                        onTap: () {},
                        backgroundColor: ColorPalette.deepBlue,
                        buttonTextWidget: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.calendar_month,
                              color: ColorPalette.whiteColor,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Schedule',
                              style: TextStyle(
                                color: ColorPalette.whiteColor,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
