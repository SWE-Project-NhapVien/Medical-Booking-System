part of 'create_profile_bloc.dart';


sealed class CreateProfileState extends Equatable{
  const CreateProfileState();

  @override
  List<Object> get props => [];
}

final class CreateProfileInitial extends CreateProfileState {}

final class CreateProfileProcess extends CreateProfileState {}

final class CreateProfileSuccess extends CreateProfileState {}

final class CreateProfileFailure extends CreateProfileState {
  final String error;

  const CreateProfileFailure(this.error);

  @override
  List<Object> get props => [error];
}
