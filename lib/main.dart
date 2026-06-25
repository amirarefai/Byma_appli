import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'business_logic/sign_up_cubit/sign_up_cubit.dart';
import 'screens/login_screen.dart';
import 'screens/splash_screen.dart';
import 'state/favorites_scope.dart';
import 'state/favorites_store.dart';

void main() {
  runApp(const BymaApp());
}

class BymaApp extends StatelessWidget {
  const BymaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignUpCubit(),
      child: _FavoritesRoot(
        child: MaterialApp(
          title: 'BYMA',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            scaffoldBackgroundColor: const Color(0xFFF3F5F7), // لون الخلفية العام للتطبيق
          ),
          home: const SplashScreen(
            nextScreen: LoginScreen(),
          ),
        ),
      ),
    );
  }
}

class _FavoritesRoot extends StatefulWidget {
  final Widget child;

  const _FavoritesRoot({required this.child});

  @override
  State<_FavoritesRoot> createState() => _FavoritesRootState();
}

class _FavoritesRootState extends State<_FavoritesRoot> {
  final FavoritesStore _store = FavoritesStore();

  @override
  Widget build(BuildContext context) {
    return FavoritesScope(
      store: _store,
      child: widget.child,
    );
  }
}
