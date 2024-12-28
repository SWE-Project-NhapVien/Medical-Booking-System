sealed class GetSpecificAppointmentData2 {}

class GetSpecificAppointmentDataEvent2 extends GetSpecificAppointmentData2 {
  final String appointmentId;

  GetSpecificAppointmentDataEvent2({required this.appointmentId});
}
