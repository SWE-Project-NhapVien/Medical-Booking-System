import 'package:booking_doctor_project/bloc/Appointment/Notification/notification_event.dart';
import 'package:booking_doctor_project/bloc/Appointment/Notification/notification_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GetNotificationDataBloc extends Bloc<GetNotiEvent, GetNotificationState> {
  GetNotificationDataBloc() : super(GetNotificationInitial()) {
    on<GetNotificationDataEvent>(_onFetchNotificationData);
    on<UpdateNotificationStatusEvent>(
        _onUpdateNotificationStatus); // Add handler here
  }

  Future<void> _onFetchNotificationData(GetNotificationDataEvent event,
      Emitter<GetNotificationState> emit) async {
    emit(GetNotificationLoading());
    try {
      final supabase = Supabase.instance.client;
      final response = await supabase.rpc('get_notifications_by_ids',
          params: {'notification_ids': event.notiIdList});
      emit(GetNotificationSuccess(response));
    } catch (e) {
      emit(GetNotificationError('Error fetching notification list: $e'));
    }
  }

  Future<void> _onUpdateNotificationStatus(UpdateNotificationStatusEvent event,
      Emitter<GetNotificationState> emit) async {
    emit(GetNotificationLoading());
    try {
      final supabase = Supabase.instance.client;
      await supabase.rpc('update_notifications_status', params: {
        'notification_ids': event.notiIdList,
      });
      final response = await supabase.rpc('get_notifications_by_ids',
          params: {'notification_ids': event.notiIdList});
      emit(GetNotificationSuccess(response));
    } catch (e) {
      emit(GetNotificationError('Error updating notification status: $e'));
    }
  }
}
