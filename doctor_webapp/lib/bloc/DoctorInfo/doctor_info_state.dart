abstract class GetDoctorInfoState {}

class GetDoctorInfoInitial extends GetDoctorInfoState {}

class GetDoctorInfoLoading extends GetDoctorInfoState {}

class GetDoctorInfoSuccess extends GetDoctorInfoState {
  final Map<String, dynamic> doctorData;

  GetDoctorInfoSuccess(this.doctorData);
}

class GetDoctorInfoError extends GetDoctorInfoState {
  final String message;

  GetDoctorInfoError(this.message);
}
