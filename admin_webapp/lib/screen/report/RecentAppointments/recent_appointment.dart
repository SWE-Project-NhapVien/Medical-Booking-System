import 'package:admin_webapp/class/appointment.dart';
import 'package:admin_webapp/utils/color_palette.dart';
import 'package:admin_webapp/utils/text_styles.dart';
import 'package:flutter/material.dart';

class RecentAppointment extends StatelessWidget {
  final List<Appointment> appointmentList;

  const RecentAppointment({super.key, required this.appointmentList});

  Color _getStatusColor(String status) {
    switch (status) {
      case "Cancelled":
        return ColorPalette.proportionRed;
      case "Upcoming":
        return ColorPalette.proportionAmber;
      case "Completed":
        return ColorPalette.proportionGreen;
      default:
        return Colors.grey;
    }
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
      child: SingleChildScrollView(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: DataTable(
            columns: [
              DataColumn(
                  label: Text("Order ID",
                      style: TextStyles(context)
                          .getRegularStyle(fontWeight: FontWeight.w500))),
              DataColumn(
                  label: Text("Date",
                      style: TextStyles(context)
                          .getRegularStyle(fontWeight: FontWeight.w500))),
              DataColumn(
                  label: Text("Status",
                      style: TextStyles(context)
                          .getRegularStyle(fontWeight: FontWeight.w500))),
              DataColumn(
                  label: Text("Amount",
                      style: TextStyles(context)
                          .getRegularStyle(fontWeight: FontWeight.w500))),
            ],
            rows: appointmentList.take(10).map((appointment) {
              return DataRow(cells: [
                DataCell(Text(appointment.appointmentId)),
                DataCell(Text(appointment.date)),
                DataCell(Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor(appointment.status).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    appointment.status,
                    style: TextStyle(
                      color: _getStatusColor(appointment.status),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
                DataCell(Text(appointment.price.toString())),
              ]);
            }).toList(),
          ),
        ),
      ),
    );
  }
}
