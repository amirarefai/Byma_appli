import 'package:byma_app/business_logic/delete_hotel_from_collection/cubit/delete_hotel_from_collection_cubit.dart';
import 'package:byma_app/business_logic/delete_hotel_from_collection/cubit/delete_hotel_from_collection_state.dart';
import 'package:byma_app/business_logic/delete_room_from_collection/cubit/delete_room_from_collection_cubit.dart';
import 'package:byma_app/business_logic/delete_room_from_collection/cubit/delete_room_from_collection_state.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:byma_app/business_logic/hotel_collection/cubit/hotel_collection_cubit.dart';
import 'package:byma_app/business_logic/hotel_collection/cubit/hotel_collection_state.dart';
import 'package:byma_app/business_logic/room_collection/cubit/room_collection_cubit.dart';
import 'package:byma_app/business_logic/room_collection/cubit/room_collection_state.dart';

import 'package:byma_app/data/models/collection_model.dart';
import 'package:byma_app/data/models/hotel_model.dart';
import 'package:byma_app/data/models/room_model.dart';

import 'package:byma_app/screens/hotel_details_screen.dart';
import 'package:byma_app/screens/room_details_screen.dart';

class CollectionDetailsScreen extends StatefulWidget {
  final CollectionModel collection;

  const CollectionDetailsScreen({super.key, required this.collection});

  @override
  State<CollectionDetailsScreen> createState() =>
      _CollectionDetailsScreenState();
}

class _CollectionDetailsScreenState extends State<CollectionDetailsScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch both hotels and rooms in this collection when the screen opens
    context.read<HotelCollectionCubit>().getHotelCollection(
      widget.collection.id,
    );
    context.read<RoomCollectionCubit>().getRoomCollection(widget.collection.id);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MultiBlocListener(
      listeners: [
        // 1. Hotel Deletion Listener
        BlocListener<
          DeleteHotelFromCollectionCubit,
          DeleteHotelFromCollectionState
        >(
          listener: (context, state) {
            state.whenOrNull(
              error: (message) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                    backgroundColor: theme.colorScheme.error,
                  ),
                );
                context.read<HotelCollectionCubit>().getHotelCollection(
                  widget.collection.id,
                );
              },
              success: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Hotel removed from collection'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            );
          },
        ),

        // 2. Room Deletion Listener
        BlocListener<
          DeleteRoomFromCollectionCubit,
          DeleteRoomFromCollectionState
        >(
          listener: (context, state) {
            state.whenOrNull(
              error: (message) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                    backgroundColor: theme.colorScheme.error,
                  ),
                );
                // Rollback UI by re-fetching if optimistic delete failed
                context.read<RoomCollectionCubit>().getRoomCollection(
                  widget.collection.id,
                );
              },
              success: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Room removed from collection'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            );
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            widget.collection.name,
            style: TextStyle(
              color: theme.colorScheme.secondary,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: theme.colorScheme.primary),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHotelsSection(theme),
              const SizedBox(height: 24),
              _buildRoomsSection(theme),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // HOTELS SECTION
  // ===========================================================================

  Widget _buildHotelsSection(ThemeData theme) {
    return BlocBuilder<HotelCollectionCubit, HotelCollectionState>(
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
              child: Column(
                children: [
                  Text(
                    message,
                    style: TextStyle(
                      color: theme.colorScheme.error,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => context
                        .read<HotelCollectionCubit>()
                        .getHotelCollection(widget.collection.id),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          ),
          success: (hotelCollections) {
            if (hotelCollections.isEmpty) {
              return const SizedBox.shrink();
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    context.tr('Hotels Collection'),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: hotelCollections.length,
                  itemBuilder: (context, index) {
                    final item = hotelCollections[index];
                    return _buildHotelCard(item.hotel, theme, context);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildHotelCard(
    HotelModel hotel,
    ThemeData theme,
    BuildContext context,
  ) {
    final String firstPhotoUrl = hotel.imageUrls.isNotEmpty
        ? hotel.imageUrls.first
        : '';
    final bool isNetworkImage = firstPhotoUrl.startsWith('http');

    return Container(
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
                  builder: (_) => HotelDetailsScreen(hotelId: hotel.id),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. First Hotel Photo with Remove Button Overlay
                Expanded(
                  child: Stack(
                    fit: StackFit.expand,// Ensures the Stack fills the available space
                    children: [
                      Container(
                        width: double.infinity,
                        height: double.infinity,// Ensures the image fills the available space
                        color: theme.dividerColor.withOpacity(0.3),
                        child: isNetworkImage
                            ? Image.network(
                                firstPhotoUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    _buildHotelFallbackIcon(theme),
                              )
                            : Image.asset(
                                firstPhotoUrl.isNotEmpty
                                    ? firstPhotoUrl
                                    : 'assets/images/hotel-placeholder.jpg',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    _buildHotelFallbackIcon(theme),
                              ),
                      ),

                      // Remove Button at Top-Right Corner
                      Positioned(
                        top: 8,
                        right: 8,
                        child: _buildRemoveHotelButton(hotel.id, theme),
                      ),
                    ],
                  ),
                ),

                // 2. Hotel Details (Name, Address, Rating)
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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

  Widget _buildRemoveHotelButton(int hotelId, ThemeData theme) {
    return Material(
      color: Colors.black.withOpacity(0.45),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () {
          // 1. Remove instantly from UI (Optimistic Update)
          context
              .read<HotelCollectionCubit>()
              .deleteHotelFromCollectionOptimistically(hotelId);

          // 2. Fire the background API request
          context
              .read<DeleteHotelFromCollectionCubit>()
              .deleteHotelFromCollection(widget.collection.id, hotelId);
        },
        child: const Padding(
          padding: EdgeInsets.all(6.0),
          child: Icon(
            Icons.delete_outline_rounded, // Or Icons.bookmark_remove_outlined
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildHotelFallbackIcon(ThemeData theme) {
    return Center(
      child: Icon(
        Icons.hotel_outlined,
        color: theme.colorScheme.tertiary,
        size: 32,
      ),
    );
  }

  // ===========================================================================
  // ROOMS SECTION
  // ===========================================================================

  Widget _buildRoomsSection(ThemeData theme) {
    return BlocBuilder<RoomCollectionCubit, RoomCollectionState>(
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
              child: Column(
                children: [
                  Text(
                    message,
                    style: TextStyle(
                      color: theme.colorScheme.error,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => context
                        .read<RoomCollectionCubit>()
                        .getRoomCollection(widget.collection.id),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          ),
          success: (roomCollections) {
            if (roomCollections.isEmpty) {
              return const SizedBox.shrink();
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    context.tr('Rooms Collection'),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: roomCollections.length,
                  itemBuilder: (context, index) {
                    final item = roomCollections[index];
                    return _buildRoomCard(item.room, theme, context);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildRoomCard(RoomModel room, ThemeData theme, BuildContext context) {
    final String firstPhotoUrl = room.imageUrls.isNotEmpty
        ? room.imageUrls.first
        : '';
    final bool isNetworkImage = firstPhotoUrl.startsWith('http');

    return Container(
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
                  builder: (_) => RoomDetailsScreen(roomId: room.id),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. First Room Photo
                Expanded(
                  child: Stack(
                    fit: StackFit.expand,// Ensures the Stack fills the available space
                    children: [
                      Container(
                        width: double.infinity,
                        height: double.infinity,// Ensures the image fills the available space
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
                      Positioned(
                        top: 8,
                        right: 8,
                        child: _buildRemoveRoomButton(room.id, theme),
                      ),
                    ],
                  ),
                ),

                // 2. Room Details (Category Name & Price)
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

  Widget _buildRemoveRoomButton(int roomId, ThemeData theme) {
    return Material(
      color: Colors.black.withOpacity(0.45),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () {
          // 1. Remove instantly from UI (Optimistic Update)
          context
              .read<RoomCollectionCubit>()
              .deleteRoomFromCollectionOptimistically(roomId);

          // 2. Fire the background API request
          context
              .read<DeleteRoomFromCollectionCubit>()
              .deleteRoomFromCollection(widget.collection.id, roomId);
        },
        child: const Padding(
          padding: EdgeInsets.all(6.0),
          child: Icon(
            Icons.delete_outline_rounded,
            color: Colors.white,
            size: 20,
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
}
