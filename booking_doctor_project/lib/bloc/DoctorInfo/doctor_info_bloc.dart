import 'package:booking_doctor_project/bloc/DoctorInfo/doctor_info_event.dart';
import 'package:booking_doctor_project/bloc/DoctorInfo/doctor_info_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GetDoctorInfoBloc extends Bloc<GetInfoEvent, GetDoctorInfoState> {
  GetDoctorInfoBloc() : super(GetDoctorInfoInitial()) {
    on<GetDoctorInfoEvent>(_onFetchDoctorInfo);
  }

  Future<void> _onFetchDoctorInfo(
      GetDoctorInfoEvent event, Emitter<GetDoctorInfoState> emit) async {
    emit(GetDoctorInfoLoading());
    try {
      final supabase = Supabase.instance.client;
      final response =
          await supabase.rpc('get_doctor_data', params: {'id': event.doctorId});
      emit(GetDoctorInfoSuccess(response));
    } catch (e) {
      emit(GetDoctorInfoError('Error fetching doctor info: $e'));
    }
  }
}
