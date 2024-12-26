import 'package:booking_doctor_project/screen/patient/LoginScreen/login_screen.dart';
import 'package:booking_doctor_project/screen/patient/LoginScreen/choose_profile_screen.dart';
import 'package:booking_doctor_project/bloc/patient/ForgotPassword/forgot_password_bloc.dart';
import 'package:booking_doctor_project/bloc/patient/LogIn/log_in_bloc.dart';
import 'package:booking_doctor_project/widgets/common_textfield.dart';
import 'package:booking_doctor_project/widgets/textfield_with_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Login as end user', (WidgetTester tester) async {
    const UserName_list = [''];
    const Password_list = ['password123'];
    const result_list = [false];

    //Build the widget tree
    await tester.pumpWidget(
        MultiBlocProvider(
        providers: [
          BlocProvider<LogInBloc>(create: (context) => LogInBloc()),
          BlocProvider<ForgotPasswordBloc>(
            create: (_) => ForgotPasswordBloc(),
          ),
        ],
        child: MaterialApp(
          home: LoginScreen(
            key: Key('testingLoginScreen'),
            onTap: () {},
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Find the button LogIn
    var button = find.byKey(Key("Login Button"));

    var labelUserName = find.byWidgetPredicate((Widget widget) => widget is CommonTextField && widget.hintText == 'example@example.com');
    var labelPassword = find.byWidgetPredicate((Widget widget) => widget is CommonTextField && widget.hintText == '********');

    // Ensure the button is displayed correctly
    expect(button, findsOneWidget);

    // Ensure the layout is displayed correctly
    expect(labelUserName, findsOneWidget);
    expect(labelPassword, findsOneWidget);

    //Simulate some test case
    int length = UserName_list.length;
    for(int i = 0; i < length; i++) {
      // Test case for valid email or phone number
      await tester.enterText(labelUserName, UserName_list[i]);
      await tester.enterText(labelPassword, Password_list[i]);
      await tester.tap(button);

      // Rebuild the widget after tap the button
      await tester.pumpAndSettle();

      if (result_list[i]) {
        // Find the next screen
        expect(find.byType(ChooseProfileScreen), findsOneWidget);
      }
      else if (UserName_list[i] == "") {
        // Find the error message
        expect(find.text("Email cannot be empty."), findsOneWidget);
      }
      else if (Password_list[i] == "") {
        // Find the error message
        expect(find.text("Password cannot be empty."), findsOneWidget);
      }
      else {
        // Find the error message
        expect(find.text("Invalid email or password."), findsOneWidget);
      }

    }

  });
}