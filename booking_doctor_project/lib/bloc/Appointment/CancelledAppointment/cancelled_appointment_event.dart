sealed class CancelledAppointmentEvent{}

final class RequestCancelledAppointmentEvent extends CancelledAppointmentEvent{
  final String profileId;

  RequestCancelledAppointmentEvent({required this.profileId});
}
