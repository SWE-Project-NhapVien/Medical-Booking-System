import 'package:doctor_webapp/services/authentication/auth_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'doctor_login_event.dart';
part 'doctor_login_state.dart';

class DoctorLoginBloc extends Bloc<DoctorLoginEvent, DoctorLoginState> {
  DoctorLoginBloc() : super(DoctorLoginInitial()) {
    on<DoctorLoginRequired>((event, emit) async {
      emit(DoctorLoginProcess());
      try {
        final result = await DoctorAuthServices().signInWithEmailPassword(
          email: event.email,
          password: event.password,
        );
        if (result.session != null) {
          emit(DoctorLoginSuccess());
        }
      } catch (e) {
        if (e.toString().contains("invalid-credentials")) {
          emit(const DoctorLoginFailure(error: "Invalid email or password."));
        }  else {
          emit(DoctorLoginFailure(error: e.toString()));
        }
      }
    });
  }
}
