import 'package:booking_doctor_project/bloc/Search/search_event.dart';
import 'package:booking_doctor_project/bloc/Search/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchDoctorsEvent>(_onFetchDoctors);
  }

  Future<void> _onFetchDoctors(
    SearchDoctorsEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchLoading());
    try {
      String? formattedDate;
      if (event.dateQuery != null) {
        DateTime parsedDate = DateTime.parse(event.dateQuery!);
        formattedDate = '${parsedDate.day.toString().padLeft(2, '0')}-'
            '${parsedDate.month.toString().padLeft(2, '0')}-'
            '${parsedDate.year}';
      }

      final supabase = Supabase.instance.client;
      final response = await supabase.rpc('search_doctors', params: {
        'search_query': event.searchQuery,
        'date_query': formattedDate,
      });

      emit(SearchSuccess(response));
    } catch (e) {
      emit(SearchError('Error fetching doctors: $e'));
    }
  }
}
