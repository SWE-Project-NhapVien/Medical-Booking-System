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

      // Check if the response is valid
      if (response != null && response.isNotEmpty) {
        final insertedId = response[0]['appointment_id']; 

        // Update the status of the appointment to 'Completed'
        final updateResponse = await supabase.from('appointments').update({
          'status': 'Completed',
        }).eq('appointment_id', event.appointmentId).select();

        // Check if the update response is valid
        if (updateResponse != null && updateResponse.isNotEmpty) {
          emit(DoctorNotesAdded());
        } else {
          // Rollback: Delete the inserted doctor's notes
          await supabase.from('medicalresults').delete().eq('id', insertedId);
          emit(DoctorNotesError('Failed to update appointment status. Changes rolled back.'));
        }
      } else {
        emit(DoctorNotesError('Failed to add doctor notes.'));
      }
    } catch (e) {
      emit(DoctorNotesError('Error adding doctor notes: $e'));
    }
  }
}
