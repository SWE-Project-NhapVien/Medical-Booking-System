import 'package:booking_doctor_project/services/authentication/auth_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpRequired>((event, emit) async {
      emit(SignUpProcess());
      try {
        final result = await AuthServices().signUpWithEmailPassword(
            email: event.email, password: event.password);
        if (result.session != null) {
          emit(SignUpSuccess());
        }
      } catch (e) {
        emit(SignUpFailure(error: e.toString()));
      }
    });
  }
}
