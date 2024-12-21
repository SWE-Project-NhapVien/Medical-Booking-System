import 'package:admin_webapp/services/authentication/auth_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginRequired>((event, emit) async {
      emit(LoginProcess());
      try{
        final result = await AdminAuthServices().signInWithEmailPassword(
          email: event.email,
          password: event.password,
        );
        if (result.session != null) {
          emit(LoginSuccess());
        }
      } catch (e) {
        if (e.toString().contains("invalid-credentials")) {
          emit(const LoginFailure(error: "Invalid email or password."));
        }  else {
          emit(LoginFailure(error: e.toString()));
        }
      }
    });
  } 
}
