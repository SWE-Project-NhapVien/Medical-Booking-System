part of 'get_a_profile_bloc.dart';

class GetAProfileEvent extends Equatable {
  const GetAProfileEvent();

  @override
  List<Object> get props => [];
}

class GetAProfileRequired extends GetAProfileEvent {
  final String profileId;

  const GetAProfileRequired({required this.profileId});

  @override
  List<Object> get props => [profileId];
}