part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordState extends Equatable{
  const ForgotPasswordState();

  @override
  List<Object> get props => [];
}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordProcess extends ForgotPasswordState {}

class ForgotPasswordSuccess extends ForgotPasswordState {}

class ForgotPasswordFailure extends ForgotPasswordState {
  final String error;

  const ForgotPasswordFailure({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

class ForgotPasswordOTPFailure extends ForgotPasswordState {
  final String error;

  const ForgotPasswordOTPFailure({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

class ForgotPasswordOTPVerified extends ForgotPasswordState {}