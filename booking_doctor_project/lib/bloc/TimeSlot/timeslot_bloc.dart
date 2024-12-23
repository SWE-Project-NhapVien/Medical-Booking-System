import 'package:booking_doctor_project/bloc/TimeSlot/timeslot_event.dart';
import 'package:booking_doctor_project/bloc/TimeSlot/timeslot_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GetTimeSlotDataBloc extends Bloc<GetInfoEvent, GetTimeSlotState> {
  GetTimeSlotDataBloc() : super(GetTimeSlotInitial()) {
    on<GetTimeSlotEvent>(_onFetchTimeSlotData);
  }

  Future<void> _onFetchTimeSlotData(
      GetTimeSlotEvent event, Emitter<GetTimeSlotState> emit) async {
    emit(GetTimeSlotLoading());
    try {
      final supabase = Supabase.instance.client;
      final response = await supabase.rpc('get_timeslot_statuses_with_name',
          params: {'id': event.doctorId, 'day': event.date});
      print(response);
      emit(GetTimeSlotSuccess(response));
    } catch (e) {
      emit(GetTimeSlotError('Error fetching time slot: $e'));
    }
  }
}
