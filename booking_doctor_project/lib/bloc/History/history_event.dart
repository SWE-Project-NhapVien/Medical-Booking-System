sealed class GetHistoryEvent {}

class GetHistoryDataEvent extends GetHistoryEvent {
  final String paptientId;
  GetHistoryDataEvent({required this.paptientId});
}

class UpdateHistoryDataEvent extends GetHistoryEvent {
  final String patientId;
  final String newHistory;
  UpdateHistoryDataEvent({required this.patientId, required this.newHistory});
}

class DeleteHistoryDataEvent extends GetHistoryEvent {
  final String patientId;
  final int index;
  DeleteHistoryDataEvent({required this.patientId, required this.index});
}
