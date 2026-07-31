import 'package:byma_app/business_logic/customer_register/cubit/customer_register_cubit.dart';
import 'package:byma_app/business_logic/favorite_hotels/cubit/favorite_hotels_cubit.dart';
import 'package:byma_app/business_logic/favorite_rooms/cubit/favorite_rooms_cubit.dart';
import 'package:byma_app/business_logic/hotels/cubit/hotels_cubit.dart';
import 'package:byma_app/business_logic/recently_viewed_hotels/recently_viewed_hotels_cubit.dart';
import 'package:byma_app/business_logic/toggle_favorite_hotels/cubit/toggle_favorite_hotels_cubit.dart';
import 'package:byma_app/data/network/dio_factory.dart';
import 'package:byma_app/data/repositories/customer_register_repo.dart';
import 'package:byma_app/data/repositories/favorite_hotels_repo.dart';
import 'package:byma_app/data/repositories/favorite_rooms_repo.dart';
import 'package:byma_app/data/repositories/hotels_repo.dart';
import 'package:byma_app/data/repositories/recently_viewed_hotel_repo.dart';

import 'package:byma_app/data/web_services/customer_register_api.dart';
import 'package:byma_app/data/web_services/favorite_hotels_api.dart';
import 'package:byma_app/data/web_services/favorite_rooms_api.dart';
import 'package:byma_app/data/web_services/hotels_api.dart';
import 'package:byma_app/data/web_services/recently_viewed_hotel_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import 'screens/login_screen.dart';
import 'screens/splash_screen.dart';

// Top-level Global Navigator Key for context-free navigation
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
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
  // APIs
  final FavoriteHotelsApi favoriteHotelsApi = FavoriteHotelsApi(
    DioFactory.getDio(),
  );
  final HotelsApi hotelsApi = HotelsApi(
    DioFactory.getDio(),
  );
  final CustomerRegisterApi customerRegisterApi = CustomerRegisterApi(
    DioFactory.getDio(),
  );
  final FavoriteRoomsApi favoriteRoomsApi =FavoriteRoomsApi(DioFactory.getDio()
  );
 final RecentlyViewedHotelApi   recentlyViewedHotelApi=RecentlyViewedHotelApi(DioFactory.getDio()
  );
  // REPOs
  late final FavoriteHotelsRepo favoriteHotelsRepo = FavoriteHotelsRepo(
    favoriteHotelsApi,
  );
  late final HotelsRepo hotelsRepo = HotelsRepo(
    hotelsApi,
  );
  late final CustomerRegisterRepo customerRegisterRepo = CustomerRegisterRepo(
    customerRegisterApi,
  );
  late final FavoriteRoomsRepo favoriteRoomsRepo = FavoriteRoomsRepo(favoriteRoomsApi
  );
  late final RecentlyViewedHotelRepo recentlyViewedHotelRepo = RecentlyViewedHotelRepo(recentlyViewedHotelApi
  );

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

    // Use MultiBlocProvider to inject multiple Cubits into the app
    return MultiBlocProvider(
      providers: [
        // 🌟 1. Cubit الخاص بحذف وإضافة المفضلة (تم التأكد من تمرير الـ repo الصحيح)
        BlocProvider<ToggleFavoriteHotelsCubit>(
          create: (context) => ToggleFavoriteHotelsCubit(favoriteHotelsRepo),
        ),
        
        // 🌟 2. Cubit الخاص بجلب وعرض قائمة الفنادق المفضلة في FavoritesScreen
        BlocProvider<FavoriteHotelsCubit>(
          create: (_) => FavoriteHotelsCubit(favoriteHotelsRepo)..getFavoriteHotels(),
        ),

        BlocProvider<CustomerRegisterCubit>(
          create: (_) => CustomerRegisterCubit(customerRegisterRepo),
        ),
        
        BlocProvider<HotelCubit>(
          create: (_) => HotelCubit(hotelsRepo)..fetchAllHotels(),
        ),
        BlocProvider<FavoriteRoomsCubit>(
          create: (_) => FavoriteRoomsCubit(favoriteRoomsRepo)..getFavoriteRooms(),
        ),
      BlocProvider(
  create: (_) => RecentlyViewedHotelsCubit(recentlyViewedHotelRepo)..getRecentlyViewedHotels(),
),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey, 
        title: 'BYMA',
        debugShowCheckedModeBanner: false,

        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,

        theme: activeTheme,

        routes: {'/login': (context) => const LoginScreen()},

        home: const SplashScreen(nextScreen: LoginScreen()),
      ),
    );
  }
}