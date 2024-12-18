import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'cancel_appointment_event.dart';
part 'cancel_appointment_state.dart';

class CancelAppointmentBloc
    extends Bloc<CancelAppointmentEvent, CancelAppointmentState> {
  CancelAppointmentBloc() : super(CancelAppointmentInitial()) {
    on<CancelAppointmentRequired>((event, emit) async {
      emit(CancelAppointmentProcess());
      try {
        await Supabase.instance.client
            .rpc('patient_cancel_appointment', params: {
          'p_appointment_id': event.appointmentId,
        });
        emit(CancelAppointmentSuccess());
      } on AuthException catch (e) {
        emit(CancelAppointmentError(error: e.message));
      } catch (e) {
        emit(CancelAppointmentError(error: e.toString()));
      }
    });
  }
}
