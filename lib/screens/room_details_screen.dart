
// import 'package:byma_app/business_logic/room_details/cubit/room_details_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'payment_screen.dart';
// import 'package:byma_app/widgets/room_details_widgets.dart';

// class RoomDetailsScreen extends StatefulWidget {
//   final int roomId;

//   const RoomDetailsScreen({
//     super.key,
//     required this.roomId,
//   });

//   @override
//   State<RoomDetailsScreen> createState() => _RoomDetailsScreenState();
// }

// class _RoomDetailsScreenState extends State<RoomDetailsScreen> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<RoomDetailsCubit>().fetchRoomDetails(widget.roomId);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDarkMode = theme.brightness == Brightness.dark;
//     final isHighContrast = theme.colorScheme.primary == Colors.yellow;

//     final Color dynamicTeal = isHighContrast
//         ? Colors.yellow
//         : (isDarkMode ? const Color(0xFF0FA37A) : const Color(0xFF0E6F63));

//     final Color dynamicTeal2 = isHighContrast
//         ? Colors.yellowAccent
//         : const Color(0xFF0FA37A);

//     final Color textColor = isHighContrast
//         ? Colors.white
//         : (isDarkMode ? Colors.white : Colors.black87);

//     final Color subTextColor = isHighContrast
//         ? Colors.white70
//         : (isDarkMode ? Colors.white60 : Colors.black54);

//     final Color scaffoldBg = theme.scaffoldBackgroundColor;
//     final Color cardBg = theme.cardColor;
//     final Color borderAndDivider = theme.dividerColor;

//     return Scaffold(
//       backgroundColor: scaffoldBg,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         scrolledUnderElevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios_new, color: theme.colorScheme.primary),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           'room_details_title'.tr(),
//           style: TextStyle(
//             fontWeight: FontWeight.w900,
//             color: theme.colorScheme.primary,
//           ),
//         ),
//         centerTitle: false,
//       ),
//       body: SafeArea(
//         child: BlocBuilder<RoomDetailsCubit, RoomDetailsState>(
//           builder: (context, state) {
//             return state.when(
//               initial: () => const Center(child: CircularProgressIndicator()),
//               loading: () => const Center(child: CircularProgressIndicator()),
//               error: (message) => Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.error_outline, size: 48, color: theme.colorScheme.error),
//                     const SizedBox(height: 16),
//                     Text(
//                       message,
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: theme.colorScheme.error,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: dynamicTeal,
//                       ),
//                       onPressed: () {
//                         context
//                             .read<RoomDetailsCubit>()
//                             .fetchRoomDetails(widget.roomId);
//                       },
//                       child: Text(
//                         'retry_btn'.tr(),
//                         style: const TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               success: (room) => ListView(
//                 padding: const EdgeInsets.fromLTRB(18, 10, 18, 24),
//                 children: [
//                   RoomPhotoCarousel(
//                     imageUrls: room.imageUrls,
//                     isDarkMode: isDarkMode,
//                     isHighContrast: isHighContrast,
//                     activeColor: dynamicTeal,
//                   ),

//                   const SizedBox(height: 14),

//                   // 1. Removed Premium Experience Widget - Kept Badge Aligned Right
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       RoomStatusBadge(status: room.status),
//                     ],
//                   ),
//                   const SizedBox(height: 8),

//                   // 2. Updated to show roomCategory.name instead of toString()
//                   Text(
//                     room.roomCategory.name,
//                     style: TextStyle(
//                       fontSize: 28,
//                       height: 1.08,
//                       fontWeight: FontWeight.w900,
//                       color: theme.colorScheme.primary,
//                     ),
//                   ),
//                   const SizedBox(height: 8),

//                   // 3. Price with Dollar Sign next to "per night" label
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.baseline,
//                     textBaseline: TextBaseline.alphabetic,
//                     children: [
//                       Text(
//                         '${room.price}\$',
//                         style: TextStyle(
//                           fontWeight: FontWeight.w900,
//                           fontSize: 26,
//                           color: dynamicTeal2,
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       Text(
//                         '/ ${'per_night_label'.tr()}',
//                         style: TextStyle(
//                           color: subTextColor,
//                           fontWeight: FontWeight.w800,
//                           fontSize: 13,
//                         ),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 16),
//                   Container(
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: cardBg,
//                       borderRadius: BorderRadius.circular(22),
//                       border: Border.all(color: borderAndDivider, width: 1.2),
//                     ),
//                     child: Column(
//                       children: [
//                         RoomInfoChip(
//                           icon: Icons.door_front_door_outlined,
//                           text: '${"Room's Number".tr()}: ${room.roomNumber}',
//                           iconColor: dynamicTeal,
//                         ),
//                         const SizedBox(height: 10),
//                         RoomInfoChip(
//                           icon: Icons.layers_outlined,
//                           text: '${"Floor's Number".tr()}: ${room.floor}',
//                           iconColor: dynamicTeal,
//                         ),
//                         const SizedBox(height: 10),
//                         RoomInfoChip(
//                           icon: Icons.bed_outlined,
//                           text: '${"Number of beds".tr()}: ${room.bedNumber}',
//                           iconColor: dynamicTeal,
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 14),
//                   RoomSectionHeader(
//                     title: 'Room Amenities'.tr(),
//                     teal: dynamicTeal,
//                   ),
//                   const SizedBox(height: 12),

//                   // Pass roomAmenities directly without manual string mapping
//                   RoomAmenitiesSection(
//                     amenities: room.roomAmenities,
//                     tealColor: dynamicTeal2,
//                   ),

//                   const SizedBox(height: 20),
//                   RoomSectionHeader(
//                     title: 'special_requests_title'.tr(),
//                     teal: dynamicTeal,
//                   ),
//                   const SizedBox(height: 12),
//                   SpecialRequestsCard(
//                     dynamicTeal: dynamicTeal,
//                     dynamicTeal2: dynamicTeal2,
//                     textColor: textColor,
//                     isHighContrast: isHighContrast,
//                   ),
//                   const SizedBox(height: 26),
//                   SizedBox(
//                     height: 54,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         // Navigator.push(
//                         //   context,
//                         //   MaterialPageRoute(
//                         //     builder: (_) => FinalizeReservationScreen(
//                         //       roomTitle: room.title,
//                         //       pricePerNight: room.pricePerNight,
//                         //     ),
//                         //   ),
//                         // );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: isHighContrast
//                             ? Colors.yellow
//                             : (isDarkMode
//                                 ? const Color(0xFF2E97C9)
//                                 : Colors.lightBlueAccent.withOpacity(0.75)),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(999),
//                         ),
//                         side: isHighContrast
//                             ? const BorderSide(color: Colors.white, width: 1.5)
//                             : null,
//                       ),
//                       child: Text(
//                         'reserve_room_btn'.tr(),
//                         style: TextStyle(
//                           fontWeight: FontWeight.w900,
//                           fontSize: 15,
//                           color: isHighContrast ? Colors.black : Colors.white,
//                           letterSpacing: 0.2,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }


import 'package:byma_app/business_logic/room_details/cubit/room_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'payment_screen.dart';
import 'package:byma_app/widgets/room_details_widgets.dart';

class RoomDetailsScreen extends StatefulWidget {
  final int roomId;

  const RoomDetailsScreen({
    super.key,
    required this.roomId,
  });

  @override
  State<RoomDetailsScreen> createState() => _RoomDetailsScreenState();
}

class _RoomDetailsScreenState extends State<RoomDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<RoomDetailsCubit>().fetchRoomDetails(widget.roomId);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final isHighContrast = theme.colorScheme.primary == Colors.yellow;

    final Color dynamicTeal = isHighContrast
        ? Colors.yellow
        : (isDarkMode ? const Color(0xFF0FA37A) : const Color(0xFF0E6F63));

    final Color dynamicTeal2 = isHighContrast
        ? Colors.yellowAccent
        : const Color(0xFF0FA37A);

    final Color textColor = isHighContrast
        ? Colors.white
        : (isDarkMode ? Colors.white : Colors.black87);

    final Color subTextColor = isHighContrast
        ? Colors.white70
        : (isDarkMode ? Colors.white60 : Colors.black54);

    final Color scaffoldBg = theme.scaffoldBackgroundColor;
    final Color cardBg = theme.cardColor;
    final Color borderAndDivider = theme.dividerColor;

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: theme.colorScheme.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'room_details_title'.tr(),
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: theme.colorScheme.primary,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: BlocBuilder<RoomDetailsCubit, RoomDetailsState>(
          builder: (context, state) {
            return state.when(
              initial: () => const Center(child: CircularProgressIndicator()),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (message) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 48, color: theme.colorScheme.error),
                    const SizedBox(height: 16),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: theme.colorScheme.error,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: dynamicTeal,
                      ),
                      onPressed: () {
                        context
                            .read<RoomDetailsCubit>()
                            .fetchRoomDetails(widget.roomId);
                      },
                      child: Text(
                        'retry_btn'.tr(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              success: (room) => ListView(
                padding: const EdgeInsets.fromLTRB(18, 10, 18, 24),
                children: [
                  RoomPhotoCarousel(
                    imageUrls: room.imageUrls,
                    isDarkMode: isDarkMode,
                    isHighContrast: isHighContrast,
                    activeColor: dynamicTeal,
                  ),

                  const SizedBox(height: 14),

                  // 1. Removed Premium Experience Widget - Kept Badge Aligned Right
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RoomStatusBadge(status: room.status),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // 2. Updated to show roomCategory.name instead of toString()
                  Text(
                    room.roomCategory.name,
                    style: TextStyle(
                      fontSize: 28,
                      height: 1.08,
                      fontWeight: FontWeight.w900,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // 3. Price with Dollar Sign next to "per night" label
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        '${room.price}\$',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 26,
                          color: dynamicTeal2,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '/ ${'per_night_label'.tr()}',
                        style: TextStyle(
                          color: subTextColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: cardBg,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: borderAndDivider, width: 1.2),
                    ),
                    child: Column(
                      children: [
                        RoomInfoChip(
                          icon: Icons.door_front_door_outlined,
                          text: '${"Room's Number".tr()}: ${room.roomNumber}',
                          iconColor: dynamicTeal,
                        ),
                        const SizedBox(height: 10),
                        RoomInfoChip(
                          icon: Icons.layers_outlined,
                          text: '${"Floor's Number".tr()}: ${room.floor}',
                          iconColor: dynamicTeal,
                        ),
                        const SizedBox(height: 10),
                        RoomInfoChip(
                          icon: Icons.bed_outlined,
                          text: '${"Number of beds".tr()}: ${room.bedNumber}',
                          iconColor: dynamicTeal,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  RoomSectionHeader(
                    title: 'Room Amenities'.tr(),
                    teal: dynamicTeal,
                  ),
                  const SizedBox(height: 12),

                  // Pass roomAmenities directly without manual string mapping
                  RoomAmenitiesSection(
                    amenities: room.roomAmenities,
                    tealColor: dynamicTeal2,
                  ),

                  const SizedBox(height: 20),
                  RoomSectionHeader(
                    title: 'special_requests_title'.tr(),
                    teal: dynamicTeal,
                  ),
                  const SizedBox(height: 12),
                  SpecialRequestsCard(
                    dynamicTeal: dynamicTeal,
                    dynamicTeal2: dynamicTeal2,
                    textColor: textColor,
                    isHighContrast: isHighContrast,
                  ),
                  const SizedBox(height: 26),
                  SizedBox(
                    height: 54,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (_) => FinalizeReservationScreen(
                        //       roomTitle: room.title,
                        //       pricePerNight: room.pricePerNight,
                        //     ),
                        //   ),
                        // );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isHighContrast
                            ? Colors.yellow
                            : (isDarkMode
                                ? const Color(0xFF2E97C9)
                                : Colors.lightBlueAccent.withOpacity(0.75)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(999),
                        ),
                        side: isHighContrast
                            ? const BorderSide(color: Colors.white, width: 1.5)
                            : null,
                      ),
                      child: Text(
                        'reserve_room_btn'.tr(),
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 15,
                          color: isHighContrast ? Colors.black : Colors.white,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}