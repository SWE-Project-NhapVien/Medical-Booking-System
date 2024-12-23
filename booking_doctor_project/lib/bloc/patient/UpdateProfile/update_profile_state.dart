sealed class UpdateProfileState {}

final class UpdateProfileInitial extends UpdateProfileState {}

final class UpdateProfileLoading extends UpdateProfileState {}

final class UpdateProfileSuccess extends UpdateProfileState {}

final class UpdateProfileError extends UpdateProfileState {
  final String error;

  UpdateProfileError(this.error);
}
