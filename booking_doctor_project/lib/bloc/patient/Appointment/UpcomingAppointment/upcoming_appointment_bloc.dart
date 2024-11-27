import 'package:flutter_bloc/flutter_bloc.dart';
import 'upcoming_appointment_event.dart';
import 'upcoming_appointment_state.dart';

class UpcomingAppointmentBloc
    extends Bloc<UpcomingAppointmentEvent, UpcomingAppointmentState> {
  UpcomingAppointmentBloc() : super(InitUpcomingAppointmentState()) {
    on<RequestUpcomingAppointmentEvent>(_requestUpcomingAppointmentEvent);
  }

  void _requestUpcomingAppointmentEvent(RequestUpcomingAppointmentEvent event,
      Emitter<UpcomingAppointmentState> emit) async {}
}
