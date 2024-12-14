sealed class UpcomingAppointmentEvent{}

final class RequestUpcomingAppointmentEvent extends UpcomingAppointmentEvent{
  final String profileId;
  RequestUpcomingAppointmentEvent({required this.profileId});
}
