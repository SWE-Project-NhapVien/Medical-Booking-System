import 'package:booking_doctor_project/services/authentication/auth_services.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'log_in_event.dart';
part 'log_in_state.dart';

class LogInBloc extends Bloc<LogInEvent, LogInState> {
  LogInBloc() : super(LogInInitial()) {
    on<LogInRequired>((event, emit) async {
      emit(LogInProcess());
      try {
        final result = await AuthServices().signInWithEmailPassword(
            email: event.email, password: event.password);
        if (result.session != null) {
          emit(LogInSuccess());
        }
      } catch (e) {
        if (e.toString().contains("invalid_credentials")) {
          emit(const LogInFailure(error: "Invalid email or password."));
        } else {
          emit(LogInFailure(error: e.toString()));
        }
      }
    });

    on<LogInReset>((event, emit) {
      emit(LogInInitial());
    });
  }
}
