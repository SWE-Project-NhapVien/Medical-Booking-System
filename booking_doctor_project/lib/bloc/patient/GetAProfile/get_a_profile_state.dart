part of 'get_a_profile_bloc.dart';

sealed class GetAProfileState extends Equatable {
  const GetAProfileState();

  @override
  List<Object> get props => [];
}

class GetAProfileInitial extends GetAProfileState {}

class GetAProfileProcess extends GetAProfileState {}

class GetAProfileSuccess extends GetAProfileState {
  final PatientProfile profile;

  const GetAProfileSuccess({required this.profile});

  @override
  List<Object> get props => [profile];
}

class GetAProfileError extends GetAProfileState {
  final String error;

  const GetAProfileError({required this.error});

  @override
  List<Object> get props => [error];
}