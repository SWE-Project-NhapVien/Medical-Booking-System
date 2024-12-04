// doctor_event.dart
abstract class SearchEvent {}

class SearchDoctorsEvent extends SearchEvent {
  final String? searchQuery;
  final String? dateQuery;

  SearchDoctorsEvent({this.searchQuery, this.dateQuery});
}
