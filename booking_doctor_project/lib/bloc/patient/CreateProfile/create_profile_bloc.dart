import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'create_profile_event.dart';
part 'create_profile_state.dart';

class CreateProfileBloc extends Bloc<CreateProfileEvent, CreateProfileState> {
  CreateProfileBloc() : super(CreateProfileInitial()) {
    on<CreateProfileRequired>((event, emit) async {
      emit(CreateProfileProcess());
      try {
        final formattedDateOfBirth = convertDateFormat(event.dateOfBirth);
        await Supabase.instance.client.rpc('create_patient_profile', params: {
          'p_first_name': event.firstName,
          'p_last_name': event.lastName,
          'p_email': event.email,
          'p_phone_number': event.phoneNumber,
          'p_date_of_birth': formattedDateOfBirth,
          'p_blood_type': event.bloodType,
          'p_gender': event.gender,
          'p_address': event.address,
          'p_relationship': event.relationship
        });
        emit(CreateProfileSuccess());
      } catch (e) {
        emit(CreateProfileFailure(e.toString()));
      }
    });
    on<CreateProfileReset>((event, emit) {
      emit(CreateProfileInitial());
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
