import 'package:admin_webapp/services/authentication/auth_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_new_account_event.dart';
part 'create_new_account_state.dart';

class CreateNewAccountBloc
    extends Bloc<CreateNewAccountEvent, CreateNewAccountState> {
  CreateNewAccountBloc() : super(CreateNewAccountInitial()) {
    on<CreateNewAccountRequired>((event, emit) async {
      emit(CreateNewAccountProcess());
      try {
        final result = await AdminAuthServices().signUpWithEmailPassword(
            email: event.email, password: event.password);
        if (result.session != null) {
          emit(CreateNewAccountSuccess(doctorId: result.user!.id));
        }
      } catch (e) {
        emit(CreateNewAccountFailure(error: e.toString()));
      }
    });
  }
}
