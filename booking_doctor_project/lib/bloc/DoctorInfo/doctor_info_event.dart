sealed class GetInfoEvent {}

class GetDoctorInfoEvent extends GetInfoEvent {
  final String doctorId;
  GetDoctorInfoEvent({required this.doctorId});
}
