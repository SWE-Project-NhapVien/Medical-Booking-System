import 'package:booking_doctor_project/class/appointment.dart';
import 'package:booking_doctor_project/utils/text_styles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../utils/color_palette.dart';

// ignore: must_be_immutable
class BarChartWeeklyAppointment extends StatefulWidget {
  List<Appointment> appointment;
  BarChartWeeklyAppointment({super.key, required this.appointment});

  @override
  State<BarChartWeeklyAppointment> createState() =>
      _BarChartWeeklyAppointmentState();
}

class _BarChartWeeklyAppointmentState extends State<BarChartWeeklyAppointment> {
  late List<int> appointmentPerDay;
  int maxValue = 0;

  @override
  void initState() {
    appointmentPerDay =
        List.generate(7, (index) => 0); // Initialize the list with zeros

    for (var appointment in widget.appointment) {
      try {
        // Parse the ISO 8601 date string
        DateTime appointmentDate = DateTime.parse(appointment.date);
        int dayIndex =
            appointmentDate.weekday - 1; // Convert to Monday = 0, Sunday = 6
        appointmentPerDay[dayIndex]++;
      } catch (e) {
        print("Error parsing date: ${appointment.date}");
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      width: MediaQuery.of(context).size.width * 0.6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: ColorPalette.greyColor,
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            'Weekly Appointment',
            style: TextStyles(context)
                .getBoldStyle(color: ColorPalette.deepBlue, fontSize: 16),
          ),
          const SizedBox(
            height: 32,
          ),
          Expanded(
            child: BarChart(
              randomData(),
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y,
  ) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          borderRadius: BorderRadius.circular(10),
          color: ColorPalette.deepBlue,
          width: 50,
          borderSide: const BorderSide(width: 0.0),
        ),
      ],
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    Widget text = Text(days[value.toInt()],
        style: TextStyles(context).getRegularStyle(size: 16));

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  Widget _getLeftTitles(double value, TitleMeta meta) {
    return Text(
      value.toInt().toString(),
      style: TextStyles(context).getRegularStyle(size: 14),
      textAlign: TextAlign.center,
    );
  }

  BarChartData randomData() {
    return BarChartData(
      maxY: maxValue + 10.0,
      barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            tooltipPadding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
            tooltipMargin: 4, // Add margin between the bar and tooltip
            fitInsideHorizontally:
                true, // Ensure tooltip stays within horizontal bounds
            fitInsideVertically:
                true, // Ensure tooltip stays within vertical bounds
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                  '${rod.toY.toInt()}',
                  TextStyles(context)
                      .getRegularStyle(size: 16, color: Colors.white),
                  textAlign: TextAlign.left);
            },
          ),
          enabled: true),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 60,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
              reservedSize: 30,
              showTitles: true,
              interval: maxValue < 10 ? 5 : 10,
              getTitlesWidget: _getLeftTitles),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: List.generate(
        7,
        (i) => makeGroupData(
          i,
          appointmentPerDay[i].toDouble(),
        ),
      ),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        drawVerticalLine: false,
        horizontalInterval: maxValue < 10 ? 5 : 10,
      ),
    );
  }
}
