part of 'fetch_profile_bloc.dart';

sealed class FetchProfileState extends Equatable {
  const FetchProfileState();

  @override
  List<Object> get props => [];
}

class FetchProfileInitial extends FetchProfileState {}

class FetchProfileProcess extends FetchProfileState {}

class FetchProfileSuccess extends FetchProfileState {
  final List<Map<String, dynamic>> profiles;

  const FetchProfileSuccess({required this.profiles});

  @override
  List<Object> get props => [profiles];
}

class FetchProfileError extends FetchProfileState {
  final String error;

  const FetchProfileError({required this.error});

  @override
  List<Object> get props => [error];
}
