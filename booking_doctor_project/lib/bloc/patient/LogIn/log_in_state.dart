part of 'log_in_bloc.dart';

sealed class LogInState extends Equatable {
  const LogInState();

  @override
  List<Object?> get props => [];
}

class LogInInitial extends LogInState {}

class LogInProcess extends LogInState {}

class LogInSuccess extends LogInState {}

class LogInFailure extends LogInState {
  final String error;

  const LogInFailure({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
