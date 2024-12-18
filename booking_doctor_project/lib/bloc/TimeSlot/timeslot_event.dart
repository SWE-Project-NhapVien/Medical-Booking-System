sealed class GetInfoEvent {}

class GetTimeSlotEvent extends GetInfoEvent {
  final String doctorId;
  final String date;
  GetTimeSlotEvent({required this.doctorId, required this.date});
}
