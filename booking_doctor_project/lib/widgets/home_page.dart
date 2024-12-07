import 'package:booking_doctor_project/screen/ChatScreen/chat_screen.dart';
import 'package:booking_doctor_project/screen/HomeScreen/home_screen.dart';
import 'package:booking_doctor_project/utils/color_palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int myCurrentIndex = 0;
  List pages = const [
    HomeScreen(),
    ChatScreen1(),
    ChatScreen2(),
    ChatScreen3(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 25,
              offset: const Offset(8, 20))
        ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: ColorPalette.deepBlue,
              selectedItemColor: ColorPalette.superDeepBlue,
              unselectedItemColor: ColorPalette.whiteColor,
              currentIndex: myCurrentIndex,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              onTap: (index) {
                setState(() {
                  myCurrentIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.chat_bubble_2), label: "Chat"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline), label: "Profile"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.calendar_month_outlined),
                    label: "Appointment"),
              ]),
        ),
      ),
      body: pages[myCurrentIndex],
    );
  }
}
