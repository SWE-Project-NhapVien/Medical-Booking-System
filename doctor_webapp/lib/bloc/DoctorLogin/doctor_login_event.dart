part of 'doctor_login_bloc.dart';

sealed class DoctorLoginEvent extends Equatable {
  const DoctorLoginEvent();

  @override
  List<Object> get props => [];
}

class DoctorLoginRequired extends DoctorLoginEvent {
  final String email;
  final String password;

  const DoctorLoginRequired({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}