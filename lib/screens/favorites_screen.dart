
// import 'package:byma_app/business_logic/toggle_favorite_hotels/cubit/toggle_favorite_hotels_cubit.dart';
// import 'package:byma_app/data/models/favorite_hotel_model.dart';
// import 'package:flutter/material.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// // State Management & Models
// import 'package:byma_app/business_logic/favorite_hotels/cubit/favorite_hotels_cubit.dart';
// import 'package:byma_app/business_logic/favorite_hotels/cubit/favorite_hotels_state.dart';

// // Screens
// import '../screens/hotel_details_screen.dart';
// import '../screens/room_details_screen.dart';

// class FavoritesScreen extends StatelessWidget {
//   const FavoritesScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Scaffold(
//       backgroundColor: theme.scaffoldBackgroundColor,
//       body: SafeArea(
//         bottom: false,
//         child: Column(
//           children: [
//             // ----- Header -----
//             Padding(
//               padding: const EdgeInsets.fromLTRB(16, 8, 16, 6),
//               child: Row(
//                 children: [
//                   Container(
//                     width: 44,
//                     height: 44,
//                     decoration: BoxDecoration(
//                       color: theme.cardColor,
//                       borderRadius: BorderRadius.circular(14),
//                       border: Border.all(color: theme.dividerColor),
//                     ),
//                     child: IconButton(
//                       icon: const Icon(Icons.arrow_back_ios_new, size: 18),
//                       onPressed: () => Navigator.pop(context),
//                       splashRadius: 18,
//                       color: theme.iconTheme.color,
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'curated_collection_label'.tr(),
//                           style: TextStyle(
//                             fontSize: 11,
//                             fontWeight: FontWeight.w900,
//                             letterSpacing: 1.2,
//                             color: theme.textTheme.bodyMedium?.color
//                                 ?.withValues(alpha: 0.6),
//                           ),
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           'favorites_title'.tr(),
//                           style: TextStyle(
//                             fontSize: 28,
//                             fontWeight: FontWeight.w900,
//                             color: theme.textTheme.titleLarge?.color,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 4),

//             // ----- Main Content Body -----
//             Expanded(
//               child: ListView(
//                 padding: const EdgeInsets.only(bottom: 24),
//                 children: [
//                   // 1. Favorite Rooms Section (Local Scope)
//                   // AnimatedBuilder(
//                   //   animation: FavoritesScope.of(context),
//                   //   builder: (context, _) {
//                   //     final rooms = FavoritesScope.of(context).favorites
//                   //         .where(
//                   //           (item) => !item.id.toLowerCase().contains('hotel'),
//                   //         )
//                   //         .toList();

//                   //     if (rooms.isEmpty) return const SizedBox.shrink();

//                   //     return Column(
//                   //       crossAxisAlignment: CrossAxisAlignment.start,
//                   //       children: [
//                   //         _buildSectionHeader(
//                   //           theme,
//                   //           'favorite_rooms_label'.tr(),
//                   //         ),
//                   //         SizedBox(
//                   //           height: 340,
//                   //           child: ListView.separated(
//                   //             padding: const EdgeInsets.symmetric(
//                   //               horizontal: 16,
//                   //             ),
//                   //             scrollDirection: Axis.horizontal,
//                   //             itemCount: rooms.length,
//                   //             separatorBuilder: (_, __) =>
//                   //                 const SizedBox(width: 16),
//                   //             itemBuilder: (context, index) {
//                   //               return SizedBox(
//                   //                 width:
//                   //                     MediaQuery.of(context).size.width * 0.8,
//                   //                 child: _FavoriteRoomCard(
//                   //                   item: rooms[index],
//                   //                   theme: theme,
//                   //                 ),
//                   //               );
//                   //             },
//                   //           ),
//                   //         ),
//                   //         const SizedBox(height: 24),
//                   //       ],
//                   //     );
//                   //   },
//                   // ),

//                   // 2. Favorite Hotels Section (API via Cubit)
//                   BlocBuilder<FavoriteHotelsCubit, FavoriteHotelsState>(
//                     builder: (context, state) {
//                       return state.when(
//                         initial: () => const SizedBox.shrink(),

//                         loading: () => SizedBox(
//                           height: 200,
//                           child: Center(
//                             child: CircularProgressIndicator(
//                               color: theme.primaryColor,
//                             ),
//                           ),
//                         ),

//                         error: (message) => Padding(
//                           padding: const EdgeInsets.all(24.0),
//                           child: Center(
//                             child: Column(
//                               children: [
//                                 Text(
//                                   message,
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                     color: theme.colorScheme.error,
//                                     fontWeight: FontWeight.w700,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 12),
//                                 ElevatedButton(
//                                   onPressed: () {
//                                     context
//                                         .read<FavoriteHotelsCubit>()
//                                         .getFavoriteHotels();
//                                   },
//                                   child: const Text('Retry'),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),

//                         success: (favoriteHotels) {
//                           if (favoriteHotels.isEmpty) {
//                             return Center(
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 24,
//                                   vertical: 32,
//                                 ),
//                                 child: Text(
//                                   'no_favorites_message'.tr(),
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w800,
//                                     color: theme.textTheme.bodyMedium?.color
//                                         ?.withValues(alpha: 0.5),
//                                   ),
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ),
//                             );
//                           }

//                           return Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               _buildSectionHeader(
//                                 theme,
//                                 'favorite_hotels_label'.tr(),
//                               ),
//                               SizedBox(
//                                 height: 300,
//                                 child: ListView.separated(
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 16,
//                                   ),
//                                   scrollDirection: Axis.horizontal,
//                                   itemCount: favoriteHotels.length,
//                                   separatorBuilder: (_, __) =>
//                                       const SizedBox(width: 16),
//                                   itemBuilder: (context, index) {
//                                     return SizedBox(
//                                       width:
//                                           MediaQuery.of(context).size.width *
//                                           0.8,
//                                       child: _FavoriteHotelCard(
//                                         favoriteHotel: favoriteHotels[index],
//                                         theme: theme,
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ),
//                             ],
//                           );
//                         },
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSectionHeader(ThemeData theme, String title) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
//       child: Text(
//         title,
//         style: TextStyle(
//           fontSize: 18,
//           fontWeight: FontWeight.w900,
//           color: theme.textTheme.titleLarge?.color,
//         ),
//       ),
//     );
//   }
// }

// // ----- Dedicated Card for API Hotel Data -----
// class _FavoriteHotelCard extends StatelessWidget {
//   final FavoriteHotelModel favoriteHotel;
//   final ThemeData theme;

//   const _FavoriteHotelCard({required this.favoriteHotel, required this.theme});

//   @override
//   Widget build(BuildContext context) {
//     final hotel = favoriteHotel.hotel;
//     final firstImageUrl = hotel.imageUrls.isNotEmpty
//         ? hotel.imageUrls.first
//         : '';
//     // Check if the image is a local fallback asset to prevent network errors
//     final isAsset = firstImageUrl.startsWith('assets/');

//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => HotelDetailsScreen(
//               hotelId: hotel.id,
//               fallbackTitle: hotel.name,
//               fallbackImageUrl: firstImageUrl,
//             ),
//           ),
//         );
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: theme.cardColor,
//           borderRadius: BorderRadius.circular(26),
//           border: Border.all(color: theme.dividerColor),
//           boxShadow: [
//             BoxShadow(
//               color: theme.shadowColor.withValues(alpha: 0.08),
//               blurRadius: 18,
//               offset: const Offset(0, 10),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Stack(
//               children: [
//                 ClipRRect(
//                   borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(25),
//                     topRight: Radius.circular(25),
//                   ),
//                   child: AspectRatio(
//                     aspectRatio: 1.55,
//                     child: Container(
//                       color: theme.dividerColor.withValues(alpha: 0.2),
//                       child: firstImageUrl.isEmpty
//                           ? Icon(
//                               Icons.hotel,
//                               size: 48,
//                               color: theme.disabledColor,
//                             )
//                           : (isAsset
//                                 ? Image.asset(firstImageUrl, fit: BoxFit.cover)
//                                 : Image.network(
//                                     firstImageUrl,
//                                     fit: BoxFit.cover,
//                                     errorBuilder: (_, __, ___) => Image.asset(
//                                       'assets/images/hotel-placeholder.jpg',
//                                       fit: BoxFit.cover,
//                                     ),
//                                   )),
//                     ),
//                   ),
//                 ),
//                 // 🌟 Interactive Favorite Toggle Button
//                 Positioned(
//                   right: 14,
//                   top: 14,
//                   child: Material(
//                     color: Colors.transparent,
//                     child: InkWell(
//                       borderRadius: BorderRadius.circular(14),
//                       onTap: () {
//                         // 1. Remove instantly from UI state (Optimistic Update)
//                         context
//                             .read<FavoriteHotelsCubit>()
//                             .removeHotelOptimistically(favoriteHotel.id);

//                         // 2. Send delete request to backend in the background
//                         context
//                             .read<ToggleFavoriteHotelsCubit>()
//                             .removeFavorite(favoriteHotel.id);
//                       },
//                       child: Container(
//                         width: 42,
//                         height: 42,
//                         decoration: BoxDecoration(
//                           color: theme.cardColor.withValues(alpha: 0.85),
//                           borderRadius: BorderRadius.circular(14),
//                           border: Border.all(color: theme.dividerColor),
//                         ),
//                         child: Center(
//                           child: Icon(
//                             Icons
//                                 .favorite_rounded, // Always filled because it's in the favorites list
//                             color: theme.primaryColor,
//                             size: 18,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           hotel.name,
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w900,
//                             color: theme.textTheme.titleLarge?.color,
//                           ),
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         const SizedBox(height: 6),
//                         Text(
//                           hotel.address,
//                           style: TextStyle(
//                             fontWeight: FontWeight.w800,
//                             color: theme.textTheme.bodyMedium?.color
//                                 ?.withValues(alpha: 0.6),
//                             fontSize: 13,
//                           ),
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 10,
//                       vertical: 6,
//                     ),
//                     decoration: BoxDecoration(
//                       color: theme.cardColor,
//                       borderRadius: BorderRadius.circular(20),
//                       border: Border.all(color: theme.dividerColor, width: 1),
//                     ),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Icon(
//                           Icons.star_rounded,
//                           size: 18,
//                           color: theme.primaryColor,
//                         ),
//                         const SizedBox(width: 4),
//                         Text(
//                           hotel.rating.toString(),
//                           style: TextStyle(
//                             color: theme.textTheme.titleLarge?.color,
//                             fontWeight: FontWeight.w900,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // // ----- Dedicated Card for Local Room Items -----
// // class _FavoriteRoomCard extends StatelessWidget {
// //   final dynamic item;
// //   final ThemeData theme;

// //   const _FavoriteRoomCard({required this.item, required this.theme});

// //   @override
// //   Widget build(BuildContext context) {
// //     return GestureDetector(
// //       onTap: () {
// //         Navigator.push(
// //           context,
// //           MaterialPageRoute(
// //             builder: (context) => RoomDetailsScreen(
// //               id: item.id,
// //               roomTitle: item.title,
// //               pricePerNight: item.price,
// //             ),
// //           ),
// //         );
// //       },
// //       child: Container(
// //         decoration: BoxDecoration(
// //           color: theme.cardColor,
// //           borderRadius: BorderRadius.circular(26),
// //           border: Border.all(color: theme.dividerColor),
// //         ),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.stretch,
// //           children: [
// //             ClipRRect(
// //               borderRadius: const BorderRadius.only(
// //                 topLeft: Radius.circular(25),
// //                 topRight: Radius.circular(25),
// //               ),
// //               child: AspectRatio(
// //                 aspectRatio: 1.55,
// //                 child: item.imageAsset.isEmpty
// //                     ? const SizedBox.shrink()
// //                     : Image.asset(item.imageAsset, fit: BoxFit.cover),
// //               ),
// //             ),
// //             Padding(
// //               padding: const EdgeInsets.all(14),
// //               child: Text(
// //                 item.title.toString().tr(),
// //                 style: TextStyle(
// //                   fontSize: 16,
// //                   fontWeight: FontWeight.w900,
// //                   color: theme.textTheme.titleLarge?.color,
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }


import 'package:byma_app/business_logic/toggle_favorite_hotels/cubit/toggle_favorite_hotels_cubit.dart';
import 'package:byma_app/data/models/favorite_hotel_model.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// State Management & Models
import 'package:byma_app/business_logic/favorite_hotels/cubit/favorite_hotels_cubit.dart';
import 'package:byma_app/business_logic/favorite_hotels/cubit/favorite_hotels_state.dart';

// Screens
import '../screens/hotel_details_screen.dart';
import '../screens/room_details_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // ----- Header -----
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 6),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: theme.dividerColor),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                      onPressed: () => Navigator.pop(context),
                      splashRadius: 18,
                      color: theme.iconTheme.color,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'curated_collection_label'.tr(),
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.2,
                            color: theme.textTheme.bodyMedium?.color
                                ?.withValues(alpha: 0.6),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'favorites_title'.tr(),
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: theme.textTheme.titleLarge?.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),

            // ----- Main Content Body -----
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(bottom: 24),
                children: [
                  // 1. Favorite Rooms Section (Local Scope)
                  // AnimatedBuilder(
                  //   animation: FavoritesScope.of(context),
                  //   builder: (context, _) {
                  //     final rooms = FavoritesScope.of(context).favorites
                  //         .where(
                  //           (item) => !item.id.toLowerCase().contains('hotel'),
                  //         )
                  //         .toList();

                  //     if (rooms.isEmpty) return const SizedBox.shrink();

                  //     return Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         _buildSectionHeader(
                  //           theme,
                  //           'favorite_rooms_label'.tr(),
                  //         ),
                  //         SizedBox(
                  //           height: 340,
                  //           child: ListView.separated(
                  //             padding: const EdgeInsets.symmetric(
                  //               horizontal: 16,
                  //             ),
                  //             scrollDirection: Axis.horizontal,
                  //             itemCount: rooms.length,
                  //             separatorBuilder: (_, __) =>
                  //                 const SizedBox(width: 16),
                  //             itemBuilder: (context, index) {
                  //               return SizedBox(
                  //                 width:
                  //                     MediaQuery.of(context).size.width * 0.8,
                  //                 child: _FavoriteRoomCard(
                  //                   item: rooms[index],
                  //                   theme: theme,
                  //                 ),
                  //               );
                  //             },
                  //           ),
                  //         ),
                  //         const SizedBox(height: 24),
                  //       ],
                  //     );
                  //   },
                  // ),

                  // 2. Favorite Hotels Section (API via Cubit)
                  BlocBuilder<FavoriteHotelsCubit, FavoriteHotelsState>(
                    builder: (context, state) {
                      return state.when(
                        initial: () => const SizedBox.shrink(),

                        loading: () => SizedBox(
                          height: 200,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: theme.primaryColor,
                            ),
                          ),
                        ),

                        error: (message) => Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  message,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: theme.colorScheme.error,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                ElevatedButton(
                                  onPressed: () {
                                    context
                                        .read<FavoriteHotelsCubit>()
                                        .getFavoriteHotels();
                                  },
                                  child: const Text('Retry'),
                                ),
                              ],
                            ),
                          ),
                        ),

                        success: (favoriteHotels) {
                          if (favoriteHotels.isEmpty) {
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 32,
                                ),
                                child: Text(
                                  'no_favorites_message'.tr(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    color: theme.textTheme.bodyMedium?.color
                                        ?.withValues(alpha: 0.5),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildSectionHeader(
                                theme,
                                'favorite_hotels_label'.tr(),
                              ),
                              SizedBox(
                                height: 300,
                                child: ListView.separated(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: favoriteHotels.length,
                                  separatorBuilder: (_, __) =>
                                      const SizedBox(width: 16),
                                  itemBuilder: (context, index) {
                                    return SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width *
                                          0.8,
                                      child: _FavoriteHotelCard(
                                        favoriteHotel: favoriteHotels[index],
                                        theme: theme,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(ThemeData theme, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w900,
          color: theme.textTheme.titleLarge?.color,
        ),
      ),
    );
  }
}

// ----- Dedicated Card for API Hotel Data -----
class _FavoriteHotelCard extends StatelessWidget {
  final FavoriteHotelModel favoriteHotel;
  final ThemeData theme;

  const _FavoriteHotelCard({required this.favoriteHotel, required this.theme});

  @override
  Widget build(BuildContext context) {
    final hotel = favoriteHotel.hotel;
    final firstImageUrl = hotel.imageUrls.isNotEmpty
        ? hotel.imageUrls.first
        : '';
    // Check if the image is a local fallback asset to prevent network errors
    final isAsset = firstImageUrl.startsWith('assets/');

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HotelDetailsScreen(
              hotelId: hotel.id,
              fallbackTitle: hotel.name,
              fallbackImageUrl: firstImageUrl,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(26),
          border: Border.all(color: theme.dividerColor),
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withValues(alpha: 0.08),
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                  child: AspectRatio(
                    aspectRatio: 1.55,
                    child: Container(
                      color: theme.dividerColor.withValues(alpha: 0.2),
                      child: firstImageUrl.isEmpty
                          ? Icon(
                              Icons.hotel,
                              size: 48,
                              color: theme.disabledColor,
                            )
                          : (isAsset
                                ? Image.asset(firstImageUrl, fit: BoxFit.cover)
                                : Image.network(
                                    firstImageUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Image.asset(
                                      'assets/images/hotel-placeholder.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                    ),
                  ),
                ),
                // 🌟 Interactive Favorite Toggle Button
                Positioned(
                  right: 14,
                  top: 14,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () {
                        // 1. Remove instantly from UI state (Optimistic Update)
                        context
                            .read<FavoriteHotelsCubit>()
                            .removeHotelOptimistically(favoriteHotel.id);

                        // 2. Send delete request to backend in the background
                        context
                            .read<ToggleFavoriteHotelsCubit>()
                            .removeFavorite(favoriteHotel.id);
                      },
                      child: Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: theme.cardColor.withValues(alpha: 0.85),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: theme.dividerColor),
                        ),
                        child: Center(
                          child: Icon(
                            Icons
                                .favorite_rounded, // Always filled because it's in the favorites list
                            color: theme.primaryColor,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hotel.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: theme.textTheme.titleLarge?.color,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          hotel.address,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: theme.textTheme.bodyMedium?.color
                                ?.withValues(alpha: 0.6),
                            fontSize: 13,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: theme.dividerColor, width: 1),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.star_rounded,
                          size: 18,
                          color: theme.primaryColor,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          hotel.rating.toString(),
                          style: TextStyle(
                            color: theme.textTheme.titleLarge?.color,
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// // ----- Dedicated Card for Local Room Items -----
// class _FavoriteRoomCard extends StatelessWidget {
//   final dynamic item;
//   final ThemeData theme;

//   const _FavoriteRoomCard({required this.item, required this.theme});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => RoomDetailsScreen(
//               id: item.id,
//               roomTitle: item.title,
//               pricePerNight: item.price,
//             ),
//           ),
//         );
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: theme.cardColor,
//           borderRadius: BorderRadius.circular(26),
//           border: Border.all(color: theme.dividerColor),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             ClipRRect(
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(25),
//                 topRight: Radius.circular(25),
//               ),
//               child: AspectRatio(
//                 aspectRatio: 1.55,
//                 child: item.imageAsset.isEmpty
//                     ? const SizedBox.shrink()
//                     : Image.asset(item.imageAsset, fit: BoxFit.cover),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(14),
//               child: Text(
//                 item.title.toString().tr(),
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w900,
//                   color: theme.textTheme.titleLarge?.color,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

