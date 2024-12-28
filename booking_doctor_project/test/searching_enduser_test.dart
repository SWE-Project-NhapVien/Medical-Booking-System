import 'package:booking_doctor_project/bloc/History/history_bloc.dart';
import 'package:booking_doctor_project/bloc/Search/search_bloc.dart';
import 'package:booking_doctor_project/bloc/Search/search_state.dart';
import 'package:flutter/material.dart';
import 'package:booking_doctor_project/screen/SearchScreen/search_screen.dart';
import 'package:booking_doctor_project/screen/SearchScreen/search_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:booking_doctor_project/class/global_profile.dart';
import 'package:mockito/mockito.dart';

class MockNavigatorObserver extends NavigatorObserver {
  late Route<dynamic> route;
  late Route<dynamic>? previousRoute;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    this.route = route;
    this.previousRoute = previousRoute;
    super.didPush(route, previousRoute);
  }

}

void main() {
  const String id = "Search doctor";
  const searchList = ["Nguyen Van A"];
  const size = Size(600, 800);
  GlobalProfile().profileId = "6c05f637-01d1-42b6-9aeb-43dbe5fdf507"; // Testing

  int length = searchList.length;
  for (int i = 0; i < length; i++) {
    testWidgets(id, (WidgetTester tester) async {
      final mockNavigatorObserver = MockNavigatorObserver();

      //Build the widget tree
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => GetHistoryBloc(),
            ),
            BlocProvider(
              create: (_) => SearchBloc()
            ),

          ], 
          child: MaterialApp(
            home: MediaQuery(
              data: MediaQueryData(size: size),
              child: SearchScreen(),
            ),
            navigatorObservers: [mockNavigatorObserver],
          ))
      );

      // Find the date
      final date = find.byKey(Key("DateField"));
      expect(date, findsOneWidget);

      // Find the search Bar
      final searchBar = find.byKey(Key("SearchField"));
      expect(searchBar, findsOneWidget);

      // Find the icon 
      final iconMagnefy = find.byIcon(Icons.search);
      expect(iconMagnefy, findsOneWidget);

      await tester.enterText(searchBar, searchList[i]);
      await tester.tap(iconMagnefy);
      await tester.pumpAndSettle();

      // Expect the search result screen
      expect(mockNavigatorObserver.route != null, true);
      expect(mockNavigatorObserver.previousRoute != null, true);
      await tester.pumpAndSettle();

      // Verify bloc status
      final context = tester.element(find.byType(SearchResult));
      final blocResult = context.read<SearchBloc>();

      // Wait for the result being given back
      // final state = blocResult.stream.listen((state) {
      //   debugPrint("Bloc emitted: $state");
      // });
      //expect(state, isA<SearchState>());
      // final state = await blocResult.stream.firstWhere(
      //   (state) => state is SearchSuccess,
      // );
      // expect(state, isA<SearchSuccess>());

      // // Find the list view
      // final doctorResultView = find.byType(ResultsView);
      // expect(doctorResultView, findsOneWidget);

      // Find the listview
      final doctorListViewFinder = find.byType(ListView);
      expect(doctorListViewFinder.evaluate().isNotEmpty, true);
      final visibleItem = find.descendant(
        of: doctorListViewFinder, 
        matching: find.byKey(Key("doctorListViewItem"))
      );
      int itemCount = visibleItem.evaluate().length;
      debugPrint(itemCount.toString());
      for (int i = 0; i < itemCount; i++) {
        debugPrint("${i+1}");
      }

    });
  }
}