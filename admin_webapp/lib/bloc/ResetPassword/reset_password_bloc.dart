import 'package:admin_webapp/services/authentication/auth_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  ResetPasswordBloc() : super(ResetPasswordInitial()) {
    on<ResetPasswordRequired>((event, emit) async {
      emit(ResetPasswordProcess());
      try{
        await AdminAuthServices().updatePassword(password: event.newPassword);
        emit(ResetPasswordSuccess());
      } catch (e) {
        emit(ResetPasswordFailure(error: e.toString()));
      }
    });
  }
}
