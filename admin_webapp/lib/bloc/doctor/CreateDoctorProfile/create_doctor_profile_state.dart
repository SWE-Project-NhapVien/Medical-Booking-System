part of 'create_doctor_profile_bloc.dart';

abstract class CreateDoctorProfileState extends Equatable {
  const CreateDoctorProfileState();

  @override
  List<Object?> get props => [];
}

class CreateDoctorProfileInitial extends CreateDoctorProfileState {}

class CreateDoctorProfileProcess extends CreateDoctorProfileState {}

class CreateDoctorProfileSuccess extends CreateDoctorProfileState {}

class CreateDoctorProfileFailure extends CreateDoctorProfileState {
  final String error;

  const CreateDoctorProfileFailure(this.error);

  @override
  List<Object?> get props => [error];
}
