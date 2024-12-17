part of 'cancel_appointment_bloc.dart';

sealed class CancelAppointmentEvent extends Equatable {
  const CancelAppointmentEvent();

  @override
  List<Object> get props => [];
}
 
class CancelAppointmentRequired extends CancelAppointmentEvent {
  final String appointmentId;

  const CancelAppointmentRequired({required this.appointmentId});

  @override
  List<Object> get props => [appointmentId];
}