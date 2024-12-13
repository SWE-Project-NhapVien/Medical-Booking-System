part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();
}

class SignUpRequired extends SignUpEvent {
  final String email;
  final String password;

  const SignUpRequired({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}
