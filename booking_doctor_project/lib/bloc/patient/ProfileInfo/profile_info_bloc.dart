import 'package:booking_doctor_project/bloc/patient/ProfileInfo/profile_info_event.dart';
import 'package:booking_doctor_project/bloc/patient/ProfileInfo/profile_info_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GetProfileInfoBloc
    extends Bloc<GetProfileInfoEvent, GetProfileInfoState> {
  GetProfileInfoBloc() : super(GetProfileInfoInitial()) {
    on<GetProfileInfoEvent>(onFetchProfileInfo);
  }

  Future<void> onFetchProfileInfo(
      GetProfileInfoEvent event, Emitter<GetProfileInfoState> emit) async {
    emit(GetProfileInfoLoading());
    try {
      final supabase = Supabase.instance.client;
      final response = await supabase
          .rpc('get_full_profile_data', params: {'id': event.profileId});

      emit(GetProfileInfoSuccess(response));
    } catch (e) {
      emit(GetProfileInfoError('Error fetching profile info: $e'));
    }
  }
}
