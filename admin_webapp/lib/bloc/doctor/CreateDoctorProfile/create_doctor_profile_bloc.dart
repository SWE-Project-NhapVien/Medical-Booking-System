import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'create_doctor_profile_event.dart';
part 'create_doctor_profile_state.dart';

class CreateDoctorProfileBloc extends Bloc<CreateDoctorProfileEvent, CreateDoctorProfileState> {
  CreateDoctorProfileBloc() : super(CreateDoctorProfileInitial()) {
    on<CreateDoctorProfileRequired>((event, emit) async {
      emit(CreateDoctorProfileProcess());
      try {
        final formattedDateOfBirth = convertDateFormat(event.dateOfBirth);
        await Supabase.instance.client.rpc('create_doctor_profile', params: {
          'p_doctor_id': event.doctorId,
          'p_first_name': event.firstName,
          'p_last_name': event.lastName,
          'p_phone_number': event.phoneNumber,
          'p_date_of_birth': formattedDateOfBirth,
          'p_blood_type': event.bloodType,
          'p_gender': event.gender,
          'p_address': event.address,
          'p_education': event.education,
          'p_career': event.career,
          'p_description': event.description,
          'p_ava_url': event.avaUrl,
          'p_specialization': event.specialization
        });
        emit(CreateDoctorProfileSuccess());
      } catch (e) {
        emit(CreateDoctorProfileFailure(e.toString()));
      }
    });

    on<CreateDoctorProfileReset>((event, emit) {
      emit(CreateDoctorProfileInitial());
    });
  }
}

String convertDateFormat(String date) {
  final parts = date.split('/');
  if (parts.length == 3) {
    final day = parts[0].padLeft(2, '0');
    final month = parts[1].padLeft(2, '0');
    final year = parts[2];
    return '$year-$month-$day';
  }
  return date;
}
