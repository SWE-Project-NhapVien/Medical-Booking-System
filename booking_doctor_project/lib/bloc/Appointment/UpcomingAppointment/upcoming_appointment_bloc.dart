import 'package:booking_doctor_project/class/appointment.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'upcoming_appointment_event.dart';
import 'upcoming_appointment_state.dart';

class UpcomingAppointmentBloc
    extends Bloc<UpcomingAppointmentEvent, UpcomingAppointmentState> {
  UpcomingAppointmentBloc() : super(InitUpcomingAppointmentState()) {
    on<RequestUpcomingAppointmentEvent>(_requestUpcomingAppointmentEvent);
    on<AddAppointmentEvent>(_onAddAppointment);
  }

  void _requestUpcomingAppointmentEvent(RequestUpcomingAppointmentEvent event,
      Emitter<UpcomingAppointmentState> emit) async {
    try {
      emit(LoadingUpcomingAppointmentState());
      final response = await Supabase.instance.client
          .rpc('patient_read_upcoming_appointments', params: {
        'p_profile_id': event.profileId,
      });
      final result = List<Map<String, dynamic>>.from(response);
      final upcomingAppointments = parseAppointments(result);
      emit(SuccessUpcomingAppointmentState(upcomingAppointments));
    } on AuthException catch (e) {
      emit(ErrorUpcomingAppointmentState(e.message));
    } catch (e) {
      emit(ErrorUpcomingAppointmentState(e.toString()));
    }
  }

  List<Appointment> parseAppointments(dynamic data) {
    if (data is List) {
      return data.map<Appointment>((item) {
        DateTime date = DateTime.parse(item['appointment_date']);
        String formattedDate = DateFormat('MMMM d, y').format(date);
        return Appointment(
          appointmentDate: formattedDate,
          appointmentTime: item['appointment_time'].toString().substring(0, 5),
          appointmentId: item['appointment_id'].toString(),
          doctorFullName:
              item['doctor_last_name'] + ' ' + item['doctor_first_name'],
          doctorAvatar: item['doctor_avatar_url'],
          specializations: item['doctor_specialization'].cast<String>(),
          result: null,
          description: item['description'],
          status: 'upcoming',
          price: item['appointment_price'].toString(),
        );
      }).toList();
    } else {
      return [];
    }
  }

  Future<void> _onAddAppointment(
      AddAppointmentEvent event, Emitter<UpcomingAppointmentState> emit) async {
    emit(LoadingUpcomingAppointmentState());
    try {
      final supabase = Supabase.instance.client;
      await supabase.rpc('insert_appointment', params: {
        '_doctor_id': event.doctorId,
        '_patient_id': event.patientId,
        '_status': 'Upcoming',
        '_timeslot_id': event.timeslotId,
        '_description': event.description,
      });
      emit(AddAppointmentSucess());
    } catch (e) {
      emit(AddAppointmentError('Error adding appointment: $e'));
    }
  }
}
