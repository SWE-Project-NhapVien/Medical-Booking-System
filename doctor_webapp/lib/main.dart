import 'package:doctor_webapp/bloc/DoctorLogin/doctor_login_bloc.dart';
import 'package:doctor_webapp/bloc/ForgotPassword/forgot_password_bloc.dart';
import 'package:doctor_webapp/bloc/Logout/logout_bloc.dart';
import 'package:doctor_webapp/bloc_observer.dart';
import 'package:doctor_webapp/screen/appointment/examine_screen.dart';
import 'package:doctor_webapp/screen/login/login_screen.dart';
import 'package:doctor_webapp/screen/reset_password/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  Bloc.observer = SimpleBlocObserver();
  await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      anonKey: dotenv.env['SUPABASE_ANON_KEY']!);

  await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(_setAllProviders()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Doctor Webapp',
      routes: _buildRoutes(),
      navigatorKey: navigatorKey,
      // home: const LoginScreen()
    );
  }

  Map<String, WidgetBuilder> _buildRoutes() {
    return {
      '/': (BuildContext context) => const LoginScreen(),
      '/reset-password': (BuildContext context) => const ResetPasswordScreen(),
    };
  }
}

Widget _setAllProviders() {
  return MultiBlocProvider(
    providers: [
      BlocProvider<DoctorLoginBloc>(create: (context) => DoctorLoginBloc()),
      BlocProvider<ForgotPasswordBloc>(
          create: (context) => ForgotPasswordBloc()),
      BlocProvider<LogoutBloc>(create: (context) => LogoutBloc()),
    ],
    child: const MyApp(),
  );
}
