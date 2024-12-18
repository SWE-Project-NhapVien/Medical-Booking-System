import 'package:booking_doctor_project/class/appointment.dart';

sealed class UpcomingAppointmentState {
  const UpcomingAppointmentState();
}

final class InitUpcomingAppointmentState extends UpcomingAppointmentState {}

final class LoadingUpcomingAppointmentState extends UpcomingAppointmentState {}

final class ErrorUpcomingAppointmentState extends UpcomingAppointmentState {
  String message;
  ErrorUpcomingAppointmentState(this.message);
}

final class SuccessUpcomingAppointmentState extends UpcomingAppointmentState {
  final List<Appointment> appointments;

  SuccessUpcomingAppointmentState(this.appointments);
}
