abstract class GetInfoEvent {}

class GetDoctorInfoEvent extends GetInfoEvent {
  final String doctorId;

  GetDoctorInfoEvent(this.doctorId);
}
