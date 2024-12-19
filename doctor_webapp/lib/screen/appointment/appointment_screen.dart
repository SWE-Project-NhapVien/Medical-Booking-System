import 'package:doctor_webapp/DataLayer/data/appointment_data_provider.dart';
import 'package:doctor_webapp/bloc/Appointment/appointment_bloc.dart';
import 'package:doctor_webapp/screen/appointment/completed_appointment_screen.dart';
import 'package:doctor_webapp/screen/appointment/upcoming_appointment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../DataLayer/repository/appointment_repository.dart';
import '../../utils/color_palette.dart';
import '../../utils/enum.dart';
import '../../utils/text_styles.dart';
import 'cancelled_appointment_screen.dart';
import 'detail_appointment_information.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  late AppointmentType appointmentType;
  late Widget indexView;

  @override
  void initState() {
    appointmentType = AppointmentType.upcoming;
    indexView = const UpcomingAppointmentScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AppointmentRepository(
          appointmentDataProvider: AppointmentDataProvider()),
      child: BlocProvider(
        create: (context) => AppointmentBloc(appointmentRepository: context.read<AppointmentRepository>()),
        child: Scaffold(
          body: Row(
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Appointments",
                        style: TextStyles(context).getBoldStyle(
                            fontSize: 36, color: ColorPalette.deepBlue),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(20, 10, 8, 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: DefaultTabController(
                          animationDuration: const Duration(milliseconds: 300),
                          length: 3,
                          child: Column(
                            children: [
                              TabBar(
                                padding: const EdgeInsets.all(10),
                                unselectedLabelColor:
                                    ColorPalette.unselectedTabAppointment,
                                labelColor: ColorPalette.deepBlue,
                                indicatorColor: ColorPalette.deepBlue,
                                tabs: const [
                                  Tab(
                                    child: Text(
                                      "Upcoming",
                                      style: TextStyle(fontSize: 24),
                                    ),
                                  ),
                                  Tab(
                                    child: Text(
                                      "Completed",
                                      style: TextStyle(fontSize: 24),
                                    ),
                                  ),
                                  Tab(
                                    child: Text(
                                      "Cancelled",
                                      style: TextStyle(fontSize: 24),
                                    ),
                                  ),
                                ],
                              ),
                              const Expanded(
                                child: TabBarView(
                                  children: [
                                    UpcomingAppointmentScreen(),
                                    CompletedAppointmentScreen(),
                                    CancelledAppointmentScreen(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(flex: 2, child: const DetailAppointmentInformation()),
            ],
          ),
        ),
      ),
    );
  }
}
