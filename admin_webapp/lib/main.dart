import 'package:booking_doctor_project/bloc/doctor/CreateDoctorProfile/create_doctor_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


import 'package:booking_doctor_project/screen/add_doctor_profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      anonKey: dotenv.env['SUPABASE_ANON_KEY']!);
  await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateDoctorProfileBloc>(
      create: (_) => CreateDoctorProfileBloc(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Admin Webapp',
        home: CreateDoctorProfileScreen(doctorId: '00000000-0000-0000-0000-000000000014',),
      ),
    );
  }

  /*Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Admin Webapp',
        home: HandlePageView());
  }*/
}
