sealed class GetSpecificAppointmentData {}

class GetSpecificAppointmentDataEvent extends GetSpecificAppointmentData {
  final String appointmentId;

  GetSpecificAppointmentDataEvent({required this.appointmentId});
}
