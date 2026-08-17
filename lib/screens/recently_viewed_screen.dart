import 'package:byma_app/business_logic/recently_viewed_rooms/cubit/recently_viewed_rooms_cubit.dart';
import 'package:byma_app/business_logic/recently_viewed_rooms/cubit/recently_viewed_rooms_state.dart';
import 'package:byma_app/screens/hotel_details_screen.dart';
import 'package:byma_app/screens/room_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:byma_app/data/models/recently_viewed_hotel_model.dart';
import 'package:byma_app/business_logic/recently_viewed_hotels/recently_viewed_hotels_cubit.dart';
import 'package:byma_app/business_logic/recently_viewed_hotels/recently_viewed_hotels_state.dart';
import 'package:byma_app/data/models/recently_viewed_room_model.dart';

class RecentlyViewedScreen extends StatefulWidget {
  const RecentlyViewedScreen({super.key});

  @override
  State<RecentlyViewedScreen> createState() => _RecentlyViewedScreenState();
}

class _RecentlyViewedScreenState extends State<RecentlyViewedScreen> {
  @override
  void initState() {
    super.initState();
    // Trigger both API calls when the screen opens
    context.read<RecentlyViewedHotelsCubit>().getRecentlyViewedHotels();
    context.read<RecentlyViewedRoomsCubit>().getRecentlyViewedRooms();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.primary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          context.tr('recently_viewed_title'),
          style: TextStyle(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w900,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==========================================
            // RECENTLY VIEWED ROOMS SECTION
            // ==========================================
            _buildRoomsSection(theme),
            const SizedBox(height: 24),

            // ==========================================
            // RECENTLY VIEWED HOTELS SECTION
            // ==========================================
            _buildHotelsSection(theme),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // ROOMS SECTION BUILDERS
  // ===========================================================================

  Widget _buildRoomsSection(ThemeData theme) {
    return BlocBuilder<RecentlyViewedRoomsCubit, RecentlyViewedRoomsState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox.shrink(),
          loading: () => const Center(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: CircularProgressIndicator(),
            ),
          ),
          error: (message) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                message,
                style: TextStyle(color: theme.colorScheme.error, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          success: (recentlyViewedRooms) {
            if (recentlyViewedRooms.isEmpty) {
              return const SizedBox.shrink();
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    context.tr('rooms_section_title'),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    itemCount: recentlyViewedRooms.length,
                    itemBuilder: (context, index) {
                      final item = recentlyViewedRooms[index];
                      return _buildRoomCard(item, theme, context);
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildRoomCard(
    RecentlyViewedRoomModel item,
    ThemeData theme,
    BuildContext context,
  ) {
    final room = item.room;
    final String firstPhotoUrl =
        room.imageUrls.isNotEmpty ? room.imageUrls.first : '';
    final bool isNetworkImage = firstPhotoUrl.startsWith('http');

    return Container(
      width: 210,
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor, width: 1.2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RoomDetailsScreen(
                    roomId: room.id,
                  ),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. First Room Photo
                Expanded(
                  child: Container(
                    width: double.infinity,
                    color: theme.dividerColor.withOpacity(0.3),
                    child: isNetworkImage
                        ? Image.network(
                            firstPhotoUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                _buildRoomFallbackIcon(theme),
                          )
                        : Image.asset(
                            firstPhotoUrl.isNotEmpty
                                ? firstPhotoUrl
                                : 'assets/images/room-placeholder.jpg',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                _buildRoomFallbackIcon(theme),
                          ),
                  ),
                ),

                // 2. Room Details (Category & Price)
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Room Category Name
                      Text(
                        room.category.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: theme.colorScheme.secondary,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Room Price
                      Row(
                        children: [
                          Icon(
                            Icons.sell_outlined,
                            size: 16,
                            color: theme.colorScheme.primary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '\$${room.price}',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoomFallbackIcon(ThemeData theme) {
    return Center(
      child: Icon(
        Icons.bed_outlined,
        color: theme.colorScheme.tertiary,
        size: 32,
      ),
    );
  }

  // ===========================================================================
  // HOTELS SECTION BUILDERS
  // ===========================================================================

  Widget _buildHotelsSection(ThemeData theme) {
    return BlocBuilder<RecentlyViewedHotelsCubit, RecentlyViewedHotelsState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox.shrink(),
          loading: () => const Center(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: CircularProgressIndicator(),
            ),
          ),
          error: (message) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                message,
                style: TextStyle(color: theme.colorScheme.error, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          success: (recentlyViewedHotels) {
            if (recentlyViewedHotels.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Text(
                    context.tr('no_recently_viewed'),
                    style: TextStyle(
                      color: theme.colorScheme.tertiary,
                      fontSize: 16,
                    ),
                  ),
                ),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    context.tr('hotels_section_title'),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    itemCount: recentlyViewedHotels.length,
                    itemBuilder: (context, index) {
                      final item = recentlyViewedHotels[index];
                      return _buildHotelCard(item, theme, context);
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildHotelCard(
    RecentlyViewedHotelModel item,
    ThemeData theme,
    BuildContext context,
  ) {
    final hotel = item.hotel;
    final String firstPhotoUrl =
        hotel.imageUrls.isNotEmpty ? hotel.imageUrls.first : '';
    final bool isNetworkImage = firstPhotoUrl.startsWith('http');

    return Container(
      width: 210,
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor, width: 1.2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => HotelDetailsScreen(
                    hotelId: hotel.id,
                  ),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. First Hotel Photo
                Expanded(
                  child: Container(
                    width: double.infinity,
                    color: theme.dividerColor.withOpacity(0.3),
                    child: isNetworkImage
                        ? Image.network(
                            firstPhotoUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                _buildFallbackIcon(theme),
                          )
                        : Image.asset(
                            firstPhotoUrl.isNotEmpty
                                ? firstPhotoUrl
                                : 'assets/images/hotel-placeholder.jpg',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                _buildFallbackIcon(theme),
                          ),
                  ),
                ),

                // 2. Hotel Details (Name, Address, Rating)
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Hotel Name
                      Text(
                        hotel.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: theme.colorScheme.secondary,
                        ),
                      ),
                      const SizedBox(height: 6),

                      // Hotel Address
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 14,
                            color: theme.colorScheme.tertiary,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              hotel.address,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                color: theme.colorScheme.tertiary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Hotel Rating
                      Row(
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            size: 18,
                            color: Colors.amber,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            hotel.rating.toStringAsFixed(1),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFallbackIcon(ThemeData theme) {
    return Center(
      child: Icon(
        Icons.hotel_outlined,
        color: theme.colorScheme.tertiary,
        size: 32,
      ),
    );
  }
}