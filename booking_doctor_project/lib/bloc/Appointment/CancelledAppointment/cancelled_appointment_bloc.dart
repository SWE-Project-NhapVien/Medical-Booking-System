import 'package:booking_doctor_project/class/appointment.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'cancelled_appointment_event.dart';
import 'cancelled_appointment_state.dart';

class CancelledAppointmentBloc
    extends Bloc<CancelledAppointmentEvent, CancelledAppointmentState> {
  CancelledAppointmentBloc() : super(InitCancelledAppointmentState()) {
    on<RequestCancelledAppointmentEvent>(_requestCancelledAppointmentEvent);
  }

  void _requestCancelledAppointmentEvent(RequestCancelledAppointmentEvent event,
      Emitter<CancelledAppointmentState> emit) async {
    try {
      emit(LoadingCancelledAppointmentState());
      final response = await Supabase.instance.client
          .rpc('patient_read_cancelled_appointments', params: {
        'p_profile_id': event.profileId,
      });
      final result = List<Map<String, dynamic>>.from(response);
      final cancelledAppointments = parseAppointments(result);
      emit(SuccessCancelledAppointmentState(cancelledAppointments));
    } catch (e) {
      emit(ErrorCancelledAppointmentState(e.toString()));
    }
  }

  List<Appointment> parseAppointments(dynamic data) {
    if (data is List) {
      return data.map((item) {
        DateTime date = DateTime.parse(item['appointment_date']);
        String formattedDate = DateFormat('MMMM d, y').format(date);
        return Appointment(
          appointmentDate: formattedDate,
          appointmentTime: item['appointment_time'].toString(),
          appointmentId: item['appointment_id'],
          doctorFullName:
              item['doctor_last_name'] + ' ' + item['doctor_first_name'],
          doctorAvatar: item['doctor_avatar_url'],
          specializations: item['doctor_specialization'].cast<String>(),
          result: null,
          description: item['description'],
          status: 'canceled',
          price: item['appointment_price'].toString(),
        );
      }).toList();
    } else {
      return [];
    }
  }
}
