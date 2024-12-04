import 'package:booking_doctor_project/bloc/patient/FetchProfile/fetch_profile_bloc.dart';
import 'package:booking_doctor_project/bloc/patient/ForgotPassword/forgot_password_bloc.dart';
import 'package:booking_doctor_project/bloc/patient/LogIn/log_in_bloc.dart';
import 'package:booking_doctor_project/bloc/patient/ResetPassword/reset_password_bloc.dart';
import 'package:booking_doctor_project/bloc/patient/SignUp/sign_up_bloc.dart';
import 'package:booking_doctor_project/bloc_observer.dart';
import 'package:booking_doctor_project/medical_booking_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      anonKey: dotenv.env['SUPABASE_ANON_KEY']!);
  Bloc.observer = SimpleBlocObserver();

  Supabase.instance.client.auth.onAuthStateChange.listen((data) {
    final event = data.event;
    if (event == AuthChangeEvent.passwordRecovery) {
      navigatorKey.currentState?.pushNamed('/reset-password');
    }
  });

  await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(_setAllProviders()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MedicalBookingApp();
  }
}

Widget _setAllProviders() {
  return MultiBlocProvider(
    providers: [
      BlocProvider<LogInBloc>(
        create: (context) => LogInBloc(),
      ),
      BlocProvider<SignUpBloc>(
        create: (context) => SignUpBloc(),
      ),
      BlocProvider<ForgotPasswordBloc>(
          create: (context) => ForgotPasswordBloc()),
      BlocProvider<ResetPasswordBloc>(
          create: (context) => ResetPasswordBloc()),
      BlocProvider<FetchProfileBloc>(
          create: (context) => FetchProfileBloc()),
    ],
    child: const MyApp(),
  );
}
