import 'package:doctor_webapp/bloc/SpecificAppointment2/specific_appointment2_event.dart';
import 'package:doctor_webapp/bloc/SpecificAppointment2/specific_appointment2_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GetSpecificAppointmentDataBloc2 extends Bloc<GetSpecificAppointmentData2,
    GetSpecificAppointmentDataState2> {
  GetSpecificAppointmentDataBloc2()
      : super(GetSpecificAppointmentDataInitial2()) {
    on<GetSpecificAppointmentDataEvent2>(_onFetchSpecificAppointmentData);
  }

  Future<void> _onFetchSpecificAppointmentData(
    GetSpecificAppointmentDataEvent2 event,
    Emitter<GetSpecificAppointmentDataState2> emit,
  ) async {
    emit(GetSpecificAppointmentDataLoading2());
    try {
      final supabase = Supabase.instance.client;
      final response = await supabase.rpc('get_appointment_details2', params: {
        'appointment_id_input': event.appointmentId,
      });

      emit(GetSpecificAppointmentDataSuccess2(response));
    } catch (e) {
      emit(GetSpecificAppointmentDataError2(
          'Error fetching appointment data: $e'));
    }
  }
}
