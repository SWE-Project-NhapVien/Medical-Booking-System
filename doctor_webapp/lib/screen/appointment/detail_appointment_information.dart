import 'package:doctor_webapp/utils/color_palette.dart';
import 'package:doctor_webapp/utils/fixed_web_component.dart';
import 'package:flutter/material.dart';

class DetailAppointmentInformation extends StatelessWidget {
  const DetailAppointmentInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 16, 20, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: ColorPalette.deepBlue,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(FixedWebComponent.defaultPatientAvatar), // Replace with your image
            ),
            const SizedBox(height: 16),
            Text(
              "Appointment name",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Name: XXX\nAge: XXX\nSymptoms:\n- Symptom 1\n- Symptom 2\n- Symptom 3",
              style: TextStyle(fontSize: 16),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                // Add action
              },
              style: ElevatedButton.styleFrom(),
              child: Text("Detail"),
            ),
          ],
        ),
      ),
    );
  }
}
