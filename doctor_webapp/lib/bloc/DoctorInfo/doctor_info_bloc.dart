import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'doctor_info_event.dart';
import 'doctor_info_state.dart';

class GetDoctorInfoBloc extends Bloc<GetInfoEvent, GetDoctorInfoState> {
  GetDoctorInfoBloc() : super(GetDoctorInfoInitial()) {
    on<GetDoctorInfoEvent>(_onFetchDoctorInfo);
  }

  Future<void> _onFetchDoctorInfo(
      GetDoctorInfoEvent event, Emitter<GetDoctorInfoState> emit) async {
    emit(GetDoctorInfoLoading());
    try {
      final supabase = Supabase.instance.client;

      final response = await supabase.rpc('get_doctor_data', params: {'id': event.doctorId});

      if (response.isNotEmpty) {
        final doctorData = response[0] as Map<String, dynamic>;

        // Emit success state with the parsed data
        emit(GetDoctorInfoSuccess(doctorData));
      } else {
        emit(GetDoctorInfoError('No doctor data found.'));
      }
    } catch (e) {
      emit(GetDoctorInfoError('Error fetching doctor info: $e'));
    }
  }

}
