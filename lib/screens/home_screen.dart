// import 'package:byma_app/business_logic/add_hotel_to_collection/cubit/add_hotel_to_collection_cubit.dart';
// import 'package:byma_app/business_logic/add_hotel_to_collection/cubit/add_hotel_to_collection_state.dart';
// import 'package:byma_app/business_logic/add_recently_viewed_hotel/cubit/add_recently_viewed_hotel_cubit.dart';
// import 'package:byma_app/business_logic/collection/cubit/collection_cubit.dart';
// import 'package:byma_app/business_logic/collection/cubit/collection_state.dart';
// import 'package:byma_app/business_logic/create_collection/cubit/create_collection_cubit.dart';
// import 'package:byma_app/business_logic/create_collection/cubit/create_collection_state.dart';
// import 'package:byma_app/business_logic/hotels/cubit/hotels_cubit.dart';
// import 'package:byma_app/business_logic/hotels/cubit/hotels_state.dart';
// import 'package:byma_app/data/models/hotel_model.dart';
// import 'package:flutter/material.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'soon_splash_screen.dart';
// import 'notifications_screen.dart';
// import 'filters_advanced_screen.dart';
// import 'hotel_details_screen.dart';
// import '../constance/app_colors.dart';
// import '../widgets/byma_bottom_nav.dart';
// import 'bookings_screen.dart';
// import 'messages_final_navigation.dart';
// import 'main_layout_screen.dart';
// import 'settings_refined_screen.dart';
// import 'package:byma_app/widgets/home_widgets.dart';

// class HomeScreen extends StatelessWidget {
//   final ValueChanged<BymaBottomNavTab>? onTabChanged;

//   const HomeScreen({super.key, this.onTabChanged});

//   void _showAddToCollectionSheet(BuildContext context, int hotelId) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (sheetContext) {
//         return MultiBlocProvider(
//           providers: [
//             BlocProvider(
//               create: (context) => CollectionCubit(
//                 context.read(), // Or your DI container, e.g., getIt()
//               )..fetchAllCollections(),
//             ),
//             BlocProvider(
//               create: (context) => CreateCollectionCubit(context.read()),
//             ),
//             BlocProvider(
//               create: (context) => AddHotelToCollectionCubit(context.read()),
//             ),
//           ],
//           child: _AddToCollectionSheetBody(hotelId: hotelId),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;

//     final primaryColor = Theme.of(context).primaryColor;
//     final darkGreenColor = AppColors.kPrimaryColor;
//     final darkTextColor =
//         Theme.of(context).textTheme.bodyLarge?.color ?? AppColors.kTextColor;
//     final secondaryTextColor =
//         Theme.of(context).textTheme.bodySmall?.color ?? AppColors.kSubTextColor;
//     final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
//     final cardColor = Theme.of(context).cardColor;

//     return Scaffold(
//       backgroundColor: backgroundColor,
//       bottomNavigationBar: BymaBottomNav(
//         activeTab: BymaBottomNavTab.home,
//         onTabSelected: (tab) {
//           if (tab == BymaBottomNavTab.home) {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (_) => const MainLayoutScreen()),
//             );
//             return;
//           }
//           if (tab == BymaBottomNavTab.bookings) {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (_) => const BookingsScreen()),
//             );
//             return;
//           }
//           if (tab == BymaBottomNavTab.chat) {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (_) => const BymaChatScreen()),
//             );
//             return;
//           }
//           if (tab == BymaBottomNavTab.profile) {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (_) => const SettingsRefinedScreen()),
//             );
//           }
//         },
//       ),
//       body: SafeArea(
//         top: false,
//         child: CustomScrollView(
//           physics: const BouncingScrollPhysics(),
//           slivers: [
//             SliverAppBar(
//               floating: true,
//               pinned: false,
//               backgroundColor: backgroundColor,
//               elevation: 0,
//               automaticallyImplyLeading: false,
//               titleSpacing: 0,
//               toolbarHeight: 92,
//               title: _buildHeader(
//                 context,
//                 primaryColor,
//                 secondaryTextColor,
//                 darkTextColor,
//                 cardColor,
//                 isDarkMode,
//               ),
//             ),

//             SliverToBoxAdapter(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(height: 20),
//                     _buildCategoriesSection(
//                       context,
//                       darkGreenColor,
//                       primaryColor,
//                       secondaryTextColor,
//                     ),
//                     const SizedBox(height: 25),
//                     _buildSearchBar(
//                       context,
//                       darkGreenColor,
//                       secondaryTextColor,
//                       cardColor,
//                     ),
//                     const SizedBox(height: 25),
//                   ],
//                 ),
//               ),
//             ),

//             SliverPadding(
//               padding: const EdgeInsets.symmetric(horizontal: 20.0),
//               sliver: BlocBuilder<HotelCubit, HotelsState>(
//                 builder: (context, state) {
//                   return state.when(
//                     initial: () =>
//                         const SliverToBoxAdapter(child: SizedBox.shrink()),

//                     // Show a loading spinner while fetching data
//                     loading: () => const SliverToBoxAdapter(
//                       child: Center(
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(vertical: 40.0),
//                           child: CircularProgressIndicator(),
//                         ),
//                       ),
//                     ),

//                     // Build the list using real backend data
//                     success: (hotels) {
//                       if (hotels.isEmpty) {
//                         return SliverToBoxAdapter(
//                           child: Center(
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(
//                                 vertical: 40.0,
//                               ),
//                               child: Text(
//                                 context.tr('no_hotels_found') ??
//                                     'No hotels found',
//                                 style: TextStyle(color: secondaryTextColor),
//                               ),
//                             ),
//                           ),
//                         );
//                       }

//                       return SliverList(
//                         delegate: SliverChildBuilderDelegate((context, index) {
//                           final hotel = hotels[index];
//                           return _buildVerticalProductCard(
//                             context,
//                             hotel: hotel, // Pass the clean model directly
//                             titleColor: darkTextColor,
//                             subColor: secondaryTextColor,
//                           );
//                         }, childCount: hotels.length),
//                       );
//                     },

//                     error: (message) => SliverToBoxAdapter(
//                       child: Center(
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 40.0),
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Icon(
//                                 Icons.error_outline_rounded,
//                                 color: Colors.red.shade400,
//                                 size: 44,
//                               ),
//                               const SizedBox(height: 12),
//                               Text(
//                                 message,
//                                 style: const TextStyle(
//                                   color: Colors.red,
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                                 textAlign: TextAlign.center,
//                               ),
//                               const SizedBox(height: 16),
//                               ElevatedButton.icon(
//                                 onPressed: () {
//                                   // Call your HotelCubit fetch method here
//                                   context.read<HotelCubit>().fetchAllHotels();
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: darkGreenColor,
//                                   foregroundColor: Colors.white,
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 24,
//                                     vertical: 12,
//                                   ),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(25),
//                                   ),
//                                   elevation: 0,
//                                 ),
//                                 icon: const Icon(
//                                   Icons.refresh_rounded,
//                                   size: 20,
//                                 ),
//                                 label: Text(
//                                   context.tr('retry') ?? 'Retry',
//                                   style: const TextStyle(
//                                     fontWeight: FontWeight.w700,
//                                     fontSize: 14,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),

//             const SliverToBoxAdapter(child: SizedBox(height: 100)),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader(
//     BuildContext context,
//     Color primaryColor,
//     Color secondaryTextColor,
//     Color darkTextColor,
//     Color cardColor,
//     bool isDarkMode,
//   ) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//         decoration: BoxDecoration(
//           color: cardColor,
//           borderRadius: BorderRadius.circular(24),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(isDarkMode ? 0.2 : 0.06),
//               blurRadius: 14,
//               offset: const Offset(0, 6),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   'BYMA'.tr(),
//                   style: TextStyle(
//                     color: primaryColor,
//                     fontWeight: FontWeight.w900,
//                     fontSize: 24,
//                     letterSpacing: 1.1,
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   'find_your_next_stay'.tr(),
//                   style: TextStyle(
//                     color: secondaryTextColor,
//                     fontSize: 11,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//             const Spacer(),
//             GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => const NotificationsScreen(),
//                   ),
//                 );
//               },
//               child: Container(
//                 height: 40,
//                 width: 40,
//                 decoration: BoxDecoration(
//                   color: isDarkMode
//                       ? Colors.white.withOpacity(0.05)
//                       : const Color(0xFFF4F8F8),
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(
//                   Icons.notifications_none_outlined,
//                   color: darkTextColor,
//                   size: 20,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCategoriesSection(
//     BuildContext context,
//     Color activeColor,
//     Color inactiveIconColor,
//     Color textColor,
//   ) {
//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         GestureDetector(
//           onTap: () => Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (_) => SoonSplashScreen(
//                 title: 'CARS'.tr(),
//                 icon: Icons.directions_car_filled_outlined,
//               ),
//             ),
//           ),
//           child: _buildCategoryItem(
//             Icons.directions_car_filled_outlined,
//             'CARS'.tr(),
//             isDarkMode
//                 ? Colors.white.withOpacity(0.05)
//                 : const Color(0xFFEFF3F6),
//             inactiveIconColor.withOpacity(0.6),
//             textColor,
//           ),
//         ),
//         Column(
//           children: [
//             Container(
//               height: 75,
//               width: 75,
//               decoration: BoxDecoration(
//                 color: activeColor,
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(32),
//                   topRight: Radius.circular(40),
//                   bottomLeft: Radius.circular(42),
//                   bottomRight: Radius.circular(30),
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: activeColor.withOpacity(0.25),
//                     blurRadius: 15,
//                     offset: const Offset(0, 8),
//                   ),
//                 ],
//               ),
//               child: const Icon(
//                 Icons.king_bed_outlined,
//                 color: Colors.white,
//                 size: 26,
//               ),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               'HOTELS'.tr(),
//               style: TextStyle(
//                 fontSize: 11,
//                 fontWeight: FontWeight.w800,
//                 color: activeColor,
//                 letterSpacing: 0.5,
//               ),
//             ),
//           ],
//         ),
//         GestureDetector(
//           onTap: () => Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (_) => SoonSplashScreen(
//                 title: 'EATS'.tr(),
//                 icon: Icons.restaurant_outlined,
//               ),
//             ),
//           ),
//           child: _buildCategoryItem(
//             Icons.restaurant_outlined,
//             'EATS'.tr(),
//             isDarkMode
//                 ? Colors.white.withOpacity(0.05)
//                 : const Color(0xFFFFF9F2),
//             const Color(0xFFFFB057),
//             textColor,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildSearchBar(
//     BuildContext context,
//     Color filterBgColor,
//     Color textColor,
//     Color cardColor,
//   ) {
//     return Row(
//       children: [
//         Expanded(
//           child: Container(
//             height: 55,
//             decoration: BoxDecoration(
//               color: cardColor,
//               borderRadius: BorderRadius.circular(30),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.02),
//                   blurRadius: 12,
//                   offset: const Offset(0, 5),
//                 ),
//               ],
//             ),
//             child: TextField(
//               decoration: InputDecoration(
//                 hintText: 'search_hotels_hint'.tr(),
//                 hintStyle: TextStyle(
//                   color: textColor.withOpacity(0.5),
//                   fontSize: 15,
//                   fontWeight: FontWeight.w500,
//                 ),
//                 prefixIcon: Padding(
//                   padding: const EdgeInsets.only(left: 12.0, right: 8.0),
//                   child: Icon(
//                     Icons.search,
//                     color: textColor.withOpacity(0.7),
//                     size: 22,
//                   ),
//                 ),
//                 border: InputBorder.none,
//                 contentPadding: const EdgeInsets.symmetric(vertical: 16),
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(width: 12),
//         GestureDetector(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (_) => const FiltersAdvancedScreen()),
//             );
//           },
//           child: Container(
//             height: 55,
//             width: 55,
//             decoration: BoxDecoration(
//               color: filterBgColor,
//               shape: BoxShape.circle,
//             ),
//             child: const Icon(Icons.tune, color: Colors.white, size: 22),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildCategoryItem(
//     IconData icon,
//     String label,
//     Color bgColor,
//     Color iconColor,
//     Color textColor,
//   ) {
//     return Column(
//       children: [
//         Container(
//           height: 75,
//           width: 75,
//           decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
//           child: Icon(icon, color: iconColor, size: 26),
//         ),
//         const SizedBox(height: 10),
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 11,
//             fontWeight: FontWeight.w700,
//             color: textColor.withOpacity(0.6),
//             letterSpacing: 0.5,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildVerticalProductCard(
//     BuildContext context, {
//     required HotelModel hotel,
//     required Color titleColor,
//     required Color subColor,
//   }) {
//     return HotelProductCard(
//       hotel: hotel,
//       titleColor: titleColor,
//       subColor: subColor,
//       onAddClick: () {
//         _showAddToCollectionSheet(context, hotel.id);
//       },
//       onTap: () {
//         if (hotel.id != 0) {
//           context.read<AddRecentlyViewedHotelsCubit>().addRecentlyViewed(
//             hotel.id,
//           );
//         }
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (_) => HotelDetailsScreen(
//               hotelId: hotel.id,
//               fallbackTitle: hotel.name,
//               fallbackImageUrl: hotel.imageUrls.isNotEmpty
//                   ? hotel.imageUrls.first
//                   : "",
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class _AddToCollectionSheetBody extends StatelessWidget {
//   final int hotelId;

//   void _showTopSnackBar(
//     BuildContext context,
//     String message,
//     Color backgroundColor,
//   ) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final topMargin =
//         screenHeight - 150; // Adjusts how high from the bottom it sits

//     ScaffoldMessenger.of(context).removeCurrentSnackBar();
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           message,
//           style: const TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         backgroundColor: backgroundColor,
//         behavior: SnackBarBehavior.floating,
//         dismissDirection: DismissDirection.up,
//         margin: EdgeInsets.only(bottom: topMargin, left: 20, right: 20),
//         duration: const Duration(seconds: 2),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       ),
//     );
//   }

//   const _AddToCollectionSheetBody({Key? key, required this.hotelId})
//     : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;
//     final backgroundColor = isDarkMode ? const Color(0xFF1E1E1E) : Colors.white;
//     final textColor = isDarkMode ? Colors.white : const Color(0xFF0F4A42);

//     return MultiBlocListener(
//       listeners: [
//         // Listen for adding a hotel to a collection
//         BlocListener<AddHotelToCollectionCubit, AddHotelToCollectionState>(
//           listener: (context, state) {
//             state.whenOrNull(
//               success: () {
//                 Navigator.pop(context);
//                 _showTopSnackBar(context, 'Saved to collection!', Colors.green);
//               },
//               error: (message) {
//                 _showTopSnackBar(context, message, Colors.red);
//               },
//             );
//           },
//         ),
//         // Listen for new collection creation to refresh the list
//         BlocListener<CreateCollectionCubit, CreateCollectionState>(
//           listener: (context, state) {
//             state.whenOrNull(
//               success: () {
//                 context.read<CollectionCubit>().fetchAllCollections();
//                 _showTopSnackBar(
//                   context,
//                   'Collection created successfully!',
//                   Colors.green,
//                 );
//               },
//               error: (message) {
//                 _showTopSnackBar(context, message, Colors.red);
//               },
//             );
//           },
//         ),
//       ],
//       child: Container(
//         height: MediaQuery.of(context).size.height * 0.55,
//         decoration: BoxDecoration(
//           color: backgroundColor,
//           borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Sheet Handle
//             Center(
//               child: Container(
//                 width: 40,
//                 height: 4,
//                 decoration: BoxDecoration(
//                   color: Colors.grey.withOpacity(0.4),
//                   borderRadius: BorderRadius.circular(2),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//             // Header Title & Create Button
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Save to collection',
//                   style: TextStyle(
//                     color: textColor,
//                     fontSize: 18,
//                     fontWeight: FontWeight.w800,
//                   ),
//                 ),
//                 TextButton.icon(
//                   onPressed: () => _showCreateCollectionDialog(context),
//                   icon: const Icon(Icons.add, size: 18),
//                   label: const Text(
//                     'Create Collection',
//                     style: TextStyle(fontWeight: FontWeight.w700),
//                   ),
//                 ),
//               ],
//             ),
//             const Divider(height: 24),
//             // Collections List
//             Expanded(
//               child: BlocBuilder<CollectionCubit, CollectionState>(
//                 builder: (context, state) {
//                   return state.when(
//                     initial: () => const SizedBox.shrink(),
//                     loading: () =>
//                         const Center(child: CircularProgressIndicator()),
//                     error: (message) => Center(
//                       child: Text(
//                         message,
//                         style: const TextStyle(color: Colors.red),
//                       ),
//                     ),
//                     success: (collections) {
//                       if (collections.isEmpty) {
//                         return Center(
//                           child: Text(
//                             'No collections yet. Create one now!',
//                             style: TextStyle(
//                               color: textColor.withOpacity(0.6),
//                               fontSize: 14,
//                             ),
//                           ),
//                         );
//                       }

//                       return ListView.separated(
//                         itemCount: collections.length,
//                         separatorBuilder: (_, __) => const SizedBox(height: 10),
//                         itemBuilder: (context, index) {
//                           final collectionItem = collections[index];
//                           return ListTile(
//                             contentPadding: EdgeInsets.zero,
//                             leading: Container(
//                               width: 48,
//                               height: 48,
//                               decoration: BoxDecoration(
//                                 color: textColor.withOpacity(0.1),
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               child: Icon(
//                                 Icons.bookmark_border_rounded,
//                                 color: textColor,
//                               ),
//                             ),
//                             title: Text(
//                               collectionItem
//                                   .name, // Change to your model property
//                               style: TextStyle(
//                                 color: textColor,
//                                 fontWeight: FontWeight.w700,
//                                 fontSize: 16,
//                               ),
//                             ),
//                             trailing:
//                                 BlocBuilder<
//                                   AddHotelToCollectionCubit,
//                                   AddHotelToCollectionState
//                                 >(
//                                   builder: (context, addState) {
//                                     final isLoading = addState.maybeWhen(
//                                       loading: () => true,
//                                       orElse: () => false,
//                                     );
//                                     return isLoading
//                                         ? const SizedBox(
//                                             width: 20,
//                                             height: 20,

//                                             child: CircularProgressIndicator(
//                                               strokeWidth: 2,
//                                             ),
//                                           )
//                                         : Icon(
//                                             Icons.chevron_right_rounded,
//                                             color: textColor.withOpacity(0.5),
//                                           );
//                                   },
//                                 ),
//                             onTap: () {
//                               context
//                                   .read<AddHotelToCollectionCubit>()
//                                   .addHotelToCollection(
//                                     collectionItem
//                                         .id, // Change to your model ID
//                                     hotelId,
//                                   );
//                             },
//                           );
//                         },
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showCreateCollectionDialog(BuildContext parentContext) {
//     final textController = TextEditingController();

//     showDialog(
//       context: parentContext,
//       builder: (dialogContext) {
//         return AlertDialog(
//           title: const Text('New Collection'),
//           content: TextField(
//             controller: textController,
//             autofocus: true,
//             decoration: const InputDecoration(
//               // hintText: 'Collection name (e.g., Summer Trip)',
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(dialogContext),
//               child: const Text('Cancel'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 final name = textController.text.trim();
//                 if (name.isNotEmpty) {
//                   // Trigger create collection on the parent context's Cubit
//                   parentContext.read<CreateCollectionCubit>().createCollection(
//                     name,
//                   );
//                   Navigator.pop(dialogContext);
//                 }
//               },
//               child: const Text('Create'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:byma_app/business_logic/add_recently_viewed_hotel/cubit/add_recently_viewed_hotel_cubit.dart';
import 'package:byma_app/business_logic/hotels/cubit/hotels_cubit.dart';
import 'package:byma_app/business_logic/hotels/cubit/hotels_state.dart';
import 'package:byma_app/data/models/hotel_model.dart';
import 'package:byma_app/widgets/home_widgets.dart';

import '../constance/app_colors.dart';
import '../widgets/byma_bottom_nav.dart';
import 'bookings_screen.dart';
import 'hotel_details_screen.dart';
import 'messages_final_navigation.dart';
import 'main_layout_screen.dart';
import 'settings_refined_screen.dart';

class HomeScreen extends StatelessWidget {
  final ValueChanged<BymaBottomNavTab>? onTabChanged;

  const HomeScreen({super.key, this.onTabChanged});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final primaryColor = Theme.of(context).primaryColor;
    final darkGreenColor = AppColors.kPrimaryColor;
    final darkTextColor =
        Theme.of(context).textTheme.bodyLarge?.color ?? AppColors.kTextColor;
    final secondaryTextColor =
        Theme.of(context).textTheme.bodySmall?.color ?? AppColors.kSubTextColor;
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final cardColor = Theme.of(context).cardColor;

    return Scaffold(
      backgroundColor: backgroundColor,
      bottomNavigationBar: BymaBottomNav(
        activeTab: BymaBottomNavTab.home,
        onTabSelected: (tab) {
          if (tab == BymaBottomNavTab.home) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const MainLayoutScreen()),
            );
            return;
          }
          if (tab == BymaBottomNavTab.bookings) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const BookingsScreen()),
            );
            return;
          }
          if (tab == BymaBottomNavTab.chat) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const BymaChatScreen()),
            );
            return;
          }
          if (tab == BymaBottomNavTab.profile) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const SettingsRefinedScreen()),
            );
          }
        },
      ),
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              floating: true,
              pinned: false,
              backgroundColor: backgroundColor,
              elevation: 0,
              automaticallyImplyLeading: false,
              titleSpacing: 0,
              toolbarHeight: 92,
              title: HomeHeader(
                primaryColor: primaryColor,
                secondaryTextColor: secondaryTextColor,
                darkTextColor: darkTextColor,
                cardColor: cardColor,
                isDarkMode: isDarkMode,
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    HomeCategoriesSection(
                      activeColor: darkGreenColor,
                      inactiveIconColor: primaryColor,
                      textColor: secondaryTextColor,
                    ),
                    const SizedBox(height: 25),
                    HomeSearchBar(
                      filterBgColor: darkGreenColor,
                      textColor: secondaryTextColor,
                      cardColor: cardColor,
                    ),
                    const SizedBox(height: 25),
                  ],
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              sliver: BlocBuilder<HotelCubit, HotelsState>(
                builder: (context, state) {
                  return state.when(
                    initial: () =>
                        const SliverToBoxAdapter(child: SizedBox.shrink()),

                    loading: () => const SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 40.0),
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),

                    success: (hotels) {
                      if (hotels.isEmpty) {
                        return SliverToBoxAdapter(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 40.0,
                              ),
                              child: Text(
                                context.tr('no_hotels_found') ??
                                    'No hotels found',
                                style: TextStyle(color: secondaryTextColor),
                              ),
                            ),
                          ),
                        );
                      }

                      return SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final hotel = hotels[index];
                          return _buildVerticalProductCard(
                            context,
                            hotel: hotel,
                            titleColor: darkTextColor,
                            subColor: secondaryTextColor,
                          );
                        }, childCount: hotels.length),
                      );
                    },

                    error: (message) => SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.error_outline_rounded,
                                color: Colors.red.shade400,
                                size: 44,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                message,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton.icon(
                                onPressed: () {
                                  context.read<HotelCubit>().fetchAllHotels();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: darkGreenColor,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  elevation: 0,
                                ),
                                icon: const Icon(
                                  Icons.refresh_rounded,
                                  size: 20,
                                ),
                                label: Text(
                                  context.tr('retry') ?? 'Retry',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }

  Widget _buildVerticalProductCard(
    BuildContext context, {
    required HotelModel hotel,
    required Color titleColor,
    required Color subColor,
  }) {
    return HotelProductCard(
      hotel: hotel,
      titleColor: titleColor,
      subColor: subColor,
      onAddClick: () {
        showAddToCollectionSheet(context, hotel.id);
      },
      onTap: () {
        if (hotel.id != 0) {
          context.read<AddRecentlyViewedHotelsCubit>().addRecentlyViewed(
            hotel.id,
          );
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => HotelDetailsScreen(hotelId: hotel.id),
          ),
        );
      },
    );
  }
}
