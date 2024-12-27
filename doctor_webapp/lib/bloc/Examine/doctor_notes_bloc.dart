import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'doctor_notes_event.dart';
import 'doctor_notes_state.dart';

class DoctorNotesBloc extends Bloc<DoctorNotesEvent, DoctorNotesState> {
  DoctorNotesBloc() : super(DoctorNotesInitial()) {
    on<AddDoctorNoteEvent>(_onAddDoctorNote);
  }

  Future<void> _onAddDoctorNote(
      AddDoctorNoteEvent event, Emitter<DoctorNotesState> emit) async {
    emit(DoctorNotesAdding());

    try {
      final supabase = Supabase.instance.client;

      // Insert doctor's notes into the medicalresults table
      final response = await supabase.from('medicalresults').insert({
        'appointment_id': event.appointmentId,
        'symptoms': event.symptoms,
        'diagnosis': event.diagnosis,
        'prescriptions': event.prescriptions, 
      }).select();

      // if (response.error == null) {
      //   emit(DoctorNotesAdded());
      // } else {
      //   emit(DoctorNotesError('Failed to add doctor notes: ${response.error.message}'));
      // }
    } catch (e) {
      emit(DoctorNotesError('Error adding doctor notes: $e'));
    }
  }
}