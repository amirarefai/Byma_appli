import 'package:byma_app/business_logic/favorite_rooms/cubit/favorite_rooms_cubit.dart';
import 'package:byma_app/business_logic/hotel_details/cubit/hotel_details_cubit.dart';
import 'package:byma_app/business_logic/hotel_rooms_filter/cubit/hotel_rooms_filter_cubit.dart';
import 'package:byma_app/data/models/room_filter_model.dart';
import 'package:byma_app/data/models/room_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:byma_app/data/models/hotel_details_model.dart';
import 'package:byma_app/widgets/hotel_details_widgets.dart';
import 'room_filter_screen.dart';
import 'conversation_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class HotelDetailsScreen extends StatefulWidget {
  final int hotelId;

  const HotelDetailsScreen({super.key, required this.hotelId});

  @override
  State<HotelDetailsScreen> createState() => _HotelDetailsScreenState();
}

class _HotelDetailsScreenState extends State<HotelDetailsScreen> {
  // 1. Add this helper method inside _HotelDetailsScreenState
  Future<void> _openExternalMap(double lat, double lng, String label) async {
    final Uri mapUri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$lat,$lng',
    );

    if (await canLaunchUrl(mapUri)) {
      await launchUrl(mapUri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open maps application.')),
        );
      }
    }
  }

  Widget _buildRoomsList(
    BuildContext context,
    List<RoomModel> rooms,
    Color secondaryTeal,
    String hotelName,
  ) {
    if (rooms.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Text(context.tr('No Rooms Available')),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: rooms.length,
      itemBuilder: (context, index) {
        return HotelRoomCard(
          room: rooms[index],
          secondaryTeal: secondaryTeal,
          hotelName: hotelName,
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    // Dispatch API Call when screen opens
    context.read<HotelDetailsCubit>().getHotelDetails(widget.hotelId);
    context.read<FavoriteRoomsCubit>().getFavoriteRooms();
    // Add this to ensure a clean slate when opening a new hotel
    context.read<HotelRoomsFilterCubit>().resetFilter();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor:
            theme.appBarTheme.backgroundColor ?? theme.scaffoldBackgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 6),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: theme.iconTheme.color,
              size: 20,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: Text(
          context.tr('hotelDetails'),
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w900,
            fontSize: 16.5,
          ),
        ),
        actions: [const SizedBox(width: 14)],
      ),
      body: BlocBuilder<HotelDetailsCubit, HotelDetailsState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (message) => _buildErrorState(context, message),
            success: (hotel) => _buildSuccessContent(context, hotel),
          );
        },
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 56, color: Colors.redAccent),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                context.read<HotelDetailsCubit>().getHotelDetails(
                  widget.hotelId,
                );
              },
              icon: const Icon(Icons.refresh),
              label: Text(context.tr('retry')),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessContent(BuildContext context, HotelDetailsModel hotel) {
    final theme = Theme.of(context);
    final isHighContrast = theme.colorScheme.primary == Colors.yellow;
    final primaryTeal = theme.colorScheme.primary;
    final secondaryTeal = theme.colorScheme.secondary;
    final cardBgColor = theme.cardColor;

    return SafeArea(
      child: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 120),
            children: [
              HotelHeroImage(
                secondaryTeal: secondaryTeal,
                imageUrls: hotel.imageUrls,
              ),
              const SizedBox(height: 16),

              // 1. Title, Ratings & Address
              HotelRatingsRow(
                secondaryTeal: secondaryTeal,
                title: hotel.name,
                rating: hotel.rating,
                city: hotel.city,
                country: hotel.country,
              ),
              const SizedBox(height: 24),

              // 2. Amenities
              HotelUnderlineTitle(
                titleKey: 'Hotel Amenities',
                color: secondaryTeal,
              ),
              const SizedBox(height: 12),
              HotelAmenitiesGrid(
                teal: primaryTeal,
                amenities: hotel.hotelAmenities,
              ),
              const SizedBox(height: 24),

              HotelUnderlineTitle(
                titleKey: 'Special Services',
                color: secondaryTeal,
              ),
              const SizedBox(height: 12),
              HotelSpecialServicesGrid(
                teal: primaryTeal,
                services: hotel.specialServices,
              ),
              const SizedBox(height: 24),

              // 3. Check-in & Check-out Times
              HotelUnderlineTitle(
                titleKey: 'Check In & Out Times',
                color: secondaryTeal,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: HotelTimeCard(
                      icon: Icons.login_rounded,
                      labelKey: 'Check In',
                      time: hotel.checkIn,
                      primaryColor: primaryTeal,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: HotelTimeCard(
                      icon: Icons.logout_rounded,
                      labelKey: 'Check Out',
                      time: hotel.checkOut,
                      primaryColor: primaryTeal,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // 4. Location Details
              HotelUnderlineTitle(
                titleKey: 'locationTitle',
                color: secondaryTeal,
              ),
              const SizedBox(height: 12),
              HotelLocationCard(
                secondaryTeal: secondaryTeal,
                latitude: hotel.lat,
                longitude: hotel.lng,
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () =>
                      _openExternalMap(hotel.lat, hotel.lng, hotel.name),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: theme.canvasColor,
                    foregroundColor: secondaryTeal,
                    side: BorderSide(color: secondaryTeal.withOpacity(0.25)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.open_in_new_rounded, size: 18),
                      const SizedBox(width: 10),
                      Text(
                        context.tr('openInMaps'),
                        style: theme.textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                          fontSize: 12,
                          letterSpacing: 0.6,
                          color: secondaryTeal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // 5. Contact Info
              HotelUnderlineTitle(
                titleKey: 'Contact Info',
                color: secondaryTeal,
              ),
              const SizedBox(height: 12),
              HotelContactTile(
                phoneNumber: hotel.phone,
                primaryTeal: primaryTeal,
                secondaryTeal: secondaryTeal,
              ),
              const SizedBox(height: 24),

              // 6. Rooms Section
              // HotelUnderlineTitle(titleKey: 'Rooms', color: secondaryTeal),
              BlocBuilder<HotelRoomsFilterCubit, HotelRoomsFilterState>(
                builder: (context, filterState) {
                  // Check if a filter is currently successfully applied
                  final isFilterApplied = filterState.maybeWhen(
                    success: (_) => true,
                    orElse: () => false,
                  );

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HotelUnderlineTitle(
                        titleKey: 'Rooms',
                        color: secondaryTeal,
                      ),
                      if (isFilterApplied)
                        TextButton.icon(
                          onPressed: () {
                            // Reset the cubit state back to initial
                            context.read<HotelRoomsFilterCubit>().resetFilter();
                          },
                          icon: Icon(
                            Icons.clear,
                            size: 18,
                            color: secondaryTeal,
                          ),
                          label: Text(
                            context.tr(
                              'clear_filter',
                            ), // Add this to your localization files
                            style: TextStyle(
                              color: secondaryTeal,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 14),

              // Wrap ONLY the rooms list in a BlocBuilder
              BlocBuilder<HotelRoomsFilterCubit, HotelRoomsFilterState>(
                builder: (context, filterState) {
                  return filterState.maybeWhen(
                    loading: () => const Center(
                      child: Padding(
                        padding: EdgeInsets.all(24.0),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    error: (message) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        message,
                        style: const TextStyle(color: Colors.redAccent),
                      ),
                    ),
                    success: (filteredRooms) => _buildRoomsList(
                      context,
                      filteredRooms,
                      secondaryTeal,
                      hotel.name,
                    ),
                    // If no filter is applied yet (initial state), show default rooms
                    orElse: () => _buildRoomsList(
                      context,
                      hotel.rooms,
                      secondaryTeal,
                      hotel.name,
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),

              // 7. Guest Reviews Section
              HotelUnderlineTitle(
                titleKey: 'Guest Reviews',
                color: secondaryTeal,
              ),
              const SizedBox(height: 14),
              if (hotel.reviews.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(context.tr('No Reviews Yet')),
                )
              else
                SizedBox(
                  height: 160,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: hotel.reviews.length,
                    separatorBuilder: (context, _) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      return HotelReviewCard(
                        review: hotel.reviews[index],
                        primaryTeal: primaryTeal,
                      );
                    },
                  ),
                ),
              const SizedBox(height: 24),

              // 8. Things to Know Section
              HotelUnderlineTitle(
                titleKey: 'Things To Know',
                color: secondaryTeal,
              ),
              const SizedBox(height: 14),
              HotelThingsToKnowList(policies: hotel.thingsToKnow),
            ],
          ),

          // Bottom Floating Bar
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: cardBgColor,
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                    border: isHighContrast
                        ? Border.all(color: Colors.white, width: 1.5)
                        : null,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 54,
                        height: 54,
                        decoration: BoxDecoration(
                          color: isHighContrast
                              ? Colors.yellow
                              : const Color(0xFF006653),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ConversationScreen(),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.chat_bubble_outline_rounded,
                            color: isHighContrast ? Colors.black : Colors.white,
                            size: 21,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: SizedBox(
                          height: 54,
                          child: ElevatedButton(
                            // onPressed: () {
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (_) => const ReserveYourStayScreen(),
                            //     ),
                            //   );
                            // },
                            onPressed: () async {
                              // Await the filter result from the next screen/bottom sheet
                              final selectedFilter =
                                  await Navigator.push<RoomFilterModel>(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const RoomFilterScreen(
                                        
                                      ),
                                      // Ensure this screen pops with: Navigator.pop(context, roomFilterModel);
                                    ),
                                  );

                              // If the user applied a filter and didn't just swipe back
                              if (selectedFilter != null && context.mounted) {
                                context
                                    .read<HotelRoomsFilterCubit>()
                                    .fetchFilteredRooms(
                                      hotel.id,
                                      selectedFilter,
                                    );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isHighContrast
                                  ? Colors.black
                                  : const Color(0xFF63D3FF),
                              foregroundColor: isHighContrast
                                  ? Colors.yellow
                                  : const Color(0xFF231F20),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              side: isHighContrast
                                  ? const BorderSide(
                                      color: Colors.yellow,
                                      width: 1.5,
                                    )
                                  : null,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.tune_rounded, size: 20),
                                const SizedBox(width: 8),
                                Text(
                                  context.tr('filter_options'),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 14,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
