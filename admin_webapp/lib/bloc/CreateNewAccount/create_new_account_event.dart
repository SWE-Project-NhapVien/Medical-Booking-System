part of 'create_new_account_bloc.dart';

sealed class CreateNewAccountEvent extends Equatable {
  const CreateNewAccountEvent();

  @override
  List<Object> get props => [];
}

class CreateNewAccountRequired extends CreateNewAccountEvent {
  final String email;
  final String password;

  const CreateNewAccountRequired({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}
