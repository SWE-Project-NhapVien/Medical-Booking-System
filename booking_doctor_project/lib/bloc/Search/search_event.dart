// doctor_event.dart
sealed class SearchEvent {}

class SearchDoctorsEvent extends SearchEvent {
  final String? searchQuery;
  final String? dateQuery;

  SearchDoctorsEvent({this.searchQuery, this.dateQuery});
}
