import 'package:doctor_webapp/bloc/SpecificAppointment/specific_appointment_event.dart';
import 'package:doctor_webapp/bloc/SpecificAppointment/specific_appointment_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GetSpecificAppointmentDataBloc
    extends Bloc<GetSpecificAppointmentData, GetSpecificAppointmentDataState> {
  GetSpecificAppointmentDataBloc()
      : super(GetSpecificAppointmentDataInitial()) {
    on<GetSpecificAppointmentDataEvent>(_onFetchSpecificAppointmentData);
  }

  Future<void> _onFetchSpecificAppointmentData(
    GetSpecificAppointmentDataEvent event,
    Emitter<GetSpecificAppointmentDataState> emit,
  ) async {
    emit(GetSpecificAppointmentDataLoading());
    try {
      final supabase = Supabase.instance.client;
      final response = await supabase.rpc('get_appointment_details', params: {
        'appointment_id_input': event.appointmentId,
      });

      emit(GetSpecificAppointmentDataSuccess(response));
    } catch (e) {
      emit(GetSpecificAppointmentDataError(
          'Error fetching appointment data: $e'));
    }
  }
}
