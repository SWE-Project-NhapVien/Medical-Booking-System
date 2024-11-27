import 'package:flutter_bloc/flutter_bloc.dart';
import 'cancelled_appointment_event.dart';
import 'cancelled_appointment_state.dart';

class CancelledAppointmentBloc
    extends Bloc<CancelledAppointmentEvent, CancelledAppointmentState> {
  CancelledAppointmentBloc() : super(InitCancelledAppointmentState()) {
    on<RequestCancelledAppointmentEvent>(_requestCancelledAppointmentEvent);
  }

  void _requestCancelledAppointmentEvent(RequestCancelledAppointmentEvent event,
      Emitter<CancelledAppointmentState> emit) async {}
}
