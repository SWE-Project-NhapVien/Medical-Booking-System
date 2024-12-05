// doctor_state.dart
sealed class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List doctors;
  SearchSuccess(this.doctors);
}

class SearchError extends SearchState {
  final String error;
  SearchError(this.error);
}
