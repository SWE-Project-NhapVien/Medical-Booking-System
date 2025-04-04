part of 'log_in_bloc.dart';

sealed class LogInEvent extends Equatable {
  const LogInEvent();

  @override
  List<Object> get props => [];
}

class LogInRequired extends LogInEvent {
  final String email;
  final String password;

  const LogInRequired({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class LogInReset extends LogInEvent {
  const LogInReset();
  @override
  List<Object> get props => [];
}