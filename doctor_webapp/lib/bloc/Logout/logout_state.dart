part of 'logout_bloc.dart';

sealed class LogoutState extends Equatable {
  const LogoutState();
  
  @override
  List<Object> get props => [];
}

final class LogoutInitial extends LogoutState {}

final class LogoutProcess extends LogoutState {}

final class LogoutSuccess extends LogoutState {}

final class LogoutFailure extends LogoutState {
  final String error;

  const LogoutFailure(this.error);

  @override
  List<Object> get props => [error];
}