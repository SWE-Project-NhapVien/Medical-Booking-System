import 'package:booking_doctor_project/class/appointment.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'complete_appointment_event.dart';
import 'complete_appointment_state.dart';

class CompleteAppointmentBloc
    extends Bloc<CompleteAppointmentEvent, CompleteAppointmentState> {
  CompleteAppointmentBloc() : super(InitCompleteAppointmentState()) {
    on<RequestCompleteAppointmentEvent>(_requestCompleteAppointmentEvent);
  }

  void _requestCompleteAppointmentEvent(RequestCompleteAppointmentEvent event,
      Emitter<CompleteAppointmentState> emit) async {
    try {
      emit(LoadingCompleteAppointmentState());
      final response = await Supabase.instance.client
          .rpc('patient_read_completed_appointments', params: {
        'p_profile_id': event.profileId,
      });
      final result = List<Map<String, dynamic>>.from(response);
      final completeAppointments = parseAppointments(result);
      emit(SuccessCompleteAppointmentState(completeAppointments));
    } on AuthException catch (e) {
      emit(ErrorCompleteAppointmentState(e.message));
    } catch (e) {
      emit(ErrorCompleteAppointmentState(e.toString()));
    }
  }

  List<Appointment> parseAppointments(dynamic data) {
    if (data is List) {
      return data.map((item) {
        return Appointment(
          appointmentDate: item['appointment_date'].toString(),
          appointmentTime: item['appointment_time'].toString(),
          appointmentId: item['appointment_id'].toString(),
          doctorFullName:
              item['doctor_last_name'] + ' ' + item['doctor_first_name'],
          doctorAvatar: item['doctor_avatar_url'],
          specializations: item['doctor_specialization'].cast<String>(),
          result: null,
          status: 'completed',
          price: item['appointment_price'].toString(),
        );
      }).toList();
    } else {
      return [];
    }
  }
}
