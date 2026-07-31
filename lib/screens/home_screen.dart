// import 'dart:async'; // 🌟 مطلوب للمؤقت الزمني للصور
// import 'package:byma_app/business_logic/favorite_hotels/cubit/favorite_hotels_cubit.dart';
// import 'package:byma_app/business_logic/favorite_hotels/cubit/favorite_hotels_state.dart';
// import 'package:byma_app/business_logic/hotels/cubit/hotels_cubit.dart';
// import 'package:byma_app/business_logic/hotels/cubit/hotels_state.dart';
// import 'package:byma_app/business_logic/toggle_favorite_hotels/cubit/toggle_favorite_hotels_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter_bloc/flutter_bloc.dart'; // 🌟 مطلوب للـ BlocBuilder

// // استدعاء الشاشات والملفات المرتبطة في مشروعك
// import 'soon_splash_screen.dart';
// import 'notifications_screen.dart';
// import 'filters_advanced_screen.dart';
// import 'hotel_details_screen.dart';
// import 'recently_viewed.dart';
// import 'collection.dart'; // يحتوي على CollectionModel و CollectionItem و globalCollections

// import '../constance/app_colors.dart';
// import '../widgets/byma_bottom_nav.dart';
// import 'bookings_screen.dart';
// import 'messages_final_navigation.dart';
// import 'main_layout_screen.dart';
// import 'settings_refined_screen.dart';

// class HomeScreen extends StatelessWidget {
//   final ValueChanged<BymaBottomNavTab>? onTabChanged;

//   const HomeScreen({super.key, this.onTabChanged});

//   // دالة منبثقة لإظهار المجموعات للمسخدم
//   void _showAddToCollectionSheet(
//     BuildContext context, {
//     required String hotelTitle,
//     required String imageUrl,
//   }) {
//     final theme = Theme.of(context);
//     final TextEditingController newCollectionController =
//         TextEditingController();

//     showModalBottomSheet(
//       context: context,
//       backgroundColor: theme.cardColor,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//       ),
//       builder: (context) {
//         return StatefulBuilder(
//           builder: (context, setModalState) {
//             return Padding(
//               padding: EdgeInsets.only(
//                 top: 20,
//                 left: 20,
//                 right: 20,
//                 bottom: MediaQuery.of(context).viewInsets.bottom + 20,
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     context.tr('save_to_collection_sheet_title'),
//                     style: TextStyle(
//                       color: theme.colorScheme.secondary,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 15),

//                   Row(
//                     children: [
//                       Expanded(
//                         child: TextField(
//                           controller: newCollectionController,
//                           decoration: InputDecoration(
//                             hintText: 'اسم المجموعة الجديدة...',
//                             hintStyle: TextStyle(
//                               color: theme.colorScheme.tertiary.withOpacity(
//                                 0.6,
//                               ),
//                               fontSize: 14,
//                             ),
//                             contentPadding: const EdgeInsets.symmetric(
//                               horizontal: 16,
//                               vertical: 12,
//                             ),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                               borderSide: BorderSide(
//                                 color: theme.colorScheme.tertiary.withOpacity(
//                                   0.3,
//                                 ),
//                               ),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                               borderSide: BorderSide(
//                                 color: theme.colorScheme.tertiary.withOpacity(
//                                   0.3,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 10),
//                       ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: theme.primaryColor,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           padding: const EdgeInsets.symmetric(
//                             vertical: 14,
//                             horizontal: 16,
//                           ),
//                         ),
//                         onPressed: () {
//                           final name = newCollectionController.text.trim();
//                           if (name.isNotEmpty) {
//                             setModalState(() {
//                               final newCol = CollectionModel(
//                                 id: DateTime.now().millisecondsSinceEpoch
//                                     .toString(),
//                                 name: name,
//                                 items: List<CollectionItem>.from([]),
//                               );

//                               newCol.items.add(
//                                 CollectionItem(
//                                   id: hotelTitle,
//                                   nameEn: hotelTitle,
//                                   nameAr: hotelTitle,
//                                   imageUrl: imageUrl,
//                                   type: CollectionItemType.hotel,
//                                 ),
//                               );

//                               globalCollections.add(newCol);
//                               newCollectionController.clear();
//                               FocusScope.of(context).unfocus();
//                             });

//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 content: Text(
//                                   'تم إنشاء مجموعة "$name" وحفظ الفندق فيها',
//                                 ),
//                               ),
//                             );
//                           }
//                         },
//                         child: const Icon(Icons.add, color: Colors.white),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   const Divider(),
//                   const SizedBox(height: 10),

//                   if (globalCollections.isEmpty)
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 20),
//                       child: Center(
//                         child: Text(
//                           context.tr('no_collections'),
//                           style: TextStyle(color: theme.colorScheme.tertiary),
//                         ),
//                       ),
//                     )
//                   else
//                     Flexible(
//                       child: ListView.builder(
//                         shrinkWrap: true,
//                         itemCount: globalCollections.length,
//                         itemBuilder: (context, index) {
//                           final collection = globalCollections[index];
//                           final isAdded = collection.items.any(
//                             (item) => item.id == hotelTitle,
//                           );

//                           return ListTile(
//                             contentPadding: EdgeInsets.zero,
//                             leading: Icon(
//                               isAdded
//                                   ? Icons.folder_special
//                                   : Icons.folder_special_outlined,
//                               color: theme.colorScheme.primary,
//                             ),
//                             title: Text(
//                               collection.name,
//                               style: TextStyle(
//                                 color: theme.colorScheme.secondary,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                             trailing: Icon(
//                               isAdded
//                                   ? Icons.check_circle
//                                   : Icons.add_circle_outline,
//                               color: isAdded
//                                   ? Colors.green
//                                   : theme.colorScheme.tertiary,
//                             ),
//                             onTap: () {
//                               setModalState(() {
//                                 if (!isAdded) {
//                                   collection.items.add(
//                                     CollectionItem(
//                                       id: hotelTitle,
//                                       nameEn: hotelTitle,
//                                       nameAr: hotelTitle,
//                                       imageUrl: imageUrl,
//                                       type: CollectionItemType.hotel,
//                                     ),
//                                   );
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     SnackBar(
//                                       content: Text(
//                                         '${context.tr('added_to')} ${collection.name}',
//                                       ),
//                                     ),
//                                   );
//                                 } else {
//                                   collection.items.removeWhere(
//                                     (item) => item.id == hotelTitle,
//                                   );
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     SnackBar(
//                                       content: Text(
//                                         '${context.tr('removed_from')} ${collection.name}',
//                                       ),
//                                     ),
//                                   );
//                                 }
//                               });
//                             },
//                           );
//                         },
//                       ),
//                     ),
//                 ],
//               ),
//             );
//           },
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

//             // 🌟 Replace your existing SliverPadding with this BlocBuilder block
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
//                             id: hotel.id
//                                 .toString(), // Convert backend int ID to String
//                             title: hotel.name, // Real name from DB
//                             location:
//                                 hotel.address, // Real city/address from DB
//                             imageUrls:
//                                 hotel.imageUrls, // Cleaned URLs from HotelModel
//                             rating: hotel.rating
//                                 .toString(), // Real rating from DB
//                             titleColor: darkTextColor,
//                             subColor: secondaryTextColor,
//                           );
//                         }, childCount: hotels.length),
//                       );
//                     },

//                     // Show error message if API fails
//                     error: (message) => SliverToBoxAdapter(
//                       child: Center(
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 40.0),
//                           child: Text(
//                             message,
//                             style: const TextStyle(color: Colors.red),
//                             textAlign: TextAlign.center,
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

//   // 🌟 تم إضافة `required String id` هنا وتم تعديل الـ Navigation بالـ BlocProvider
//   Widget _buildVerticalProductCard(
//     BuildContext context, {
//     required String id,
//     required String title,
//     required String location,
//     required List<String> imageUrls,
//     required String rating,
//     required Color titleColor,
//     required Color subColor,
//   }) {
//     return HotelProductCard(
//       id: id,
//       title: title,
//       location: location,
//       imageUrls: imageUrls,
//       rating: rating,
//       titleColor: titleColor,
//       subColor: subColor,
//       onAddClick: () => _showAddToCollectionSheet(
//         context,
//         hotelTitle: title,
//         imageUrl: imageUrls.isNotEmpty ? imageUrls.first : "",
//       ),
//       onTap: () {
//         addRecentlyViewedItem(
//           RecentlyViewedItem(
//             id: id,
//             nameEn: title,
//             nameAr: title,
//             locationEn: location,
//             locationAr: location,
//             imageUrl: imageUrls.isNotEmpty ? imageUrls.first : "",
//             price: 150.0,
//             type: RecentlyItemType.hotel,
//           ),
//         );

//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (_) => HotelDetailsScreen(
//               hotelId: int.tryParse(id) ?? 0,
//               fallbackTitle: title,
//               fallbackImageUrl: imageUrls.isNotEmpty ? imageUrls.first : "",
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// // الـ Widget المستقل لعرض صور متعددة بشكل متحرك تلقائياً كل 3 ثوانٍ
// class HotelProductCard extends StatefulWidget {
//   final String id;
//   final String title;
//   final String location;
//   final List<String> imageUrls;
//   final String rating;
//   final Color titleColor;
//   final Color subColor;
//   final VoidCallback onTap;
//   final VoidCallback onAddClick;

//   const HotelProductCard({
//     super.key,
//     required this.id,
//     required this.title,
//     required this.location,
//     required this.imageUrls,
//     required this.rating,
//     required this.titleColor,
//     required this.subColor,
//     required this.onTap,
//     required this.onAddClick,
//   });

//   @override
//   State<HotelProductCard> createState() => _HotelProductCardState();
// }

// class _HotelProductCardState extends State<HotelProductCard> {
//   late PageController _pageController;
//   Timer? _timer;
//   int _currentPage = 0;

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(initialPage: 0);

//     if (widget.imageUrls.length > 1) {
//       _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
//         if (_currentPage < widget.imageUrls.length - 1) {
//           _currentPage++;
//         } else {
//           _currentPage = 0;
//         }

//         if (_pageController.hasClients) {
//           _pageController.animateToPage(
//             _currentPage,
//             duration: const Duration(milliseconds: 800),
//             curve: Curves.easeInOutCubic,
//           );
//         }
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;

//     return GestureDetector(
//       onTap: widget.onTap,
//       child: Container(
//         width: double.infinity,
//         margin: const EdgeInsets.only(top: 10, bottom: 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Stack(
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(35),
//                   child: SizedBox(
//                     height: 220,
//                     width: double.infinity,
//                     child: PageView.builder(
//                       controller: _pageController,
//                       itemCount: widget.imageUrls.length,
//                       onPageChanged: (index) {
//                         _currentPage = index;
//                       },
//                       itemBuilder: (context, index) {
//                         final imageUrl = widget.imageUrls[index];
//                         final isAsset = imageUrl.startsWith('assets/');

//                         return Container(
//                           color: isDarkMode
//                               ? Colors.white.withOpacity(0.05)
//                               : const Color(0xFFE2E8F0),
//                           child: isAsset
//                               ? Image.asset(imageUrl, fit: BoxFit.cover)
//                               : Image.network(
//                                   imageUrl,
//                                   fit: BoxFit.cover,
//                                   errorBuilder: (context, error, stackTrace) {
//                                     return Image.asset(
//                                       'assets/images/hotel-placeholder.jpg',
//                                       fit: BoxFit.cover,
//                                     );
//                                   },
//                                 ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),

//                 Positioned(
//                   top: 15,
//                   right: 15,
//                   child: Row(
//                     children: [
//                       GestureDetector(
//                         onTap: widget.onAddClick,
//                         child: Container(
//                           padding: const EdgeInsets.all(8),
//                           margin: const EdgeInsets.only(right: 8),
//                           decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(
//                               isDarkMode ? 0.2 : 0.75,
//                             ),
//                             shape: BoxShape.circle,
//                           ),
//                           child: Icon(
//                             Icons.add,
//                             color: isDarkMode
//                                 ? Colors.white
//                                 : const Color(0xFF0F4A42),
//                             size: 20,
//                           ),
//                         ),
//                       ),

//                       BlocBuilder<FavoriteHotelsCubit, FavoriteHotelsState>(
//                         builder: (context, state) {
//                           bool isFav = false;
//                           int? favoriteRecordId;

//                           // 1. Safely check the state to see if this hotel is in the favorites list
//                           state.when(
//                             initial: () {},
//                             loading: () {},
//                             error: (message) {},
//                             success: (favoriteHotels) {
//                               for (var fav in favoriteHotels) {
//                                 if (fav.hotel.id.toString() == widget.id) {
//                                   isFav = true;
//                                   favoriteRecordId = fav.id; // We need this specific ID to delete it later!
//                                   break;
//                                 }
//                               }
//                             },
//                           );

//                           return InkWell(
//                             onTap: () async {
//                               final hotelIdInt = int.tryParse(widget.id) ?? 0;

//                               if (isFav && favoriteRecordId != null) {
//                                 // --- REMOVE FAVORITE ---
//                                 // 1. Remove instantly from UI state (Optimistic Update)
//                                 context
//                                     .read<FavoriteHotelsCubit>()
//                                     .removeHotelOptimistically(favoriteRecordId!);

//                                 // 2. Send delete request to backend using the specific favoriteRecordId
//                                 context
//                                     .read<ToggleFavoriteHotelsCubit>()
//                                     .removeFavorite(favoriteRecordId!);
//                               } else {
//                                 // --- ADD FAVORITE ---
//                                 // 1. Await the add request to finish
//                                await context
//                                     .read<ToggleFavoriteHotelsCubit>()
//                                     .addFavorite(hotelIdInt);

//                                 // 2. Fetch the new list ONLY AFTER the add is done
//                                 context
//                                     .read<FavoriteHotelsCubit>()
//                                     .getFavoriteHotels();
//                               }
//                             },
//                             child: Container(
//                               padding: const EdgeInsets.all(8),
//                               decoration: BoxDecoration(
//                                 color: Colors.white.withOpacity(
//                                   isDarkMode ? 0.2 : 0.75,
//                                 ),
//                                 shape: BoxShape.circle,
//                               ),
//                               child: Icon(
//                                 isFav
//                                     ? Icons.favorite_rounded
//                                     : Icons.favorite_border,
//                                 color: isFav
//                                     ? const Color(0xFF0FA37A)
//                                     : (isDarkMode
//                                         ? Colors.white
//                                         : const Color(0xFF0F4A42)),
//                                 size: 20,
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 14),

//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   widget.title,
//                   style: TextStyle(
//                     fontSize: 19,
//                     fontWeight: FontWeight.w900,
//                     color: widget.titleColor,
//                     letterSpacing: -0.2,
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     const Icon(Icons.star, color: Colors.amber, size: 18),
//                     const SizedBox(width: 4),
//                     Text(
//                       widget.rating,
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w800,
//                         color: widget.titleColor,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             const SizedBox(height: 4),
//             Text(
//               widget.location,
//               style: TextStyle(
//                 fontSize: 13,
//                 color: widget.subColor,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:async'; // 🌟 مطلوب للمؤقت الزمني للصور
import 'package:byma_app/business_logic/favorite_hotels/cubit/favorite_hotels_cubit.dart';
import 'package:byma_app/business_logic/favorite_hotels/cubit/favorite_hotels_state.dart';
import 'package:byma_app/business_logic/hotels/cubit/hotels_cubit.dart';
import 'package:byma_app/business_logic/hotels/cubit/hotels_state.dart';
import 'package:byma_app/business_logic/toggle_favorite_hotels/cubit/toggle_favorite_hotels_cubit.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // 🌟 مطلوب للـ BlocBuilder

// استدعاء الشاشات والملفات المرتبطة في مشروعك
import 'soon_splash_screen.dart';
import 'notifications_screen.dart';
import 'filters_advanced_screen.dart';
import 'hotel_details_screen.dart';
import 'recently_viewed.dart';
import 'collection.dart'; // يحتوي على CollectionModel و CollectionItem و globalCollections

import '../constance/app_colors.dart';
import '../widgets/byma_bottom_nav.dart';
import 'bookings_screen.dart';
import 'messages_final_navigation.dart';
import 'main_layout_screen.dart';
import 'settings_refined_screen.dart';

class HomeScreen extends StatelessWidget {
  final ValueChanged<BymaBottomNavTab>? onTabChanged;

  const HomeScreen({super.key, this.onTabChanged});

  // دالة منبثقة لإظهار المجموعات للمسخدم
  void _showAddToCollectionSheet(
    BuildContext context, {
    required String hotelTitle,
    required String imageUrl,
  }) {
    final theme = Theme.of(context);
    final TextEditingController newCollectionController =
        TextEditingController();

    showModalBottomSheet(
      context: context,
      backgroundColor: theme.cardColor,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.tr('save_to_collection_sheet_title'),
                    style: TextStyle(
                      color: theme.colorScheme.secondary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),

                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: newCollectionController,
                          decoration: InputDecoration(
                            hintText: 'اسم المجموعة الجديدة...',
                            hintStyle: TextStyle(
                              color: theme.colorScheme.tertiary.withOpacity(
                                0.6,
                              ),
                              fontSize: 14,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: theme.colorScheme.tertiary.withOpacity(
                                  0.3,
                                ),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: theme.colorScheme.tertiary.withOpacity(
                                  0.3,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 16,
                          ),
                        ),
                        onPressed: () {
                          final name = newCollectionController.text.trim();
                          if (name.isNotEmpty) {
                            setModalState(() {
                              final newCol = CollectionModel(
                                id: DateTime.now().millisecondsSinceEpoch
                                    .toString(),
                                name: name,
                                items: List<CollectionItem>.from([]),
                              );

                              newCol.items.add(
                                CollectionItem(
                                  id: hotelTitle,
                                  nameEn: hotelTitle,
                                  nameAr: hotelTitle,
                                  imageUrl: imageUrl,
                                  type: CollectionItemType.hotel,
                                ),
                              );

                              globalCollections.add(newCol);
                              newCollectionController.clear();
                              FocusScope.of(context).unfocus();
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'تم إنشاء مجموعة "$name" وحفظ الفندق فيها',
                                ),
                              ),
                            );
                          }
                        },
                        child: const Icon(Icons.add, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 10),

                  if (globalCollections.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: Text(
                          context.tr('no_collections'),
                          style: TextStyle(color: theme.colorScheme.tertiary),
                        ),
                      ),
                    )
                  else
                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: globalCollections.length,
                        itemBuilder: (context, index) {
                          final collection = globalCollections[index];
                          final isAdded = collection.items.any(
                            (item) => item.id == hotelTitle,
                          );

                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(
                              isAdded
                                  ? Icons.folder_special
                                  : Icons.folder_special_outlined,
                              color: theme.colorScheme.primary,
                            ),
                            title: Text(
                              collection.name,
                              style: TextStyle(
                                color: theme.colorScheme.secondary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            trailing: Icon(
                              isAdded
                                  ? Icons.check_circle
                                  : Icons.add_circle_outline,
                              color: isAdded
                                  ? Colors.green
                                  : theme.colorScheme.tertiary,
                            ),
                            onTap: () {
                              setModalState(() {
                                if (!isAdded) {
                                  collection.items.add(
                                    CollectionItem(
                                      id: hotelTitle,
                                      nameEn: hotelTitle,
                                      nameAr: hotelTitle,
                                      imageUrl: imageUrl,
                                      type: CollectionItemType.hotel,
                                    ),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        '${context.tr('added_to')} ${collection.name}',
                                      ),
                                    ),
                                  );
                                } else {
                                  collection.items.removeWhere(
                                    (item) => item.id == hotelTitle,
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        '${context.tr('removed_from')} ${collection.name}',
                                      ),
                                    ),
                                  );
                                }
                              });
                            },
                          );
                        },
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }

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
              title: _buildHeader(
                context,
                primaryColor,
                secondaryTextColor,
                darkTextColor,
                cardColor,
                isDarkMode,
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    _buildCategoriesSection(
                      context,
                      darkGreenColor,
                      primaryColor,
                      secondaryTextColor,
                    ),
                    const SizedBox(height: 25),
                    _buildSearchBar(
                      context,
                      darkGreenColor,
                      secondaryTextColor,
                      cardColor,
                    ),
                    const SizedBox(height: 25),
                  ],
                ),
              ),
            ),

            // 🌟 Replace your existing SliverPadding with this BlocBuilder block
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              sliver: BlocBuilder<HotelCubit, HotelsState>(
                builder: (context, state) {
                  return state.when(
                    initial: () =>
                        const SliverToBoxAdapter(child: SizedBox.shrink()),

                    // Show a loading spinner while fetching data
                    loading: () => const SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 40.0),
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),

                    // Build the list using real backend data
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
                            id: hotel.id
                                .toString(), // Convert backend int ID to String
                            title: hotel.name, // Real name from DB
                            location:
                                hotel.address, // Real city/address from DB
                            imageUrls:
                                hotel.imageUrls, // Cleaned URLs from HotelModel
                            rating: hotel.rating
                                .toString(), // Real rating from DB
                            titleColor: darkTextColor,
                            subColor: secondaryTextColor,
                          );
                        }, childCount: hotels.length),
                      );
                    },

                    // Show error message if API fails
                    error: (message) => SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40.0),
                          child: Text(
                            message,
                            style: const TextStyle(color: Colors.red),
                            textAlign: TextAlign.center,
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

  Widget _buildHeader(
    BuildContext context,
    Color primaryColor,
    Color secondaryTextColor,
    Color darkTextColor,
    Color cardColor,
    bool isDarkMode,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDarkMode ? 0.2 : 0.06),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'BYMA'.tr(),
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w900,
                    fontSize: 24,
                    letterSpacing: 1.1,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'find_your_next_stay'.tr(),
                  style: TextStyle(
                    color: secondaryTextColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const NotificationsScreen(),
                  ),
                );
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? Colors.white.withOpacity(0.05)
                      : const Color(0xFFF4F8F8),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.notifications_none_outlined,
                  color: darkTextColor,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesSection(
    BuildContext context,
    Color activeColor,
    Color inactiveIconColor,
    Color textColor,
  ) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SoonSplashScreen(
                title: 'CARS'.tr(),
                icon: Icons.directions_car_filled_outlined,
              ),
            ),
          ),
          child: _buildCategoryItem(
            Icons.directions_car_filled_outlined,
            'CARS'.tr(),
            isDarkMode
                ? Colors.white.withOpacity(0.05)
                : const Color(0xFFEFF3F6),
            inactiveIconColor.withOpacity(0.6),
            textColor,
          ),
        ),
        Column(
          children: [
            Container(
              height: 75,
              width: 75,
              decoration: BoxDecoration(
                color: activeColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(40),
                  bottomLeft: Radius.circular(42),
                  bottomRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: activeColor.withOpacity(0.25),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Icon(
                Icons.king_bed_outlined,
                color: Colors.white,
                size: 26,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'HOTELS'.tr(),
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: activeColor,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SoonSplashScreen(
                title: 'EATS'.tr(),
                icon: Icons.restaurant_outlined,
              ),
            ),
          ),
          child: _buildCategoryItem(
            Icons.restaurant_outlined,
            'EATS'.tr(),
            isDarkMode
                ? Colors.white.withOpacity(0.05)
                : const Color(0xFFFFF9F2),
            const Color(0xFFFFB057),
            textColor,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar(
    BuildContext context,
    Color filterBgColor,
    Color textColor,
    Color cardColor,
  ) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 55,
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 12,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'search_hotels_hint'.tr(),
                hintStyle: TextStyle(
                  color: textColor.withOpacity(0.5),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 8.0),
                  child: Icon(
                    Icons.search,
                    color: textColor.withOpacity(0.7),
                    size: 22,
                  ),
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const FiltersAdvancedScreen()),
            );
          },
          child: Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              color: filterBgColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.tune, color: Colors.white, size: 22),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryItem(
    IconData icon,
    String label,
    Color bgColor,
    Color iconColor,
    Color textColor,
  ) {
    return Column(
      children: [
        Container(
          height: 75,
          width: 75,
          decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
          child: Icon(icon, color: iconColor, size: 26),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: textColor.withOpacity(0.6),
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  // 🌟 تم إضافة `required String id` هنا وتم تعديل الـ Navigation بالـ BlocProvider
  Widget _buildVerticalProductCard(
    BuildContext context, {
    required String id,
    required String title,
    required String location,
    required List<String> imageUrls,
    required String rating,
    required Color titleColor,
    required Color subColor,
  }) {
    return HotelProductCard(
      id: id,
      title: title,
      location: location,
      imageUrls: imageUrls,
      rating: rating,
      titleColor: titleColor,
      subColor: subColor,
      onAddClick: () => _showAddToCollectionSheet(
        context,
        hotelTitle: title,
        imageUrl: imageUrls.isNotEmpty ? imageUrls.first : "",
      ),
      onTap: () {
        addRecentlyViewedItem(
          RecentlyViewedItem(
            id: id,
            nameEn: title,
            nameAr: title,
            locationEn: location,
            locationAr: location,
            imageUrl: imageUrls.isNotEmpty ? imageUrls.first : "",
            price: 150.0,
            type: RecentlyItemType.hotel,
          ),
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => HotelDetailsScreen(
              hotelId: int.tryParse(id) ?? 0,
              fallbackTitle: title,
              fallbackImageUrl: imageUrls.isNotEmpty ? imageUrls.first : "",
            ),
          ),
        );
      },
    );
  }
}

// الـ Widget المستقل لعرض صور متعددة بشكل متحرك تلقائياً كل 3 ثوانٍ
class HotelProductCard extends StatefulWidget {
  final String id;
  final String title;
  final String location;
  final List<String> imageUrls;
  final String rating;
  final Color titleColor;
  final Color subColor;
  final VoidCallback onTap;
  final VoidCallback onAddClick;

  const HotelProductCard({
    super.key,
    required this.id,
    required this.title,
    required this.location,
    required this.imageUrls,
    required this.rating,
    required this.titleColor,
    required this.subColor,
    required this.onTap,
    required this.onAddClick,
  });

  @override
  State<HotelProductCard> createState() => _HotelProductCardState();
}

class _HotelProductCardState extends State<HotelProductCard> {
  late PageController _pageController;
  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);

    if (widget.imageUrls.length > 1) {
      _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
        if (_currentPage < widget.imageUrls.length - 1) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }

        if (_pageController.hasClients) {
          _pageController.animateToPage(
            _currentPage,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOutCubic,
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 10, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(35),
                  child: SizedBox(
                    height: 220,
                    width: double.infinity,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: widget.imageUrls.length,
                      onPageChanged: (index) {
                        _currentPage = index;
                      },
                      itemBuilder: (context, index) {
                        final imageUrl = widget.imageUrls[index];
                        final isAsset = imageUrl.startsWith('assets/');

                        return Container(
                          color: isDarkMode
                              ? Colors.white.withOpacity(0.05)
                              : const Color(0xFFE2E8F0),
                          child: isAsset
                              ? Image.asset(imageUrl, fit: BoxFit.cover)
                              : Image.network(
                                  imageUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      'assets/images/hotel-placeholder.jpg',
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),
                        );
                      },
                    ),
                  ),
                ),

                Positioned(
                  top: 15,
                  right: 15,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: widget.onAddClick,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(
                              isDarkMode ? 0.2 : 0.75,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.add,
                            color: isDarkMode
                                ? Colors.white
                                : const Color(0xFF0F4A42),
                            size: 20,
                          ),
                        ),
                      ),

                      BlocBuilder<FavoriteHotelsCubit, FavoriteHotelsState>(
                        builder: (context, state) {
                          bool isFav = false;
                          int? favoriteRecordId;

                          // 1. Safely check the state to see if this hotel is in the favorites list
                          state.when(
                            initial: () {},
                            loading: () {},
                            error: (message) {},
                            success: (favoriteHotels) {
                              for (var fav in favoriteHotels) {
                                if (fav.hotel.id.toString() == widget.id) {
                                  isFav = true;
                                  favoriteRecordId = fav.id; // We need this specific ID to delete it later!
                                  break;
                                }
                              }
                            },
                          );

                          return InkWell(
                            onTap: () async {
                              final hotelIdInt = int.tryParse(widget.id) ?? 0;

                              if (isFav && favoriteRecordId != null) {
                                // --- REMOVE FAVORITE ---
                                // 1. Remove instantly from UI state (Optimistic Update)
                                context
                                    .read<FavoriteHotelsCubit>()
                                    .removeHotelOptimistically(favoriteRecordId!);

                                // 2. Send delete request to backend using the specific favoriteRecordId
                                context
                                    .read<ToggleFavoriteHotelsCubit>()
                                    .removeFavorite(favoriteRecordId!);
                              } else {
                                // --- ADD FAVORITE ---
                                // 1. Await the add request to finish
                               await context
                                    .read<ToggleFavoriteHotelsCubit>()
                                    .addFavorite(hotelIdInt);

                                // 2. Fetch the new list ONLY AFTER the add is done
                                context
                                    .read<FavoriteHotelsCubit>()
                                    .getFavoriteHotels();
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(
                                  isDarkMode ? 0.2 : 0.75,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                isFav
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_border,
                                color: isFav
                                    ? const Color(0xFF0FA37A)
                                    : (isDarkMode
                                        ? Colors.white
                                        : const Color(0xFF0F4A42)),
                                size: 20,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w900,
                    color: widget.titleColor,
                    letterSpacing: -0.2,
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      widget.rating,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: widget.titleColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              widget.location,
              style: TextStyle(
                fontSize: 13,
                color: widget.subColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
