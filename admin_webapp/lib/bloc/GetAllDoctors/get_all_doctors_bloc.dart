import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'get_all_doctors_event.dart';
part 'get_all_doctors_state.dart';

class GetAllDoctorsBloc extends Bloc<GetAllDoctorsEvent, GetAllDoctorsState> {
  GetAllDoctorsBloc() : super(GetAllDoctorsInitial()){
    on<GetAllDoctorsEvent>((event, emit) async {
      emit(GetAllDoctorsLoading());
      try {
        final response =
            await Supabase.instance.client.rpc('admin_read_all_doctor');
        final result = List<Map<String, dynamic>>.from(response);
        emit(GetAllDoctorsSuccessfully(doctors: result));
      } catch (e) {
        emit(GetAllDoctorsFailure(error: e.toString()));
      }
    });
  }
}
