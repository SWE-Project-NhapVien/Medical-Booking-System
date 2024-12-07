import 'package:bloc/bloc.dart';
import 'package:booking_doctor_project/services/authentication/auth_services.dart';
import 'package:equatable/equatable.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  ResetPasswordBloc() : super(ResetPasswordInitial()) {
    on<ResetPasswordRequired>((event, emit) async {
      emit(ResetPasswordProcess());
      try{
        await AuthServices().updatePassword(password: event.newPassword);
        emit(ResetPasswordSuccess());
      } catch (e) {
        emit(ResetPasswordFailure(error: e.toString()));
      }
    });
    on <ResetPasswordReset>((event, emit) {
      emit(ResetPasswordInitial());
    });
  }
}
