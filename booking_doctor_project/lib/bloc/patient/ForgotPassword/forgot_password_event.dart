part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class ForgotPasswordRequired extends ForgotPasswordEvent {
  final String email;

  const ForgotPasswordRequired({required this.email});

  @override
  List<Object> get props => [email];
}

class ForgotPasswordVerifyOTP extends ForgotPasswordEvent {
  final String otp;
  final String email;

  const ForgotPasswordVerifyOTP({required this.email, required this.otp});

  @override
  List<Object> get props => [email, otp];
}

class ForgotPasswordReset extends ForgotPasswordEvent {}