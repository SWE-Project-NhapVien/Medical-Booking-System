import 'package:booking_doctor_project/class/appointment.dart';

sealed class CompleteAppointmentState{}

final class InitCompleteAppointmentState extends CompleteAppointmentState{}

final class LoadingCompleteAppointmentState extends CompleteAppointmentState{}

final class ErrorCompleteAppointmentState extends CompleteAppointmentState{
  final String message;

  ErrorCompleteAppointmentState(this.message);
}

final class SuccessCompleteAppointmentState extends CompleteAppointmentState{
  List<Appointment> appointments;
  SuccessCompleteAppointmentState(this.appointments);
}
