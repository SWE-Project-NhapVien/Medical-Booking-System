import 'package:booking_doctor_project/bloc/patient/ProfileInfo/profile_info_bloc.dart';
import 'package:booking_doctor_project/bloc/patient/UpdateProfile/update_profile_bloc.dart';
import 'package:booking_doctor_project/screen/ProfileScreen/profile_screen_main.dart';
import 'package:booking_doctor_project/class/global_profile.dart';
import 'package:booking_doctor_project/bloc/patient/ProfileInfo/profile_info_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeNavigatorObserver extends NavigatorObserver {
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

  GlobalProfile().profileId = "6c05f637-01d1-42b6-9aeb-43dbe5fdf507"; // Testing
  group('Home Patient', () {
    testWidgets('EditProfile', (WidgetTester tester) async {
      final observer = FakeNavigatorObserver();
      // Build the tree
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<GetProfileInfoBloc>(create: (context) => GetProfileInfoBloc()), 
            BlocProvider<UpdateProfileBloc>(create: (context) => UpdateProfileBloc()),
          ],
          child: MaterialApp(
            home: ProfileScreen(),
          )
        )
      );
      await tester.pumpAndSettle();

      // Verify bloc
      final context = tester.element(find.byType(ProfileScreen));
      final getProfileBloc = context.read<GetProfileInfoBloc>();
      expect(getProfileBloc.state, GetProfileInfoSuccess); // For some reasons that the state is Error

      //Find the edit Profile
      final editProfile = find.byKey(Key("ProfileInfo"));
      expect(editProfile, findsOneWidget);

      // Tap on the edit profile
      await tester.tap(editProfile);
      expect(observer.route != null, true);
      expect(observer.previousRoute != null, true);
    });

    testWidgets('Policy', (WidgetTester tester) async {
      final observer = FakeNavigatorObserver();
      // Build the tree
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<GetProfileInfoBloc>(create: (context) => GetProfileInfoBloc()), 
            BlocProvider<UpdateProfileBloc>(create: (context) => UpdateProfileBloc()),
          ],
          child: MaterialApp(
            home: ProfileScreen(),
          )
        )
      );
      await tester.pumpAndSettle();

      // Verify bloc
      final context = tester.element(find.byType(ProfileScreen));
      final getProfileBloc = context.read<GetProfileInfoBloc>();
      expect(getProfileBloc.state, GetProfileInfoSuccess); // For some reasons that the state is Error

      //Find the edit Profile
      final policy = find.byKey(Key("Policy"));
      expect(policy, findsOneWidget);

      // Tap on the edit profile
      await tester.tap(policy);
      expect(observer.route != null, true);
      expect(observer.previousRoute != null, true);
    });

    testWidgets('Switch Profile', (WidgetTester tester) async {
      final observer = FakeNavigatorObserver();
      // Build the tree
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<GetProfileInfoBloc>(create: (context) => GetProfileInfoBloc()), 
            BlocProvider<UpdateProfileBloc>(create: (context) => UpdateProfileBloc()),
          ],
          child: MaterialApp(
            home: ProfileScreen(),
          )
        )
      );
      await tester.pumpAndSettle();

      // Verify bloc
      final context = tester.element(find.byType(ProfileScreen));
      final getProfileBloc = context.read<GetProfileInfoBloc>();
      expect(getProfileBloc.state, GetProfileInfoSuccess); // For some reasons that the state is Error

      //Find the edit Profile
      final switchProfile = find.byKey(Key("SwithProfile"));
      expect(switchProfile, findsOneWidget);

      // Tap on the edit profile
      await tester.tap(switchProfile);
      expect(observer.route != null, true);
      expect(observer.previousRoute != null, true);
    });

    testWidgets('Logout', (WidgetTester tester) async {
      final observer = FakeNavigatorObserver();
      // Build the tree
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<GetProfileInfoBloc>(create: (context) => GetProfileInfoBloc()), 
            BlocProvider<UpdateProfileBloc>(create: (context) => UpdateProfileBloc()),
          ],
          child: MaterialApp(
            home: ProfileScreen(),
          )
        )
      );
      await tester.pumpAndSettle();

      // Verify bloc
      final context = tester.element(find.byType(ProfileScreen));
      final getProfileBloc = context.read<GetProfileInfoBloc>();
      expect(getProfileBloc.state, GetProfileInfoSuccess); // For some reasons that the state is Error

      //Find the edit Profile
      final logout = find.byKey(Key("Logout"));
      expect(logout, findsOneWidget);

      // Tap on the edit profile
      await tester.tap(logout);
      expect(find.text("Logged Out"), findsOneWidget);

      // Tap on the button and log out
      final logoutButton = find.byKey(Key("logoutButton"));
      await tester.tap(logoutButton);
      expect(observer.route != null, true);
      expect(observer.previousRoute != null, true);
    });
  });
}