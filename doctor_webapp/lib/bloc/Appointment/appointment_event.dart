sealed class AppointmentEvent {}

final class RequestAppointmentEvent extends AppointmentEvent {
  final String appointmentType;

  RequestAppointmentEvent({required this.appointmentType});
}
