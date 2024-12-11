sealed class GetNotificationState {}

class GetNotificationInitial extends GetNotificationState {}

class GetNotificationLoading extends GetNotificationState {}

class GetNotificationSuccess extends GetNotificationState {
  final List notificationList;

  GetNotificationSuccess(this.notificationList);
}

class GetNotificationError extends GetNotificationState {
  final String error;

  GetNotificationError(this.error);
}

//-------------------------------------------------------------
class UpdateNotificationStatusError extends GetNotificationState {
  final String error;

  UpdateNotificationStatusError(this.error);
}
