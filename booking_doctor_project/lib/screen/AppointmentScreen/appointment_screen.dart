import 'package:booking_doctor_project/bloc/Appointment/CancelledAppointment/cancelled_appointment_bloc.dart';
import 'package:booking_doctor_project/bloc/Appointment/CompleteAppointment/complete_appointment_bloc.dart';
import 'package:booking_doctor_project/bloc/Appointment/UpcomingAppointment/upcoming_appointment_bloc.dart';
import 'package:booking_doctor_project/screen/AppointmentScreen/cancelled_appointment.dart';
import 'package:booking_doctor_project/screen/AppointmentScreen/complete_appointment.dart';
import 'package:booking_doctor_project/utils/color_palette.dart';
import 'package:booking_doctor_project/utils/localfiles.dart';
import 'package:booking_doctor_project/widgets/common_app_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../utils/enum.dart';
import 'tab_button.dart';
import 'upcoming_appointment.dart';

// ignore: must_be_immutable
class AppointmentScreen extends StatefulWidget {
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
    appointmentType = AppointmentType.Upcoming;
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
      indexView = const UpcomingAppointment();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MultiBlocProvider(
      providers: [
        BlocProvider<CompleteAppointmentBloc>(
            create: (context) => CompleteAppointmentBloc()),
        BlocProvider<CancelledAppointmentBloc>(
            create: (context) => CancelledAppointmentBloc()),
        BlocProvider<UpcomingAppointmentBloc>(
            create: (context) => UpcomingAppointmentBloc()),
      ],
      child: Scaffold(
        backgroundColor: ColorPalette.whiteColor,
        body: isFirstTime
            ? AlertDialog(
                backgroundColor: Colors.transparent,
                content: Lottie.asset(
                  Localfiles.loading,
                  width: size.width * 0.2,
                ))
            : Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: Column(
                  children: [
                    CommonAppBarView(
                      iconData: Icons.arrow_back_ios_new_rounded,
                      title: 'All Appointments',
                      onBackClick: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      child: _buildTab(size),
                    ),
                    Expanded(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(1, 0),
                                end: Offset.zero,
                              ).animate(animation),
                              child: child,
                            ),
                          );
                        },
                        child: indexView,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildTab(Size size) {
    return Padding(
      padding: EdgeInsets.only(bottom: size.height * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TabButton(
            isSelected: appointmentType == AppointmentType.Upcoming,
            text: "Upcoming",
            onTap: () {
              _tabClick(AppointmentType.Upcoming);
            },
          ),
          SizedBox(
            width: size.width * 0.02,
          ),
          TabButton(
            isSelected: appointmentType == AppointmentType.Complete,
            text: "Complete",
            onTap: () {
              _tabClick(AppointmentType.Complete);
            },
          ),
          SizedBox(
            width: size.width * 0.02,
          ),
          TabButton(
            isSelected: appointmentType == AppointmentType.Cancelled,
            text: "Canceled",
            onTap: () {
              _tabClick(AppointmentType.Cancelled);
            },
          ),
        ],
      ),
    );
  }

  void _tabClick(AppointmentType tabType) {
    if (tabType != appointmentType) {
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
