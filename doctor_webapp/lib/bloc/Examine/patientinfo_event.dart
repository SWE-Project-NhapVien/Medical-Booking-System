import 'package:equatable/equatable.dart';

abstract class PatientInfoEvent extends Equatable {
  const PatientInfoEvent();

  @override
  List<Object?> get props => [];
}

class FetchPatientInfoEvent extends PatientInfoEvent {
  final String appointmentId;

  const FetchPatientInfoEvent(this.appointmentId);

  @override
  List<Object?> get props => [appointmentId];
}
