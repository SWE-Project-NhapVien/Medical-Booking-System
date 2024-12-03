import 'package:bloc/bloc.dart';
import 'package:booking_doctor_project/services/authentication/auth_services.dart';
import 'package:equatable/equatable.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordInitial()) {
    on<ForgotPasswordRequired>((event, emit) async {
      emit(ForgotPasswordProcess());
      try {
        return await AuthServices().resetPassword(email: event.email);
      } catch (e) {
        emit(ForgotPasswordFailure(error: e.toString()));
      }
    });
  }
}
