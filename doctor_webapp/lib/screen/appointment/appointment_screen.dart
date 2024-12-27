import 'package:doctor_webapp/DataLayer/data/appointment_data_provider.dart';
import 'package:doctor_webapp/bloc/Appointment/appointment_bloc.dart';
import 'package:doctor_webapp/bloc/SpecificAppointment/specific_appointment_bloc.dart';
import 'package:doctor_webapp/screen/appointment/completed_appointment_screen.dart';
import 'package:doctor_webapp/screen/appointment/detail_appointment_information_2.dart';
import 'package:doctor_webapp/screen/appointment/upcoming_appointment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../DataLayer/repository/appointment_repository.dart';
import '../../utils/color_palette.dart';
import '../../utils/enum.dart';
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
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AppointmentBloc(
                appointmentRepository: context.read<AppointmentRepository>()),
          ),
          BlocProvider(
            create: (context) => GetSpecificAppointmentDataBloc(),
          ),
        ],
        child: Expanded(
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Appointments",
                      style: TextStyle(
                          color: ColorPalette.deepBlue,
                          fontSize: 36,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Container(
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
                                onTap: (value) {
                                  switch (value) {
                                    case 0:
                                      appointmentType =
                                          AppointmentType.upcoming;
                                      break;
                                    case 1:
                                      appointmentType =
                                          AppointmentType.completed;
                                      break;
                                    case 2:
                                      appointmentType =
                                          AppointmentType.cancelled;
                                      break;
                                  }
                                },
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
              const SizedBox(width: 30),
              appointmentType == AppointmentType.upcoming
                  ? const Expanded(
                      flex: 2, child: DetailAppointmentInformation())
                  : const Expanded(
                      flex: 2, child: DetailAppointmentInformation2())
            ],
          ),
        ),
      ),
    );
  }
}
