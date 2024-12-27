import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'update_doctor_schedule_event.dart';
part 'update_doctor_schedule_state.dart';

class UpdateDoctorScheduleBloc
    extends Bloc<UpdateDoctorScheduleEvent, UpdateDoctorScheduleState> {
  UpdateDoctorScheduleBloc() : super(UpdateDoctorScheduleInitial()) {
    on<UpdateDoctorScheduleRequired>((event, emit) async {
      emit(UpdateDoctorScheduleLoading());
      try {
        await Supabase.instance.client.rpc('upsert_timeslots', params: {
          'doctor_id': event.doctorID,
          'timeslots': event.timeSlotJson,
        });
        emit(UpdateDoctorScheduleSuccess());
      } catch (e) {
        emit(UpdateDoctorScheduleFailure(error: e.toString()));
      }
    });
  }
}
