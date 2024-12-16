import 'package:booking_doctor_project/utils/color_palette.dart';
import 'package:flutter/material.dart';

class ChatScreen1 extends StatelessWidget {
  const ChatScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

class ChatScreen2 extends StatelessWidget {
  const ChatScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "This is a Chat Screen 2",
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}

class ChatScreen3 extends StatelessWidget {
  const ChatScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "This is a Chat Screen 3",
          overflow: TextOverflow.clip,
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}
