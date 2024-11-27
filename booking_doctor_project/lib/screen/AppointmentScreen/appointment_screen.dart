import 'package:booking_doctor_project/screen/AppointmentScreen/cancelled_appointment.dart';
import 'package:booking_doctor_project/screen/AppointmentScreen/complete_appointment.dart';
import 'package:booking_doctor_project/widgets/common_app_bar_view.dart';
import 'package:flutter/material.dart';

import '../../utils/enum.dart';
// import '../../../widgets/bottom_move_top_animation.dart'; // nho them nay nua nhe
import 'tab_button.dart';
import 'upcoming_appointment.dart';

// ignore: must_be_immutable
class AppointmentScreen extends StatefulWidget {
  // AnimationController animationController;
  // AppointmentScreen({super.key, required this.animationController}); // nho them nay nua nhe
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen>
    with SingleTickerProviderStateMixin {
  late AppointmentType appointmentType;
  late bool isFirstTime;
  late Widget indexView;

  @override
  void initState() {
    isFirstTime = true;
    appointmentType = AppointmentType.Complete;
    indexView = Container();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      starLoadingScreen();
    });
    super.initState();
  }

  Future starLoadingScreen() async {
    await Future.delayed(const Duration(milliseconds: 400));
    setState(() {
      isFirstTime = false;
      indexView = const CompleteAppointment();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isFirstTime
          ? Container(
              child: const CircularProgressIndicator(
                strokeWidth: 2,
              ),
            )
          : Column(
              children: [
                CommonAppBarView(
                  iconData: Icons.arrow_back_ios,
                  title: "All Appointments",
                  onBackClick: () {
                    Navigator.pop(context);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 16.0),
                  child: _buildTab(),
                ),
                Expanded(
                  child: indexView,
                )
              ],
            ),
    );
  }

  Widget _buildTab() {
    return Row(
      children: [
        TabButton(
          isSelected: appointmentType == AppointmentType.Complete,
          text: "Complete",
          onTap: () {
            _tabClick(AppointmentType.Complete);
          },
        ),
        const SizedBox(
          width: 16.0,
        ),
        TabButton(
          isSelected: appointmentType == AppointmentType.Upcoming,
          text: "Upcoming",
          onTap: () {
            _tabClick(AppointmentType.Upcoming);
          },
        ),
        const SizedBox(
          width: 16.0,
        ),
        TabButton(
          isSelected: appointmentType == AppointmentType.Cancelled,
          text: "Cancelled",
          onTap: () {
            _tabClick(AppointmentType.Cancelled);
          },
        ),
      ],
    );
  }

  void _tabClick(AppointmentType tabType) {
    if (tabType != appointmentType) {
      // check because if the user click on the same tab then no need to do anything
      appointmentType = tabType;
      if (tabType == AppointmentType.Complete) {
        indexView = const CompleteAppointment();
      } else if (tabType == AppointmentType.Upcoming) {
        indexView = const UpcomingAppointment();
      } else {
        indexView = const CancelledAppointment();
      }
      setState(() {});
    }
  }
}
