import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'patientinfo_event.dart';
import 'patientinfo_state.dart';

class PatientInfoBloc extends Bloc<PatientInfoEvent, PatientInfoState> {
  PatientInfoBloc() : super(PatientInfoInitial()) {
    on<FetchPatientInfoEvent>(_onFetchPatientInfoDetails);
  }

  Future<void> _onFetchPatientInfoDetails(
      FetchPatientInfoEvent event, Emitter<PatientInfoState> emit) async {
    emit(PatientInfoLoading());
    try {
      final supabase = Supabase.instance.client;

      final response = await supabase.rpc('get_appointment_patient', params: {'p_appointment_id': event.appointmentId});

      if (response != null && response.isNotEmpty) {
        final appointmentDetails = response[0] as Map<String, dynamic>;

        // Emit success state with the parsed data
        emit(PatientInfoLoaded(appointmentDetails: appointmentDetails));
      } else {
        emit(const PatientInfoError(errorMessage: 'No appointment data found.'));
      }
    } catch (e) {
      emit(PatientInfoError(errorMessage: 'Error fetching appointment details: $e'));
    }
  }
}
