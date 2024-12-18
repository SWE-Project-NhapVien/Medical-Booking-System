part of 'cancel_appointment_bloc.dart';

sealed class CancelAppointmentState extends Equatable {
  const CancelAppointmentState();

  @override
  List<Object> get props => [];
}

class CancelAppointmentInitial extends CancelAppointmentState {}

class CancelAppointmentProcess extends CancelAppointmentState {}

class CancelAppointmentSuccess extends CancelAppointmentState {}

class CancelAppointmentError extends CancelAppointmentState {
  final String error;

  const CancelAppointmentError({required this.error});

  @override
  List<Object> get props => [error];
}
