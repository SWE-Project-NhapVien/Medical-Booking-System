sealed class GetProfileInfoState {}

class GetProfileInfoInitial extends GetProfileInfoState {}

class GetProfileInfoLoading extends GetProfileInfoState {}

class GetProfileInfoSuccess extends GetProfileInfoState {
  final List<dynamic> profileInfo;
  GetProfileInfoSuccess(this.profileInfo);
}

class GetProfileInfoError extends GetProfileInfoState {
  final String error;
  GetProfileInfoError(this.error);
}
