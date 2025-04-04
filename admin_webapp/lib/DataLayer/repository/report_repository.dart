import 'package:admin_webapp/DataLayer/data/report_data_provider.dart';
import 'package:admin_webapp/class/report.dart';

import '../../class/appointment.dart';

class ReportRepository {
  final ReportDataProvider _ReportDataProvider;

  ReportRepository({required ReportDataProvider reportDataProvider})
      : _ReportDataProvider = reportDataProvider;

  Future<Report> getReportData() async {
    try {
      final (totalPatientAccount, appointment) =
          await _ReportDataProvider.fetchReportData();
      List<Appointment> appointments = [];
      for (var i = 0; i < appointment.length; i++) {
        appointments.add(Appointment.fromJson(appointment[i]));
      }
      return Report(
          totalPatientAccount: totalPatientAccount, appointments: appointments);
    } catch (e) {
      throw e.toString();
    }
  }
}
