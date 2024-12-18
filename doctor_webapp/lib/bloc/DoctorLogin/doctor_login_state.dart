part of 'doctor_login_bloc.dart';

sealed class DoctorLoginState extends Equatable {
  const DoctorLoginState();

  @override
  List<Object> get props => [];
}

class DoctorLoginInitial extends DoctorLoginState {}

class DoctorLoginProcess extends DoctorLoginState {}

class DoctorLoginSuccess extends DoctorLoginState {}

class DoctorLoginFailure extends DoctorLoginState {
  final String error;

  const DoctorLoginFailure({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}