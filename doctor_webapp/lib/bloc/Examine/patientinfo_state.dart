import 'package:equatable/equatable.dart';

abstract class PatientInfoState extends Equatable {
  const PatientInfoState();

  @override
  List<Object?> get props => [];
}

class PatientInfoInitial extends PatientInfoState {}

class PatientInfoLoading extends PatientInfoState {}

class PatientInfoLoaded extends PatientInfoState {
  final Map<String, dynamic> appointmentDetails;

  const PatientInfoLoaded({required this.appointmentDetails});

  @override
  List<Object?> get props => [appointmentDetails];
}

class PatientInfoError extends PatientInfoState {
  final String errorMessage;

  const PatientInfoError({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
