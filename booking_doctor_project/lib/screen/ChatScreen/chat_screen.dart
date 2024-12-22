import 'package:booking_doctor_project/utils/color_palette.dart';
import 'package:flutter/material.dart';

class ChatScreen1 extends StatelessWidget {
  const ChatScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.whiteColor,
      body: Center(
        child: Text(
          "AVAILABLE SOON!",
          style: TextStyle(
              fontSize: 36,
              color: ColorPalette.deepBlue,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
