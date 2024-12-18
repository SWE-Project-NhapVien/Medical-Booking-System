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
        await AuthServices().resetPassword(email: event.email);
        emit(ForgotPasswordSuccess());
      } catch (e) {
        emit(ForgotPasswordFailure(error: e.toString()));
      }
    });
    on<ForgotPasswordVerifyOTP>((event, emit) async {
      try {
        await AuthServices().verifyOtp(email: event.email, otp: event.otp);
        emit(ForgotPasswordOTPVerified());
      } catch (e) {
        emit(ForgotPasswordOTPFailure(error: e.toString()));
      }
    });
    on<ForgotPasswordReset>((event, emit) {
      emit(ForgotPasswordInitial());
    });
  }
}
