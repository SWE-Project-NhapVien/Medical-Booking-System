import 'package:booking_doctor_project/bloc/report/report_event.dart';
import 'package:booking_doctor_project/screen/report/NumberIterm/card_item.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../DataLayer/data/Report_data_provider.dart';
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
          child: ReportScreenHelper(),
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
    double lottieSize = MediaQuery.of(context).size.width * 0.2;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "Report",
              style: TextStyles(context)
                  .getBoldStyle(fontSize: 36, color: ColorPalette.deepBlue),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 8, 10),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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

                        Row(
                          children: [
                            // line
                            Expanded(
                              flex: 2,
                              child: Container(
                                color: Colors.blue,
                                width: 80,
                                height: 100,
                              ),
                            ),

                            //pie
                            Expanded(
                              child: PieChartOrderStatus(
                                appointments: report.appointments,
                              ),
                            )
                            // Expanded(
                            //   child: Container(
                            //     color: Colors.black,
                            //     height: 150,
                            //     width: 100,
                            //   ),
                            // ),
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
