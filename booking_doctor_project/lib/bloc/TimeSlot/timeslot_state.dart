sealed class GetTimeSlotState {}

class GetTimeSlotInitial extends GetTimeSlotState {}

class GetTimeSlotLoading extends GetTimeSlotState {}

class GetTimeSlotSuccess extends GetTimeSlotState {
  final List<dynamic> timeSlot;
  GetTimeSlotSuccess(this.timeSlot);
}

class GetTimeSlotError extends GetTimeSlotState {
  final String error;
  GetTimeSlotError(this.error);
}
