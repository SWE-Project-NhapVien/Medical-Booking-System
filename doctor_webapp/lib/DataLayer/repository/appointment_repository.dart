import 'package:doctor_webapp/DataLayer/data/appointment_data_provider.dart';
import 'package:doctor_webapp/class/appointment.dart';

class AppointmentRepository {
  final AppointmentDataProvider _appointmentDataProvider;

  AppointmentRepository(
      {required AppointmentDataProvider appointmentDataProvider})
      : _appointmentDataProvider = appointmentDataProvider;

  Future<List<Appointment>> getAppointmentData(
      {required String typeAppointment}) async {
    try {
      List<Appointment> appointmentData = [];
      final _appointmentData = await _appointmentDataProvider
          .getAppointmentData(typeAppointment: typeAppointment);
      for (var i = 0; i < _appointmentData.length; i++) {
        appointmentData.add(Appointment.fromMap(_appointmentData[i]));
      }
      return appointmentData;
    } catch (e) {
      throw e.toString();
    }
  }
}
