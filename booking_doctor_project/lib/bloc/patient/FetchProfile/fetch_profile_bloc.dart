import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'fetch_profile_event.dart';
part 'fetch_profile_state.dart';

class FetchProfileBloc extends Bloc<FetchProfileEvent, FetchProfileState> {
  FetchProfileBloc() : super(FetchProfileInitial()) {
    on<FetchProfileEvent>((event, emit) async {
      emit(FetchProfileProcess());
      try {
        final response = await Supabase.instance.client
            .rpc('read_patient_profiles_by_patient_account');
        emit(FetchProfileSuccess(
            profiles: List<Map<String, dynamic>>.from(response)));
      } catch (e) {
        emit(FetchProfileError(error: e.toString()));
      }
    });
  }
}
