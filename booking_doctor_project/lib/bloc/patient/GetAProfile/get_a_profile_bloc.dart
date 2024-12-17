import 'package:bloc/bloc.dart';
import 'package:booking_doctor_project/class/patient_profile.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'get_a_profile_event.dart';
part 'get_a_profile_state.dart';

class GetAProfileBloc extends Bloc<GetAProfileEvent, GetAProfileState> {
  GetAProfileBloc() : super(GetAProfileInitial()) {
    on<GetAProfileRequired>((event, emit) async {
      emit(GetAProfileProcess());
      try {
        final response = await Supabase.instance.client
            .rpc('read_patient_profile_by_id', params: {
          'p_profile_id': event.profileId,
        });
        final result = List<Map<String, dynamic>>.from(response);
        final profileInfo = parseProfiles(result);
        await PatientProfile.saveProfile(profileInfo);
        emit(GetAProfileSuccess(profile: profileInfo));
      } on AuthException catch (e) {
        emit(GetAProfileError(error: e.message));
      } catch (e) {
        emit(GetAProfileError(error: e.toString()));
      }
    });
  }

  PatientProfile parseProfiles(dynamic data) {
    if (data.isEmpty) {
      throw Exception('No profile data found.');
    }

    final item = data.first;
    return PatientProfile(
      firstName: item['first_name'],
      lastName: item['last_name'],
      phoneNumber: item['phone_number'],
      dob: item['date_of_birth'],
      gender: item['gender'],
      address: item['address'] ?? '',
      bloodType: item['blood_type'] ?? '',
      weight: (item['weight'] as num?)?.toDouble() ?? 0.0,
      height: (item['height'] as num?)?.toDouble() ?? 0.0,
      allergies: List<String>.from(item['allergies'] ?? []),
      medicalHistory: List<String>.from(item['medical_history'] ?? []),
      emergencyContacts: List<String>.from(item['emergency_contact'] ?? []),
    );
  }
}
