import 'package:admin_webapp/class/patient.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'get_all_patients_event.dart';
part 'get_all_patients_state.dart';

class GetAllPatientsBloc
    extends Bloc<GetAllPatientsEvent, GetAllPatientsState> {
  GetAllPatientsBloc() : super(GetAllPatientsInitial()) {
    on<GetAllPatientsEvent>((event, emit) async {
      emit(GetAllPatientsLoading());
      try {
        final response =
            await Supabase.instance.client.rpc('admin_read_all_patient');
        final result = List<Map<String, dynamic>>.from(response);
        emit(GetAllPatientsSuccessfully(patients: result));
      } catch (e) {
        emit(GetAllPatientsFailure(error: e.toString()));
      }
    });
  }
}