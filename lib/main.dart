import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import 'business_logic/sign_up_cubit/sign_up_cubit.dart';
import 'screens/login_screen.dart';
import 'screens/splash_screen.dart';
import 'state/favorites_scope.dart';
import 'state/favorites_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations', 
      fallbackLocale: const Locale('en'),
      child: const BymaApp(),
    ),
  );
}

class BymaApp extends StatefulWidget {
  const BymaApp({super.key});

  static _BymaAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_BymaAppState>();

  @override
  State<BymaApp> createState() => _BymaAppState();
}

class _BymaAppState extends State<BymaApp> {
  String _currentThemeMode = 'light'; 

  void changeTheme(String themeMode) {
    setState(() {
      _currentThemeMode = themeMode;
    });
  }

  // 1. وضع السطوع العالي (High Contrast)
  ThemeData get _highContrastTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.black,
      cardColor: const Color(0xFF1A1A1A),
      dividerColor: Colors.yellow,
      iconTheme: const IconThemeData(color: Colors.yellow),
      colorScheme: const ColorScheme.dark(
        primary: Colors.yellow,        
        secondary: Colors.white,       
        tertiary: Colors.yellowAccent,
      ),
    );
  }

  // 2. الوضع الداكن (Dark Mode) المتناسق مع الأخضر الزيتي
  ThemeData get _darkTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFF0B1F1C), 
      cardColor: const Color(0xFF122E2A),              
      dividerColor: const Color(0xFF1A423D),
      iconTheme: const IconThemeData(color: Color(0xFF10B981)), 
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF10B981),    
        secondary: Color(0xFFE2E8F0),  
        tertiary: Color(0xFF94A3B8),   
      ),
    );
  }

  // 3. الوضع الفاتح الافتراضي (Light Mode) بناءً على درجات AppColors الأصلية
  ThemeData get _lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFFF8FAFA), 
      cardColor: Colors.white,
      dividerColor: const Color(0xFFE2E8F0),
      iconTheme: const IconThemeData(color: Color(0xFF0FA37A)), 
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF0FA37A),    
        secondary: Color(0xFF0F4A42),  
        tertiary: Color(0xFF7E8A95),   
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData activeTheme;
    if (_currentThemeMode == 'dark') {
      activeTheme = _darkTheme;
    } else if (_currentThemeMode == 'high_contrast') {
      activeTheme = _highContrastTheme;
    } else {
      activeTheme = _lightTheme;
    }

    return BlocProvider(
      create: (_) => SignUpCubit(),
      child: _FavoritesRoot(
        child: MaterialApp(
          title: 'BYMA',
          debugShowCheckedModeBanner: false,
          
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,

          theme: activeTheme,
          
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