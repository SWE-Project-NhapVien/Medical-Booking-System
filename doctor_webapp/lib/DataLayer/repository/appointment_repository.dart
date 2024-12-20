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
      final appointmentData0 = await _appointmentDataProvider
          .getAppointmentData(typeAppointment: typeAppointment);
      for (var i = 0; i < appointmentData0.length; i++) {
        appointmentData.add(Appointment.fromMap(appointmentData0[i]));
      }
      return appointmentData;
    } catch (e) {
      throw e.toString();
    }
  }
}
