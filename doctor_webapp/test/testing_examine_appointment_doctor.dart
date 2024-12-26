import 'package:doctor_webapp/DataLayer/data/appointment_data_provider.dart';
import 'package:doctor_webapp/DataLayer/repository/appointment_repository.dart';
import 'package:doctor_webapp/bloc/Appointment/appointment_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:doctor_webapp/screen/appointment/appointment_screen.dart';

void main() {
  const tabBar_list = ["Upcoming", "Completed", "Cancelled"];

  testWidgets('Test examining appointments and information of patients', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => AppointmentRepository(
              appointmentDataProvider: AppointmentDataProvider()
            )
          )
        ], 
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AppointmentBloc>(create: (context) => AppointmentBloc(
              appointmentRepository: context.read<AppointmentRepository>()
            )), 
          ],
          child: const MaterialApp(
            home: AppointmentScreen(),
          )
        )
      )
    );

    await tester.pumpAndSettle();

    //Find the tab bar
    var tabBar = find.byKey(const Key('TabBar Appointment'));

  });
}