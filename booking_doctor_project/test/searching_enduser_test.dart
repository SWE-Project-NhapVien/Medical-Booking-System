import 'package:booking_doctor_project/bloc/History/history_bloc.dart';
import 'package:booking_doctor_project/bloc/History/history_event.dart';
import 'package:booking_doctor_project/bloc/History/history_state.dart';
import 'package:flutter/material.dart';
import 'package:booking_doctor_project/screen/SearchScreen/search_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:booking_doctor_project/class/global_profile.dart';

void main() {
  const String id = "Search doctor";
  const Search_list = ["abc"];
  const size = Size(600, 800);
  GlobalProfile().profileId = "6c05f637-01d1-42b6-9aeb-43dbe5fdf507"; // Testing
  testWidgets(id, (WidgetTester tester) async {
    //Build the widget tree
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => GetHistoryBloc(),
          ),
        ], 
        child: MaterialApp(
          home: MediaQuery(
            data: MediaQueryData(size: size),
            child: SearchScreen(),
          ),
        ))
    );
    final context = tester.element(find.byType(SearchScreen));

    // Find the date
    final date = find.byKey(Key("DateField"));
    expect(date, findsOneWidget);

    // Find the search Bar
    final searchBar = find.byKey(Key("SearchField"));
    expect(searchBar, findsOneWidget);
  });
}