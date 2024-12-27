abstract class DoctorNotesState {}

class DoctorNotesInitial extends DoctorNotesState {}

class DoctorNotesAdding extends DoctorNotesState {}

class DoctorNotesAdded extends DoctorNotesState {}

class DoctorNotesError extends DoctorNotesState {
  final String errorMessage;

  DoctorNotesError(this.errorMessage);
}
