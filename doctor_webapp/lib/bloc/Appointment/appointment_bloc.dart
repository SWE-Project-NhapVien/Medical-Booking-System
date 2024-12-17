import 'package:booking_doctor_project/DataLayer/repository/appointment_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'appointment_event.dart';
import 'appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final AppointmentRepository _appointmentRepository;

  AppointmentBloc({required AppointmentRepository appointmentRepository})
      : _appointmentRepository = appointmentRepository,
        super(InitAppointmentState()) {
    on<RequestAppointmentEvent>(_requestAppointmentEvent);
  }

  void _requestAppointmentEvent(
      RequestAppointmentEvent event, Emitter<AppointmentState> emit) async {
    emit(LoadingAppointmentState());
    try {
      final appointmentData = await _appointmentRepository.getAppointmentData(
          typeAppointment: event.appointmentType);
      emit(SucessAppointmentState(appointment: appointmentData));
    } catch (e) {
      emit(ErrorAppointmentState(message: e.toString()));
    }
  }
}
