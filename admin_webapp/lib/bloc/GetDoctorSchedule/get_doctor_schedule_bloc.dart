import 'package:admin_webapp/class/doctor_schedule.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'get_doctor_schedule_event.dart';
part 'get_doctor_schedule_state.dart';

class GetDoctorScheduleBloc
    extends Bloc<GetDoctorScheduleEvent, GetDoctorScheduleState> {
  GetDoctorScheduleBloc() : super(GetDoctorScheduleInitial()) {
    on<GetDoctorScheduleRequired>((event, emit) async {
      try {
        emit(GetDoctorScheduleLoading());
        final response = await Supabase.instance.client
            .rpc('admin_read_doctor_schedule', params: {
          'doc_id': event.doctorID,
        });
        final result = List<Map<String, dynamic>>.from(response);
        final scheduleList = parseScheduleResponse(result);
        print('Doctor ID: ${event.doctorID}');
        print('Result: $response');
        emit(GetDoctorScheduleSuccess(scheduleList: scheduleList));
      } catch (e) {
        emit(GetDoctorScheduleFailure(error: e.toString()));
      }
    });
  }
}

List<DoctorSchedule> parseScheduleResponse(List<dynamic> response) {
  return response.map((item) => DoctorSchedule.fromJson(item)).toList();
}