import 'package:doctor_webapp/screen/appointment/appointment_screen.dart';
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
                  child: Icon(
                    Icons.settings,
                    color: ColorPalette.deepBlue,
                    size: 30,
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              GestureDetector(
                onTap: () {
                  _showNotificationDialog(context);
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: ColorPalette.whiteColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.notifications,
                      color: ColorPalette.deepBlue,
                      size: 30,
                    ),
                  ),
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

  void _showNotificationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            width: 360,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: ColorPalette.deepBlue,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Today",
                      style: TextStyle(
                        color: ColorPalette.whiteColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop(); // Close dialog
                      },
                      child: Icon(
                        Icons.close,
                        color: ColorPalette.whiteColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _buildNotificationItem(
                    icon: Icons.calendar_today,
                    title: "Scheduled Appointment",
                    time: "2 M",
                    content:
                        "You have a new appointment on December, 31 15:30"),
                _buildNotificationItem(
                    icon: Icons.event,
                    title: "Scheduled Change",
                    time: "2 H",
                    content:
                        "Appointment on December,27 10:AM has been canceled"),
                _buildNotificationItem(
                    icon: Icons.note_alt,
                    title: "Medical Notes",
                    time: "3 H",
                    content:
                        "Update medical results complete for Khang Nguyen"),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(); // Close dialog
                  },
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Mark all",
                      style: TextStyle(
                        color: ColorPalette.whiteColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNotificationItem(
      {required IconData icon,
      required String title,
      required String time,
      required String content}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(icon, color: Colors.blue[700]),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  content,
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
