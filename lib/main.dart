import 'package:byma_app/business_logic/add_hotel_to_collection/cubit/add_hotel_to_collection_cubit.dart';
import 'package:byma_app/business_logic/add_recently_viewed_hotel/cubit/add_recently_viewed_hotel_cubit.dart';
import 'package:byma_app/business_logic/add_recently_viewed_room/cubit/add_recently_viewed_room_cubit.dart';
import 'package:byma_app/business_logic/add_room_to_collection/cubit/add_room_to_collection_cubit.dart';
import 'package:byma_app/business_logic/booking_history/cubit/booking_history_cubit.dart';
import 'package:byma_app/business_logic/bookings_transactions/cubit/bookings_transactions_cubit.dart';
import 'package:byma_app/business_logic/cancel_booking/cubit/cancel_booking_cubit.dart';
import 'package:byma_app/business_logic/cities/cubit/cities_cubit.dart';
import 'package:byma_app/business_logic/collection/cubit/collection_cubit.dart';
import 'package:byma_app/business_logic/create_collection/cubit/create_collection_cubit.dart';
import 'package:byma_app/business_logic/create_deposit/cubit/create_deposit_cubit.dart';
import 'package:byma_app/business_logic/create_withdraw/cubit/create_withdraw_cubit.dart';
import 'package:byma_app/business_logic/customer_register/cubit/customer_register_cubit.dart';
import 'package:byma_app/business_logic/delete_collection/cubit/delete_collection_cubit.dart';
import 'package:byma_app/business_logic/delete_hotel_from_collection/cubit/delete_hotel_from_collection_cubit.dart';
import 'package:byma_app/business_logic/delete_room_from_collection/cubit/delete_room_from_collection_cubit.dart';
import 'package:byma_app/business_logic/deposit_history/cubit/deposit_history_cubit.dart';
import 'package:byma_app/business_logic/favorite_hotels/cubit/favorite_hotels_cubit.dart';
import 'package:byma_app/business_logic/get_profile/cubit/get_profile_cubit.dart';
import 'package:byma_app/business_logic/hotel_collection/cubit/hotel_collection_cubit.dart';
import 'package:byma_app/business_logic/hotel_details/cubit/hotel_details_cubit.dart';
import 'package:byma_app/business_logic/hotel_rooms_filter/cubit/hotel_rooms_filter_cubit.dart';
import 'package:byma_app/business_logic/hotels/cubit/hotels_cubit.dart';
import 'package:byma_app/business_logic/points_transactions/cubit/points_transactions_cubit.dart';
import 'package:byma_app/business_logic/recently_viewed_hotels/recently_viewed_hotels_cubit.dart';
import 'package:byma_app/business_logic/recently_viewed_rooms/cubit/recently_viewed_rooms_cubit.dart';
import 'package:byma_app/business_logic/reports/cubit/reports_cubit.dart';
import 'package:byma_app/business_logic/reviews/cubit/reviews_cubit.dart';
import 'package:byma_app/business_logic/room_category/cubit/room_category_cubit.dart';
import 'package:byma_app/business_logic/room_collection/cubit/room_collection_cubit.dart';
import 'package:byma_app/business_logic/room_details/cubit/room_details_cubit.dart';
import 'package:byma_app/business_logic/favorite_rooms/cubit/favorite_rooms_cubit.dart';
import 'package:byma_app/business_logic/toggle_favorite_hotels/cubit/toggle_favorite_hotels_cubit.dart';
import 'package:byma_app/business_logic/toggle_favorite_rooms/cubit/toggle_favorite_rooms_cubit.dart';
import 'package:byma_app/business_logic/update_profile/cubit/update_profile_cubit.dart';
import 'package:byma_app/business_logic/withdraw_history/cubit/withdraw_history_cubit.dart';
import 'package:byma_app/data/network/dio_factory.dart';
import 'package:byma_app/data/repositories/booking-repo.dart';
import 'package:byma_app/data/repositories/cities_repo.dart';
import 'package:byma_app/data/repositories/collection_repo.dart';
import 'package:byma_app/data/repositories/customer_register_repo.dart';
import 'package:byma_app/data/repositories/deposit_repo.dart';
import 'package:byma_app/data/repositories/favorite_hotels_repo.dart';
import 'package:byma_app/data/repositories/hotel_collection_repo.dart';
import 'package:byma_app/data/repositories/hotels_repo.dart';
import 'package:byma_app/data/repositories/points_transactions_repo.dart';
import 'package:byma_app/data/repositories/profile_repo.dart';
import 'package:byma_app/data/repositories/recently_viewed_hotel_repo.dart';
import 'package:byma_app/data/repositories/recently_viewed_room_repo.dart';
import 'package:byma_app/data/repositories/reports_repo.dart';
import 'package:byma_app/data/repositories/reviews_repo.dart';
import 'package:byma_app/data/repositories/room_collection_repo.dart';
import 'package:byma_app/data/repositories/room_details_repo.dart';
import 'package:byma_app/data/repositories/withdraw_repo.dart';
import 'package:byma_app/data/web_services/booking_api.dart';
import 'package:byma_app/data/web_services/cities_api.dart';
import 'package:byma_app/data/web_services/collection_api.dart';
import 'package:byma_app/data/web_services/customer_register_api.dart';
import 'package:byma_app/data/web_services/deposit_api.dart';
import 'package:byma_app/data/web_services/favorite_hotels_api.dart';
import 'package:byma_app/data/web_services/favorite_rooms_api.dart';
import 'package:byma_app/data/web_services/hotel_collection_api.dart';
import 'package:byma_app/data/web_services/hotels_api.dart';
import 'package:byma_app/data/web_services/points_transactions_api.dart';
import 'package:byma_app/data/web_services/profile_api.dart';
import 'package:byma_app/data/web_services/recently_viewed_hotel_api.dart';
import 'package:byma_app/data/web_services/recently_viewed_room_api.dart';
import 'package:byma_app/data/web_services/reports_api.dart';
import 'package:byma_app/data/web_services/reviews_api.dart';
import 'package:byma_app/data/web_services/room_collection_api.dart';
import 'package:byma_app/data/web_services/room_details_api.dart';
import 'package:byma_app/data/repositories/favorite_rooms_repo.dart';
import 'package:byma_app/data/web_services/withdraw_api.dart';

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
  //APIs
  final FavoriteHotelsApi favoriteHotelsApi = FavoriteHotelsApi(
    DioFactory.getDio(),
  );
  final HotelsApi hotelsApi = HotelsApi(DioFactory.getDio());
  final CustomerRegisterApi customerRegisterApi = CustomerRegisterApi(
    DioFactory.getDio(),
  );
  final RoomDetailsApi roomDetailsApi = RoomDetailsApi(DioFactory.getDio());
  final FavoriteRoomsApi favoriteRoomsApi = FavoriteRoomsApi(
    DioFactory.getDio(),
  );
  final RecentlyViewedHotelApi recentlyViewedHotelApi = RecentlyViewedHotelApi(
    DioFactory.getDio(),
  );
  final RecentlyViewedRoomApi recentlyViewedRoomApi = RecentlyViewedRoomApi(
    DioFactory.getDio(),
  );
  final CollectionApi collectionApi = CollectionApi(DioFactory.getDio());
  final HotelCollectionApi hotelCollectionApi = HotelCollectionApi(
    DioFactory.getDio(),
  );
  final RoomCollectionApi roomCollectionApi = RoomCollectionApi(
    DioFactory.getDio(),
  );
  final ReportsApi reportsApi = ReportsApi(DioFactory.getDio());
  final ReviewsApi reviewsApi = ReviewsApi(DioFactory.getDio());
  final BookingApi bookingApi = BookingApi(DioFactory.getDio());
  final CitiesApi citiesApi = CitiesApi(DioFactory.getDio());
  final PointsTransactionsApi pointsTransactionsApi = PointsTransactionsApi(
    DioFactory.getDio(),
  );
  final DepositApi depositApi = DepositApi(DioFactory.getDio());
  final WithdrawApi withdrawApi = WithdrawApi(DioFactory.getDio());
  final ProfileApi profileApi = ProfileApi(DioFactory.getDio());

  //REPOs
  late final FavoriteHotelsRepo favoriteHotelsRepo = FavoriteHotelsRepo(
    favoriteHotelsApi,
  );
  late final HotelsRepo hotelsRepo = HotelsRepo(hotelsApi);
  late final CustomerRegisterRepo customerRegisterRepo = CustomerRegisterRepo(
    customerRegisterApi,
  );
  late final RoomDetailsRepo roomDetailsRepo = RoomDetailsRepo(roomDetailsApi);
  late final FavoriteRoomsRepo favoriteRoomsRepo = FavoriteRoomsRepo(
    favoriteRoomsApi,
  );
  late final RecentlyViewedHotelRepo recentlyViewedHotelRepo =
      RecentlyViewedHotelRepo(recentlyViewedHotelApi);
  late final RecentlyViewedRoomRepo recentlyViewedRoomRepo =
      RecentlyViewedRoomRepo(recentlyViewedRoomApi);
  late final CollectionRepo collectionRepo = CollectionRepo(collectionApi);
  late final HotelCollectionRepo hotelCollectionRepo = HotelCollectionRepo(
    hotelCollectionApi,
  );
  late final RoomCollectionRepo roomCollectionRepo = RoomCollectionRepo(
    roomCollectionApi,
  );
  late final ReportsRepo reportsRepo = ReportsRepo(reportsApi);
  late final ReviewsRepo reviewsRepo = ReviewsRepo(reviewsApi);
  late final BookingRepo bookingRepo = BookingRepo(bookingApi);
  late final CitiesRepo citiesRepo = CitiesRepo(citiesApi);
  late final PointsTransactionsRepo pointsTransactionsRepo =
      PointsTransactionsRepo(pointsTransactionsApi);
  late final DepositRepo depositRepo = DepositRepo(depositApi);
  late final WithdrawRepo withdrawRepo = WithdrawRepo(withdrawApi);
  late final ProfileRepo profileRepo = ProfileRepo(profileApi);
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
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<FavoriteHotelsRepo>.value(value: favoriteHotelsRepo),
        RepositoryProvider<HotelsRepo>.value(value: hotelsRepo),
        RepositoryProvider<CustomerRegisterRepo>.value(
          value: customerRegisterRepo,
        ),
        RepositoryProvider<RoomDetailsRepo>.value(value: roomDetailsRepo),
        RepositoryProvider<FavoriteRoomsRepo>.value(value: favoriteRoomsRepo),
        RepositoryProvider<RecentlyViewedHotelRepo>.value(
          value: recentlyViewedHotelRepo,
        ),
        RepositoryProvider<RecentlyViewedRoomRepo>.value(
          value: recentlyViewedRoomRepo,
        ),
        RepositoryProvider<CollectionRepo>.value(value: collectionRepo),
        RepositoryProvider<HotelCollectionRepo>.value(
          value: hotelCollectionRepo,
        ),
        RepositoryProvider<RoomCollectionRepo>.value(value: roomCollectionRepo),
        RepositoryProvider<ReportsRepo>.value(value: reportsRepo),
        RepositoryProvider<ReviewsRepo>.value(value: reviewsRepo),
        RepositoryProvider<BookingRepo>.value(value: bookingRepo),
        RepositoryProvider<CitiesRepo>.value(value: citiesRepo),
        RepositoryProvider<PointsTransactionsRepo>.value(
          value: pointsTransactionsRepo,
        ),
        RepositoryProvider<DepositRepo>.value(value: depositRepo),
        RepositoryProvider<WithdrawRepo>.value(value: withdrawRepo),
        RepositoryProvider<ProfileRepo>.value(value: profileRepo),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ToggleFavoriteHotelsCubit>(
            lazy: false,
            create: (context) =>
                ToggleFavoriteHotelsCubit(context.read<FavoriteHotelsRepo>()),
          ),
          BlocProvider<ToggleFavoriteRoomsCubit>(
            lazy: false,
            create: (context) =>
                ToggleFavoriteRoomsCubit(context.read<FavoriteRoomsRepo>()),
          ),
          BlocProvider<FavoriteHotelsCubit>(
            lazy: false,
            create: (context) =>
                FavoriteHotelsCubit(context.read<FavoriteHotelsRepo>())
                  ..getFavoriteHotels(),
          ),
          BlocProvider<CustomerRegisterCubit>(
            create: (context) =>
                CustomerRegisterCubit(context.read<CustomerRegisterRepo>()),
          ),
          BlocProvider<HotelCubit>(
            lazy: false,
            create: (context) =>
                HotelCubit(context.read<HotelsRepo>())..fetchAllHotels(),
          ),
          BlocProvider<HotelDetailsCubit>(
            create: (context) => HotelDetailsCubit(context.read<HotelsRepo>()),
          ),
          BlocProvider<RoomDetailsCubit>(
            create: (context) =>
                RoomDetailsCubit(context.read<RoomDetailsRepo>()),
          ),
          BlocProvider<FavoriteRoomsCubit>(
            lazy: false,
            create: (context) =>
                FavoriteRoomsCubit(context.read<FavoriteRoomsRepo>())
                  ..getFavoriteRooms(),
          ),
          BlocProvider<RecentlyViewedHotelsCubit>(
            lazy: false,
            create: (context) => RecentlyViewedHotelsCubit(
              context.read<RecentlyViewedHotelRepo>(),
            )..getRecentlyViewedHotels(),
          ),
          BlocProvider<AddRecentlyViewedHotelsCubit>(
            create: (context) => AddRecentlyViewedHotelsCubit(
              context.read<RecentlyViewedHotelRepo>(),
            ),
          ),
          BlocProvider<RecentlyViewedRoomsCubit>(
            lazy: false,
            create: (context) =>
                RecentlyViewedRoomsCubit(context.read<RecentlyViewedRoomRepo>())
                  ..getRecentlyViewedRooms(),
          ),
          BlocProvider<AddRecentlyViewedRoomsCubit>(
            create: (context) => AddRecentlyViewedRoomsCubit(
              context.read<RecentlyViewedRoomRepo>(),
            ),
          ),
          BlocProvider<CollectionCubit>(
            lazy: false,
            create: (context) =>
                CollectionCubit(context.read<CollectionRepo>())
                  ..fetchAllCollections(),
          ),
          BlocProvider<HotelCollectionCubit>(
            lazy: false,
            create: (context) =>
                HotelCollectionCubit(context.read<HotelCollectionRepo>()),
          ),
          BlocProvider<RoomCollectionCubit>(
            lazy: false,
            create: (context) =>
                RoomCollectionCubit(context.read<RoomCollectionRepo>()),
          ),
          BlocProvider<DeleteCollectionCubit>(
            lazy: false,
            create: (context) =>
                DeleteCollectionCubit(context.read<CollectionRepo>()),
          ),
          BlocProvider<DeleteHotelFromCollectionCubit>(
            lazy: false,
            create: (context) => DeleteHotelFromCollectionCubit(
              context.read<HotelCollectionRepo>(),
            ),
          ),
          BlocProvider<DeleteRoomFromCollectionCubit>(
            lazy: false,
            create: (context) => DeleteRoomFromCollectionCubit(
              context.read<RoomCollectionRepo>(),
            ),
          ),
          BlocProvider<CreateCollectionCubit>(
            lazy: false,
            create: (context) =>
                CreateCollectionCubit(context.read<CollectionRepo>()),
          ),
          BlocProvider<AddHotelToCollectionCubit>(
            lazy: false,
            create: (context) =>
                AddHotelToCollectionCubit(context.read<HotelCollectionRepo>()),
          ),
          BlocProvider<AddRoomToCollectionCubit>(
            lazy: false,
            create: (context) =>
                AddRoomToCollectionCubit(context.read<RoomCollectionRepo>()),
          ),
          BlocProvider<ReportsCubit>(
            lazy: false,
            create: (context) => ReportsCubit(context.read<ReportsRepo>()),
          ),
          BlocProvider<ReviewsCubit>(
            lazy: false,
            create: (context) => ReviewsCubit(context.read<ReviewsRepo>()),
          ),
          BlocProvider<CancelBookingCubit>(
            create: (context) =>
                CancelBookingCubit(context.read<BookingRepo>()),
          ),
          BlocProvider<BookingHistoryCubit>(
            create: (context) =>
                BookingHistoryCubit(context.read<BookingRepo>()),
          ),
          BlocProvider<CitiesCubit>(
            create: (context) =>
                CitiesCubit(context.read<CitiesRepo>())..fetchAllCities(),
          ),
          BlocProvider<PointsTransactionsCubit>(
            create: (context) =>
                PointsTransactionsCubit(context.read<PointsTransactionsRepo>()),
          ),
          BlocProvider<CreateDepositCubit>(
            create: (context) =>
                CreateDepositCubit(context.read<DepositRepo>()),
          ),
          BlocProvider<CreateWithdrawCubit>(
            create: (context) =>
                CreateWithdrawCubit(context.read<WithdrawRepo>()),
          ),
          BlocProvider<DepositHistoryCubit>(
            create: (context) =>
                DepositHistoryCubit(context.read<DepositRepo>()),
          ),
          BlocProvider<WithdrawHistoryCubit>(
            create: (context) =>
                WithdrawHistoryCubit(context.read<WithdrawRepo>()),
          ),
          BlocProvider<GetProfileCubit>(
            create: (context) =>
                GetProfileCubit(context.read<ProfileRepo>()),
          ),
          BlocProvider<UpdateProfileCubit>(
            create: (context) =>
                UpdateProfileCubit(context.read<ProfileRepo>()),
          ),
          BlocProvider<BookingsTransactionsCubit>(
            create: (context) =>
                BookingsTransactionsCubit(context.read<BookingRepo>()),
          ),
          BlocProvider<HotelRoomsFilterCubit>(
            create: (context) =>
                HotelRoomsFilterCubit(context.read<HotelsRepo>()),
          ),
          BlocProvider<RoomCategoryCubit>(
            create: (context) =>
                RoomCategoryCubit(context.read<RoomDetailsRepo>()),
          ),
        ],

        child: MaterialApp(
          navigatorKey: navigatorKey, // Attached global key here
          title: 'BYMA',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: activeTheme,
          // Defined routes for named navigation from interceptor
          routes: {'/login': (context) => const LoginScreen()},
          home: const SplashScreen(nextScreen: LoginScreen()),
        ),
      ),
    );
  }
}
