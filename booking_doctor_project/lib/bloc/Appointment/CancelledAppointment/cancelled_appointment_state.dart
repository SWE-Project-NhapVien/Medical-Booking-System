import 'package:booking_doctor_project/class/appointment.dart';

sealed class CancelledAppointmentState {}

final class InitCancelledAppointmentState extends CancelledAppointmentState {}

final class LoadingCancelledAppointmentState
    extends CancelledAppointmentState {}

final class ErrorCancelledAppointmentState extends CancelledAppointmentState {
  final String message;

  ErrorCancelledAppointmentState(this.message);
}

final class SuccessCancelledAppointmentState extends CancelledAppointmentState {
  List<Appointment> appointments;
  SuccessCancelledAppointmentState(this.appointments);
}
