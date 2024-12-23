sealed class UpcomingAppointmentEvent {}

final class RequestUpcomingAppointmentEvent extends UpcomingAppointmentEvent {
  final String profileId;
  RequestUpcomingAppointmentEvent({required this.profileId});
}

final class AddAppointmentEvent extends UpcomingAppointmentEvent {
  final String doctorId;
  final String patientId;
  final String timeslotId;
  final String description;
  AddAppointmentEvent(
      {required this.doctorId,
      required this.patientId,
      required this.timeslotId,
      required this.description});
}
