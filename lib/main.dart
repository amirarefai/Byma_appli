import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'business_logic/sign_up_cubit/sign_up_cubit.dart';
import 'screens/login_screen.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const BymaApp());
}

class BymaApp extends StatelessWidget {
  const BymaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignUpCubit(),
      child: MaterialApp(
        title: 'BYMA',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xFFF3F5F7), // لون الخلفية العام للتطبيق
        ),
        home: SplashScreen(
          nextScreen: const LoginScreen(),
        ),
      ),
    );
  }
}
