import 'package:booking_doctor_project/bloc/patient/UpdateProfile/update_profile_event.dart';
import 'package:booking_doctor_project/bloc/patient/UpdateProfile/update_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  UpdateProfileBloc() : super(UpdateProfileInitial()) {
    on<UpdateProfileDataEvent>(_onUpdateProfileData);
    on<UpdateProfileImageEvent>(_onUpdateProfileImage);
  }

  Future<void> _onUpdateProfileData(
      UpdateProfileDataEvent event, Emitter<UpdateProfileState> emit) async {
    emit(UpdateProfileLoading());
    try {
      final supabase = Supabase.instance.client;
      await supabase.rpc('update_profile_by_profile_id', params: {
        'id': event.id,
        'new_fname': event.fname,
        'new_lname': event.lname,
        'new_pnum': event.pnum,
        'new_rela': event.rela,
        'new_adr': event.address,
        'new_gender': event.gender,
        'new_dob': event.dob,
        'new_econtact': event.econtact,
        'new_blood': event.blood,
        'new_weight': event.weight,
        'new_height': event.height,
        'new_allergies': event.allergy,
        'new_medhis': event.medlist,
      });

      emit(UpdateProfileSuccess());
    } catch (e) {
      emit(UpdateProfileError('Error updating profile: $e'));
    }
  }

  Future<void> _onUpdateProfileImage(
      UpdateProfileImageEvent event, Emitter<UpdateProfileState> emit) async {
    emit(UpdateProfileLoading());
    try {
      final supabase = Supabase.instance.client;
      await supabase.rpc('update_avaurl', params: {
        'id': event.id,
        'new_avaurl': event.imageUrl,
      });

      emit(UpdateProfileSuccess());
    } catch (e) {
      emit(UpdateProfileError('Error updating profile: $e'));
    }
  }
}
