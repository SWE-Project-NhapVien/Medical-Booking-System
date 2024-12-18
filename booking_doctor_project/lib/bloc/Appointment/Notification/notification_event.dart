sealed class GetNotiEvent {}

class GetNotificationDataEvent extends GetNotiEvent {
  final List<String> notiIdList;

  GetNotificationDataEvent({required this.notiIdList});
}

class UpdateNotificationStatusEvent extends GetNotiEvent {
  final List<String> notiIdList;

  UpdateNotificationStatusEvent({required this.notiIdList});
}
