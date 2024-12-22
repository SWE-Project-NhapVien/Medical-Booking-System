import 'package:booking_doctor_project/bloc/History/history_event.dart';
import 'package:booking_doctor_project/bloc/History/history_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GetHistoryBloc extends Bloc<GetHistoryEvent, GetHistoryState> {
  GetHistoryBloc() : super(GetHistoryInitial()) {
    on<GetHistoryDataEvent>(_onFetchHistoryData);
    on<UpdateHistoryDataEvent>(_updateHistoryData);
    on<DeleteHistoryDataEvent>(_deleteHistoryData);
  }

  Future<void> _onFetchHistoryData(
      GetHistoryDataEvent event, Emitter<GetHistoryState> emit) async {
    emit(GetHistoryLoading());
    try {
      final supabase = Supabase.instance.client;
      final response = await supabase
          .rpc('get_history_by_profile_id', params: {'id': event.paptientId});
      emit(GetHistorySuccess(response));
    } catch (e) {
      emit(GetHistoryError('Error fetching history data: $e'));
    }
  }

  Future<void> _updateHistoryData(
      UpdateHistoryDataEvent event, Emitter<GetHistoryState> emit) async {
    emit(GetHistoryLoading());
    try {
      final supabase = Supabase.instance.client;
      await supabase.rpc('update_history_by_profile_id', params: {
        'id': event.patientId,
        'new_history': event.newHistory,
      });
      final response = await supabase
          .rpc('get_history_by_profile_id', params: {'id': event.patientId});

      emit(GetHistorySuccess(response));
    } catch (e) {
      emit(GetHistoryError('Error fetching history data: $e'));
    }
  }

  Future<void> _deleteHistoryData(
      DeleteHistoryDataEvent event, Emitter<GetHistoryState> emit) async {
    emit(GetHistoryLoading());
    try {
      final supabase = Supabase.instance.client;
      await supabase.rpc('remove_history_at_index', params: {
        'id': event.patientId,
        'remove_index': event.index,
      });
      final response = await supabase
          .rpc('get_history_by_profile_id', params: {'id': event.patientId});

      emit(GetHistorySuccess(response));
    } catch (e) {
      emit(GetHistoryError('Error fetching history data: $e'));
    }
  }
}
