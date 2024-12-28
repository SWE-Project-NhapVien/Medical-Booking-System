import 'package:doctor_webapp/screen/appointment/appointment_screen.dart';
import 'package:doctor_webapp/screen/home/notification_screen.dart';
import 'package:doctor_webapp/screen/profile/profile_screen.dart';
import 'package:doctor_webapp/utils/color_palette.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.mediumBlue,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Row(
          children: [
            Container(
              width: 88,
              decoration: BoxDecoration(
                color: ColorPalette.deepBlue,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                      width: 54,
                      height: 54,
                      child: Image.asset('assets/images/logo.png')),
                  const SizedBox(
                    height: 72,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = 0;
                      });
                    },
                    child: Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: selectedIndex == 0
                            ? ColorPalette.mediumBlue
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.home,
                        color: ColorPalette.whiteColor,
                        size: 30,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = 1;
                      });
                    },
                    child: Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: selectedIndex == 1
                            ? ColorPalette.mediumBlue
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.calendar_month,
                        color: ColorPalette.whiteColor,
                        size: 30,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = 2;
                      });
                    },
                    child: Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: selectedIndex == 2
                            ? ColorPalette.mediumBlue
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.person,
                        color: ColorPalette.whiteColor,
                        size: 30,
                      ),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.logout,
                        color: ColorPalette.whiteColor,
                        size: 30,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            selectedIndex == 0
                ? const HomeView()
                : selectedIndex == 1
                    ? const AppointmentScreen()
                    : const ProfileScreen(),
          ],
        ),
      ),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width - 178,
          child: Row(
            children: [
              Container(
                width: 507,
                decoration: BoxDecoration(
                  color: ColorPalette.whiteColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '“Wear the white coat with dignity and pride—it is an honor and privilege to get to serve the public as a physician.”  - Bill H. Warren',
                    style: TextStyle(
                      color: ColorPalette.deepBlue,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: ColorPalette.whiteColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: IconButton(
                    icon: Icon(
                      Icons.settings,
                      color: ColorPalette.deepBlue,
                      size: 30,
                    ),
                    onPressed: () => debugPrint("Hello"),
                  )
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: ColorPalette.whiteColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: IconButton(
                    icon: Icon(
                        Icons.notifications,
                        color: ColorPalette.deepBlue,
                        size: 30,
                    ),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotificationScreen(),
                      ),
                    ),
                  )
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          width: MediaQuery.of(context).size.width - 178,
          height: 212,
          decoration: BoxDecoration(
            color: ColorPalette.lightBlueTextColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                        style: TextStyle(
                          color: ColorPalette.whiteColor,
                          fontSize: 20,
                        )),
                    const Spacer(),
                    Text(
                      'Welcome!',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorPalette.whiteColor,
                          fontSize: 32),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text('Have a nice day!',
                        style: TextStyle(
                          color: ColorPalette.whiteColor,
                          fontSize: 20,
                        )),
                  ],
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: SizedBox(
                    width: 221,
                    height: 212,
                    child: Image.asset('assets/images/doctor.png')),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          width: MediaQuery.of(context).size.width - 178,
          height: MediaQuery.of(context).size.height - 354,
          decoration: BoxDecoration(
            color: ColorPalette.whiteColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              'Available soon!',
              style: TextStyle(
                color: ColorPalette.deepBlue,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
