import '../../class/appointment.dart';

sealed class AppointmentState {}

final class InitAppointmentState extends AppointmentState {}

final class LoadingAppointmentState extends AppointmentState {}

final class ErrorAppointmentState extends AppointmentState {
  final String message;

  ErrorAppointmentState({required this.message});
}

final class SucessAppointmentState extends AppointmentState {
  final List<Appointment> appointment;

  SucessAppointmentState({required this.appointment});
}
