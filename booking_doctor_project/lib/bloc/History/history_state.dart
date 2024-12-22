sealed class GetHistoryState {}

class GetHistoryInitial extends GetHistoryState {}

class GetHistoryLoading extends GetHistoryState {}

class GetHistorySuccess extends GetHistoryState {
  final List<dynamic> history;
  GetHistorySuccess(this.history);
}

class GetHistoryError extends GetHistoryState {
  final String error;
  GetHistoryError(this.error);
}
