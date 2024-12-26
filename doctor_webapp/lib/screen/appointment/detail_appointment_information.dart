import 'package:doctor_webapp/utils/color_palette.dart';
import 'package:doctor_webapp/utils/fixed_web_component.dart';
import 'package:doctor_webapp/widgets/comon_button.dart';
import 'package:flutter/material.dart';

class DetailAppointmentInformation extends StatelessWidget {
  const DetailAppointmentInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: ColorPalette.deepBlue,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Appointment Information',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: ColorPalette.whiteColor,
                )),
            const SizedBox(height: 40),
            const CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage(FixedWebComponent
                  .defaultPatientAvatar), // Replace with your image
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Container(
                width: 400,
                decoration: BoxDecoration(
                  color: ColorPalette.whiteColor,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: ColorPalette.deepBlue,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'John Doe',
                          style: TextStyle(
                            fontSize: 16,
                            color: ColorPalette.blackColor,
                          ),
                        ),
                        Divider(
                          color: ColorPalette.deepBlue,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Age',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: ColorPalette.deepBlue,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '25',
                          style: TextStyle(
                            fontSize: 16,
                            color: ColorPalette.blackColor,
                          ),
                        ),
                        Divider(
                          color: ColorPalette.deepBlue,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Gender',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: ColorPalette.deepBlue,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Male',
                          style: TextStyle(
                            fontSize: 16,
                            color: ColorPalette.blackColor,
                          ),
                        ),
                        Divider(
                          color: ColorPalette.deepBlue,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Time',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: ColorPalette.deepBlue,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '24/12/2024 10:00 AM',
                          style: TextStyle(
                            fontSize: 16,
                            color: ColorPalette.blackColor,
                          ),
                        ),
                        Divider(
                          color: ColorPalette.deepBlue,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: ColorPalette.deepBlue,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'uwwuuwwuuwwuuwwuuwwuuwwuuwwuuwwuuwwuuwwuuwwuuwwuuwwuuwwuuwwuuwwuuwwuuwwuuwwuuwwuuwwuuwwuuwwuuwwuuwwuuwwuuwwuuwwuuwwuuwwuuwwuuwwuuwwuuwwuuwwuuwwuuwwuuwwuuwwuuwwuuwwuuwwu',
                          style: TextStyle(
                            fontSize: 16,
                            color: ColorPalette.blackColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 260,
              child: CommonButton(
                backgroundColor: ColorPalette.mediumBlue,
                onTap: () {},
                buttonText: 'Examine',
                textColor: ColorPalette.deepBlue,
                fontSize: 26,
              ),
            )
          ],
        ),
      ),
    );
  }
}
