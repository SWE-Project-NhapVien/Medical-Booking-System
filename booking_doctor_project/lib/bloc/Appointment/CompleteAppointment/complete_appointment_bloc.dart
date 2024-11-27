import 'package:flutter_bloc/flutter_bloc.dart';
import 'complete_appointment_event.dart';
import 'complete_appointment_state.dart';

class CompleteAppointmentBloc
    extends Bloc<CompleteAppointmentEvent, CompleteAppointmentState> {
  CompleteAppointmentBloc() : super(InitCompleteAppointmentState()) {
    on<RequestCompleteAppointmentEvent>(_requestCompleteAppointmentEvent);
  }

  void _requestCompleteAppointmentEvent(RequestCompleteAppointmentEvent event,
      Emitter<CompleteAppointmentState> emit) async {}
}
