import 'package:booking_doctor_project/screen/patient/LoginScreen/login_screen.dart';
import 'package:booking_doctor_project/screen/patient/LoginScreen/choose_profile_screen.dart';
import 'package:booking_doctor_project/bloc/patient/FetchProfile/fetch_profile_bloc.dart';
import 'package:booking_doctor_project/bloc/patient/GetAProfile/get_a_profile_bloc.dart';
import 'package:booking_doctor_project/bloc/patient/ForgotPassword/forgot_password_bloc.dart';
import 'package:booking_doctor_project/bloc/patient/LogIn/log_in_bloc.dart';
import 'package:booking_doctor_project/widgets/common_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:io';

void main() {
  const UserName_list = ['nvk01052004@gmail.com', '', 'minhco2910@gmail.com', '!!#^%\$', 'example@gmail.com'];
  const Password_list = ['Khang123', 'password123', 'password123', '!!#^%\$', ''];
  const result_list = [true, false, false, false, false];
  const String filePath = './test/test_login_enduser_result.txt';

  File(filePath).writeAsStringSync('');

  const String id = 'Login as end user';
  int length = UserName_list.length;
  for (int i = 0; i < length; i++) {
    testWidgets(id, (WidgetTester tester) async {
      //Build the widget tree
      await tester.pumpWidget(
          MultiBlocProvider(
          providers: [
            BlocProvider<LogInBloc>(create: (context) => LogInBloc()),
            BlocProvider<ForgotPasswordBloc>(
              create: (_) => ForgotPasswordBloc(),
            ),
            BlocProvider<FetchProfileBloc>(create: (context) => FetchProfileBloc()),
            BlocProvider<GetAProfileBloc>(create: (context) => GetAProfileBloc()),
          ],
          child: MaterialApp(
            home: LoginScreen(
              key: Key('testingLoginScreen'),
              onTap: () {debugPrint("Enter");},
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
      if (button.evaluate().isEmpty) {
        writeResult(0, id, 'Displayed Log In Button', 'Failed', 'Found no widget', "", "", "");
        return;
      }

      // Ensure the layout is displayed correctly
      if (labelUserName.evaluate().isEmpty) {
        writeResult(0, id, 'Displayed Log In TextEdit', 'Failed', 'Found no widget', "", "", "");
        return;
      }
      if (labelPassword.evaluate().isEmpty) {
        writeResult(0, id, 'Displayed Password TextEdit', 'Failed', 'Found no widget', "", "", "");
        return;
      }

      //Simulate some test case

      // Test case for valid email or phone number
      await tester.enterText(labelUserName, UserName_list[i]);
      await tester.enterText(labelPassword, Password_list[i]);
      await tester.tap(button);

      // Rebuild the widget after tap the button
      await tester.pumpAndSettle();

      await tester.runAsync(() async {
        if (UserName_list[i] == "") {
          // Find the error message
          var textWidget = find.text("Email cannot be empty.");
          if (textWidget.evaluate().isNotEmpty) {
            writeResult(1, "${id}_${i+1}", "Email cannot be empty", "Passed", "", 
            "\n+ ${UserName_list[i]} \n+ ${Password_list[i]}", "Same with ER", "\n+ Disallowed access \n+ Show the error message");
          }
          else {
            writeResult(1, "${id}_${i+1}", "Email cannot be empty", "Failed", "", 
            "\n+ ${UserName_list[i]} \n+ ${Password_list[i]}", "Doesn't show error message", "\n+ Disallowed access \n+ Show the error message");
          }
          expect(textWidget, findsOneWidget);
        }
        else if (Password_list[i] == "") {
          // Find the error message
          var textWidget = find.text("Password cannot be empty.");
          if (textWidget.evaluate().isNotEmpty) {
            writeResult(1, "${id}_${i+1}", "Password cannot be empty.", "Passed", "", 
            "\n+ ${UserName_list[i]} \n+ ${Password_list[i]}", "Same with ER", "\n+ Disallowed access \n+ Show the error message");
          }
          else {
            writeResult(1, "${id}_${i+1}", "Password cannot be empty.", "Failed", "", 
            "\n+ ${UserName_list[i]} \n+ ${Password_list[i]}", "Doesn't show error message", "\n+ Disallowed access \n+ Show the error message");
          }
          expect(textWidget, findsOneWidget);
        }
        else if (result_list[i] == true) {
          final logInBloc = BlocProvider.of<LogInBloc>(tester.element(find.byType(LoginScreen)));
          logInBloc.emit(LogInSuccess());

          await tester.pumpAndSettle();

          // Find the next screen
          writeResult(1, "${id}_${i+1}", "Correct input", "Passed", "", "\n+ ${UserName_list[i]} \n+ ${Password_list[i]}",
          "Same as ER", "Allows the user to proceed");
          expect(find.byType(ChooseProfileScreen), findsOneWidget);
        }
        else {
          //Check if the application doesn't allow authentication
          expect(find.byType(LoginScreen), findsOneWidget);
          debugPrint("LoginScreen");
          await tester.pump(Duration(seconds: 2));

          // Find the dialogs error
          writeResult(1, "${id}_${i+1}", "Incorrect input", "Passed", "", 
          "\n+ ${UserName_list[i]} \n+ ${Password_list[i]}", "Same as ER", "\n+ Disallowed access \n+ Show the error message");
          expect(find.byType(AlertDialog), findsOneWidget);
        }
      });

    }

    );
  }
}

void writeResult(
    int type, String id, String nameTestCase, 
    String status, String reason, String input, String output,
    String expectedOutput
    ) 
{ //type 0 check UI, type 1 check input, output
  const String filePath = './test/test_login_enduser_result.txt';
  String result = '';
  if (type == 0) {
    result += 
    '''
ID: $id
Test case: $nameTestCase
Status: $status
Reason: $reason
    \n''';
  }
  else {
    result += 
  '''
ID: $id
Test case: $nameTestCase
Input: $input
Expected Output: $expectedOutput
Output: $output
Status: $status
Reason: $reason
  \n''';
  }
  File(filePath).writeAsStringSync(result, mode: FileMode.append);
}