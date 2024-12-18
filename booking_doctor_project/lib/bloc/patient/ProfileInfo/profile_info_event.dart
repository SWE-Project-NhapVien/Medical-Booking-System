sealed class GetInfoEvent2 {}

class GetProfileInfoEvent extends GetInfoEvent2 {
  final String profileId;

  GetProfileInfoEvent({required this.profileId});
}
