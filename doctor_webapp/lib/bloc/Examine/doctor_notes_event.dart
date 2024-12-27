import 'package:equatable/equatable.dart';

abstract class DoctorNotesEvent extends Equatable {
  const DoctorNotesEvent();

  @override
  List<Object> get props => [];
}

class LoadDoctorNotes extends DoctorNotesEvent {}

class AddDoctorNoteEvent extends DoctorNotesEvent {
  final String appointmentId;
  final String symptoms;
  final String diagnosis;
  final List<String> prescriptions;

  const AddDoctorNoteEvent({
    required this.appointmentId,
    required this.symptoms,
    required this.diagnosis,
    required this.prescriptions,
  });
}
