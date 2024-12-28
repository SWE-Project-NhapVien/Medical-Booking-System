import 'package:admin_webapp/bloc/report/report_event.dart';
import 'package:admin_webapp/screen/report/BarChart/bar_chart_weekly_appointment.dart';
import 'package:admin_webapp/screen/report/NumberIterm/card_item.dart';
import 'package:admin_webapp/screen/report/RecentAppointments/recent_appointment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../DataLayer/data/report_data_provider.dart';
import '../../DataLayer/repository/report_repository.dart';
import '../../bloc/report/report_bloc.dart';
import '../../bloc/report/report_state.dart';
import '../../class/report.dart';
import '../../utils/color_palette.dart';
import '../../utils/fixed_web_component.dart';
import 'PieChartOrderStatus/pie_chart.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (context) =>
            ReportRepository(reportDataProvider: ReportDataProvider()),
        child: BlocProvider(
          create: (context) => ReportBloc(
            reportRepository: context.read<ReportRepository>(),
          ),
          child: const ReportScreenHelper(),
        ));
  }
}

class ReportScreenHelper extends StatefulWidget {
  const ReportScreenHelper({super.key});

  @override
  State<ReportScreenHelper> createState() => _ReportScreenHelperState();
}

class _ReportScreenHelperState extends State<ReportScreenHelper> {
  @override
  void didChangeDependencies() {
    context.read<ReportBloc>().add(RequestReportEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double lottieSize = size.width * 0.2;
    return Scaffold(
      backgroundColor: ColorPalette.mediumBlue,
      body: Padding(
        padding: EdgeInsets.only(
            left: 10,
            right: 20,
            top: MediaQuery.of(context).size.height * 0.05 - 20,
            bottom: MediaQuery.of(context).size.height * 0.05 - 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: ColorPalette.mediumBlue,
                ),
                child: BlocConsumer<ReportBloc, ReportState>(
                  listener: (context, state) {
                    if (state is LoadingReportState) {
                      Center(
                        child: AlertDialog(
                          backgroundColor: Colors.transparent,
                          content: Lottie.asset(
                            FixedWebComponent.loading,
                            width: lottieSize,
                          ),
                        ),
                      );
                    } else if (state is ErrorReportState) {
                      print(state.message);
                    }
                  },
                  builder: (context, state) {
                    if (state is SucessReportState) {
                      Report report = state.report;
                      int totalAppointment = report.appointments.length;
                      int priceAppointment = totalAppointment != 0
                          ? report.appointments[0].price
                          : 125000;
                      return SingleChildScrollView(
                          child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // card
                              CardItem(
                                title: 'Total Appointment',
                                description:
                                    report.appointments.length.toString(),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              CardItem(
                                title: 'Total revenue',
                                description:
                                    '${report.appointments.length * priceAppointment} VND',
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              CardItem(
                                title: 'An appointment price',
                                description: '$priceAppointment VND',
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              CardItem(
                                title: 'Total patient',
                                description:
                                    report.totalPatientAccount.toString(),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  BarChartWeeklyAppointment(
                                    appointment: report.appointments,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  RecentAppointment(
                                      appointmentList: report.appointments),
                                ],
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: PieChartOrderStatus(
                                  appointments: report.appointments,
                                ),
                              )
                            ],
                          ),

                          // recent
                        ],
                      ));
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
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
