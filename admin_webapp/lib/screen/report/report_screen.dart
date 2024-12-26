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
import '../../utils/text_styles.dart';
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
      backgroundColor: ColorPalette.blueFormColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.01, vertical: size.height * 0.02),
            child: Text(
              "Report",
              style: TextStyles(context).getTitleStyle(
                  size: 40,
                  color: ColorPalette.deepBlue,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.01),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: ColorPalette.whiteColor,
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
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.01),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // card
                              CardItem(
                                title: 'Total Appointment',
                                description:
                                    report.appointments.length.toString(),
                              ),
                              CardItem(
                                title: 'Total revenue',
                                description:
                                    '${report.appointments.length * priceAppointment} VND',
                              ),
                              CardItem(
                                title: 'An appointment price',
                                description: '$priceAppointment VND',
                              ),
                              CardItem(
                                title: 'Total patient',
                                description:
                                    report.totalPatientAccount.toString(),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
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
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding:
                                    EdgeInsets.only(right: size.width * 0.01),
                                child: PieChartOrderStatus(
                                  appointments: report.appointments,
                                ),
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
    );
  }
}
