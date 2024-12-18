sealed class CompleteAppointmentEvent{}

final class RequestCompleteAppointmentEvent extends CompleteAppointmentEvent{
  final String profileId;
  RequestCompleteAppointmentEvent({required this.profileId});
}
