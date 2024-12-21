import 'package:admin_webapp/bloc/AdminLogin/login_bloc.dart';
import 'package:admin_webapp/bloc/ForgotPassword/forgot_password_bloc.dart';
import 'package:admin_webapp/bloc/Logout/logout_bloc.dart';
import 'package:admin_webapp/screen/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
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
        routes: _buildRoutes(),
        title: 'Admin Webapp',
  );
}

  Map<String, WidgetBuilder> _buildRoutes() {
    return {
      '/': (BuildContext context) => const LoginScreen(),
    };
  }
}

Widget _setAllProviders() {
  return MultiBlocProvider(
    providers: [
      BlocProvider<LoginBloc>(create: (context) => LoginBloc()),
      BlocProvider<ForgotPasswordBloc>(create: (context) => ForgotPasswordBloc()),
      BlocProvider<LogoutBloc>(create: (context) => LogoutBloc()),
    ],
    child: const MyApp(),
  );
}