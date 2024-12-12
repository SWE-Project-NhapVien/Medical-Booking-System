sealed class GetDoctorInfoState {}

class GetDoctorInfoInitial extends GetDoctorInfoState {}

class GetDoctorInfoLoading extends GetDoctorInfoState {}

class GetDoctorInfoSuccess extends GetDoctorInfoState {
  final List<dynamic> doctorInfo;
  GetDoctorInfoSuccess(this.doctorInfo);
}

class GetDoctorInfoError extends GetDoctorInfoState {
  final String error;
  GetDoctorInfoError(this.error);
}
