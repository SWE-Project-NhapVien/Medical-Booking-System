import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_webapp/services/authentication/auth_service.dart';
import 'package:equatable/equatable.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordInitial()) {
    on<ForgotPasswordRequired>((event, emit) {
      emit(ForgotPasswordProcess());
      try {
        if (event.email.isEmpty) {
          emit(const ForgotPasswordFailure(error: 'Email is required'));
          return;              
        }
        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(event.email)) {
          emit(const ForgotPasswordFailure(error: 'Invalid email address'));  
          return;                 
        }
        DoctorAuthServices().resetPassword(email: event.email);
        emit(ForgotPasswordSuccess());
      } catch (e) {
        emit(ForgotPasswordFailure(error: e.toString()));
      }
    });
    on<ForgotPasswordVerifyOTP>((event, emit) async {
      try {
        await DoctorAuthServices()
            .verifyOtp(email: event.email, otp: event.otp);
        emit(ForgotPasswordOTPVerified());
      } catch (e) {
        emit(ForgotPasswordOTPFailure(error: e.toString()));
      }
    });
  }
}
