import 'package:byma_app/business_logic/add_recently_viewed_room/cubit/add_recently_viewed_room_cubit.dart';
import 'package:byma_app/business_logic/add_room_to_collection/cubit/add_room_to_collection_cubit.dart';
import 'package:byma_app/business_logic/add_room_to_collection/cubit/add_room_to_collection_state.dart';
import 'package:byma_app/business_logic/collection/cubit/collection_cubit.dart';
import 'package:byma_app/business_logic/collection/cubit/collection_state.dart';
import 'package:byma_app/business_logic/create_collection/cubit/create_collection_cubit.dart';
import 'package:byma_app/business_logic/create_collection/cubit/create_collection_state.dart';
import 'package:byma_app/business_logic/favorite_rooms/cubit/favorite_rooms_cubit.dart';
import 'package:byma_app/business_logic/toggle_favorite_rooms/cubit/toggle_favorite_rooms_cubit.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:byma_app/data/models/hotel_amenity_model.dart';
import 'package:byma_app/data/models/review_model.dart';
import 'package:byma_app/data/models/room_model.dart';
import 'package:byma_app/screens/room_details_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

// ---------------------------------------------------------
// 1. Hero Image Widget (Swipable Carousel for All Server Images)
// ---------------------------------------------------------
class HotelHeroImage extends StatefulWidget {
  final List<String> imageUrls;
  final Color secondaryTeal;

  const HotelHeroImage({
    super.key,
    required this.imageUrls,
    required this.secondaryTeal,
  });

  @override
  State<HotelHeroImage> createState() => _HotelHeroImageState();
}

class _HotelHeroImageState extends State<HotelHeroImage> {
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final images = widget.imageUrls.isNotEmpty
        ? widget.imageUrls
        : ['https://via.placeholder.com/600x400'];

    return ClipRRect(
      borderRadius: BorderRadius.circular(26),
      child: Container(
        height: 235,
        decoration: BoxDecoration(
          border: Border.all(color: theme.dividerColor, width: 0.8),
        ),
        child: Stack(
          children: [
            // 1. Swipable PageView for all server images
            Positioned.fill(
              child: PageView.builder(
                controller: _pageController,
                itemCount: images.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Image.network(
                    images[index],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Center(
                      child: Icon(Icons.image_not_supported_outlined, size: 40),
                    ),
                  );
                },
              ),
            ),

            // 2. Dot Indicators (Visible when there are multiple images)
            if (images.length > 1)
              Positioned(
                right: 16,
                bottom: 20,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    images.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: _currentPage == index ? 16 : 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? Colors.white
                            : Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
// 2. Ratings & Title Row (Dynamic Rating & Address)
// ---------------------------------------------------------
class HotelRatingsRow extends StatelessWidget {
  final Color secondaryTeal;
  final String title;
  final num rating;
  final String address;

  const HotelRatingsRow({
    super.key,
    required this.secondaryTeal,
    required this.title,
    required this.rating,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.star, size: 18, color: secondaryTeal),
            const SizedBox(width: 6),
            Text(
              rating.toStringAsFixed(1),
              style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
            ),
            const SizedBox(width: 12),
            Icon(Icons.location_on_outlined, size: 18, color: secondaryTeal),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                address,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12.5,
                  height: 1.05,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ---------------------------------------------------------
// 3. Section Title with Underline
// ---------------------------------------------------------
class HotelUnderlineTitle extends StatelessWidget {
  final String titleKey;
  final Color color;

  const HotelUnderlineTitle({
    super.key,
    required this.titleKey,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.remove_circle_outline, color: color, size: 18),
            const SizedBox(width: 10),
            Text(
              context.tr(titleKey),
              style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          height: 3,
          width: 56,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(999),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------
// 4. Amenities Grid Widget (Dynamic API Models)
// ---------------------------------------------------------
class HotelAmenitiesGrid extends StatelessWidget {
  final Color teal;
  final List<HotelAmenityModel> amenities;

  const HotelAmenitiesGrid({
    super.key,
    required this.teal,
    required this.amenities,
  });

  IconData _mapAmenityIcon(String? name) {
    final lower = (name ?? '').toLowerCase();
    if (lower.contains('wifi')) return Icons.wifi;
    if (lower.contains('pool')) return Icons.pool;
    if (lower.contains('chef') ||
        lower.contains('food') ||
        lower.contains('restaurant')) {
      return Icons.restaurant_outlined;
    }
    if (lower.contains('ac') ||
        lower.contains('climate') ||
        lower.contains('air')) {
      return Icons.ac_unit_outlined;
    }
    if (lower.contains('gym') || lower.contains('fitness'))
      return Icons.fitness_center;
    return Icons.check_circle_outline;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (amenities.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(context.tr('No Amenities Available')),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: amenities.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 2.2,
      ),
      itemBuilder: (context, i) {
        final item = amenities[i];
        // Replace `.name` below with the actual property name in your HotelAmenityModel
        final amenityName = item.amenity.name;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: theme.dividerColor),
          ),
          child: Row(
            children: [
              Icon(_mapAmenityIcon(amenityName), size: 22, color: teal),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  amenityName.toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 10,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------
// 5. Check-in / Check-out Time Card
// ---------------------------------------------------------
class HotelTimeCard extends StatelessWidget {
  final IconData icon;
  final String labelKey;
  final String time;
  final Color primaryColor;

  const HotelTimeCard({
    super.key,
    required this.icon,
    required this.labelKey,
    required this.time,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        children: [
          Icon(icon, color: primaryColor, size: 28),
          const SizedBox(height: 8),
          Text(
            context.tr(labelKey).toUpperCase(),
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            time,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------
// 6. Location Card Widget
// ---------------------------------------------------------
class HotelLocationCard extends StatelessWidget {
  final Color secondaryTeal;
  final double latitude;
  final double longitude;

  const HotelLocationCard({
    super.key,
    required this.secondaryTeal,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hotelLocation = LatLng(latitude, longitude);

    return Container(
      height: 220,
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: theme.dividerColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(21),
        child: FlutterMap(
          options: MapOptions(
            initialCenter: hotelLocation,
            initialZoom: 15.0,
            interactionOptions: const InteractionOptions(
              flags: InteractiveFlag.all,
            ),
          ),
          children: [
            TileLayer(
              // Using subdomain {s} improves tile loading reliability
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: const ['a', 'b', 'c'],
              userAgentPackageName: 'com.example.bayma_app',
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: hotelLocation,
                  width: 46,
                  height: 46,
                  child: Container(
                    decoration: BoxDecoration(
                      color: secondaryTeal,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: secondaryTeal.withOpacity(0.4),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
// 7. Contact (Phone) Tile
// ---------------------------------------------------------
class HotelContactTile extends StatelessWidget {
  final String phoneNumber;
  final Color primaryTeal;
  final Color secondaryTeal;

  const HotelContactTile({
    super.key,
    required this.phoneNumber,
    required this.primaryTeal,
    required this.secondaryTeal,
  });

  Future<void> _copyPhoneToClipboard(BuildContext context) async {
    if (phoneNumber.trim().isEmpty) return;

    await Clipboard.setData(ClipboardData(text: phoneNumber.trim()));
    await HapticFeedback.lightImpact();

    if (context.mounted) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.tr('Copied to Clipboard')),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _callPhoneNumber(BuildContext context) async {
    if (phoneNumber.trim().isEmpty) return;

    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber.trim());
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(context.tr('Not Available'))));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasPhone = phoneNumber.trim().isNotEmpty;
    final displayPhone = hasPhone ? phoneNumber : context.tr('Not Available');

    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Material(
        color: Colors.transparent,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 4,
          ),
          onTap: hasPhone ? () => _callPhoneNumber(context) : null,
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: primaryTeal.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.phone_in_talk_rounded, color: primaryTeal),
          ),
          title: Text(
            displayPhone,
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
          ),
          subtitle: Text(
            context.tr('Reception Desk'),
            style: TextStyle(
              fontSize: 12,
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
          trailing: hasPhone
              ? IconButton(
                  tooltip: context.tr('copy'),
                  icon: Icon(
                    Icons.content_copy_rounded,
                    color: secondaryTeal,
                    size: 20,
                  ),
                  onPressed: () => _copyPhoneToClipboard(context),
                )
              : null,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
// 8. Room Card Widget (Uses RoomModel + Favorites Integration)
// ---------------------------------------------------------
class HotelRoomCard extends StatelessWidget {
  final RoomModel room;
  final Color secondaryTeal;
  final String hotelName;

  const HotelRoomCard({
    super.key,
    required this.room,
    required this.secondaryTeal,
    required this.hotelName,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Strongly-typed getters from RoomModel
    final String title = room.category.name;
    final String priceText = '${room.price}\$';
    final double parsedPrice = room.price.toDouble();
    final String imageUrl = room.imageUrls.first;
    final bool isNetworkImage = imageUrl.startsWith('http');

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: theme.dividerColor.withOpacity(0.4)),
      ),
      color: theme.cardColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () {
          // final parsedRoomId = int.parse(room.id.toString());
          // 1. Trigger the API call in the background (fire-and-forget)
          context.read<AddRecentlyViewedRoomsCubit>().addRecentlyViewed(
            room.id,
          );
          // 2. Navigate immediately to the Room Details Screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => RoomDetailsScreen(roomId: room.id),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: isNetworkImage
                    ? Image.network(
                        imageUrl,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            _buildFallbackIcon(theme),
                      )
                    : Image.asset(
                        imageUrl,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            _buildFallbackIcon(theme),
                      ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title Row + Favorite Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 15,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildAddToCollectionButton(context),
                            const SizedBox(width: 4),
                            _buildFavoriteButton(context),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          textBaseline: TextBaseline.alphabetic,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: [
                            Text(
                              priceText,
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: secondaryTeal,
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              ' /${context.tr('night')}',
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 14,
                          color: secondaryTeal,
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
    );
  }

  // ---------------------------------------------------------
  // Favorite Button Builder with Optimistic + Async Logic
  // ---------------------------------------------------------
  Widget _buildFavoriteButton(BuildContext context) {
    return BlocBuilder<FavoriteRoomsCubit, FavoriteRoomsState>(
      builder: (context, state) {
        bool isFav = false;
        int? favoriteRecordId;

        state.whenOrNull(
          success: (favoriteRooms) {
            for (final fav in favoriteRooms) {
              // Note: Change 'fav.room.id' to 'fav.roomId' if your FavoriteRoomModel stores the ID directly
              if (fav.room.id == room.id) {
                isFav = true;
                favoriteRecordId = fav.id;
                break;
              }
            }
          },
        );

        return Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () async {
              if (isFav && favoriteRecordId != null) {
                // 1. Optimistic UI Update: Immediately remove from local list
                context.read<FavoriteRoomsCubit>().removeRoomOptimistically(
                  favoriteRecordId!,
                );

                // 2. Backend Deletion
                context.read<ToggleFavoriteRoomsCubit>().removeFavorite(
                  favoriteRecordId!,
                );
              } else if (!isFav) {
                // 1. Backend Addition
                await context.read<ToggleFavoriteRoomsCubit>().addFavorite(
                  room.id,
                );

                // 2. List Synchronization: Re-fetch updated list
                if (context.mounted) {
                  context.read<FavoriteRoomsCubit>().getFavoriteRooms();
                }
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(
                isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                color: isFav ? Colors.redAccent : secondaryTeal,
                size: 22,
              ),
            ),
          ),
        );
      },
    );
  }

  // ---------------------------------------------------------
  // Add to Collection Button Builder
  // ---------------------------------------------------------
  Widget _buildAddToCollectionButton(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          // final parsedRoomId = int.parse(room.id.toString());
          
          // // Trigger the exact same Add-to-Collection Bottom Sheet used in the Home Screen
          // showModalBottomSheet(
          //   context: context,
          //   isScrollControlled: true,
          //   backgroundColor: Colors.transparent,
          //   builder: (_) => AddToCollectionBottomSheet(
          //     roomId: parsedRoomId,
          //   ),
          // );

          // Use the helper function that wraps the sheet in MultiBlocProvider
          showAddToCollectionSheet(context, room.id);
        },
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Icon(
            Icons.bookmark_border_rounded, // Or Icons.bookmark_add_outlined
            color: secondaryTeal,
            size: 22,
          ),
        ),
      ),
    );
  }

  Widget _buildFallbackIcon(ThemeData theme) {
    return Container(
      width: 100,
      height: 100,
      color: theme.disabledColor.withOpacity(0.1),
      child: const Icon(Icons.king_bed_outlined),
    );
  }
}

// ---------------------------------------------------------
// 9. Guest Review Card Widget (Uses ReviewModel)
// ---------------------------------------------------------
class HotelReviewCard extends StatelessWidget {
  final ReviewModel review;
  final Color primaryTeal;

  const HotelReviewCard({
    super.key,
    required this.review,
    required this.primaryTeal,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Strongly-typed accesses from ReviewModel
    final String reviewerName = 'Guest #${review.id}';
    final double ratingValue = review.rate.toDouble();
    final String comment = review.comment ?? '';
    final String dateStr = DateFormat('yyyy-MM-dd').format(review.createdAt);

    return Container(
      width: 280,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                reviewerName,
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 15,
                ),
              ),
              Row(
                children: [
                  Icon(Icons.star_rounded, color: primaryTeal, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    ratingValue.toStringAsFixed(1),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 4),
          if (dateStr.isNotEmpty)
            Text(
              dateStr,
              style: TextStyle(
                fontSize: 11,
                color: theme.colorScheme.onSurface.withOpacity(0.5),
              ),
            ),
          const SizedBox(height: 12),
          Expanded(
            child: Text(
              comment.isNotEmpty ? comment : context.tr('No Comment'),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 13, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------
// 10. Things to Know Section
// ---------------------------------------------------------
class HotelThingsToKnowList extends StatelessWidget {
  final String? policies;

  const HotelThingsToKnowList({super.key, this.policies});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool hasPolicies = policies != null && policies!.trim().isNotEmpty;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: theme.colorScheme.onSurface.withOpacity(0.7),
            size: 22,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              hasPolicies ? policies! : context.tr('No Policies Available'),
              style: TextStyle(
                fontSize: 13.5,
                color: theme.colorScheme.onSurface.withOpacity(0.8),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 11. ADD TO COLLECTION BOTTOM SHEET
// ==========================================
void showAddToCollectionSheet(BuildContext context, int roomId) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (sheetContext) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                CollectionCubit(context.read())..fetchAllCollections(),
          ),
          BlocProvider(
            create: (context) => CreateCollectionCubit(context.read()),
          ),
          BlocProvider(
            create: (context) => AddRoomToCollectionCubit(context.read()),
          ),
        ],
        child: AddToCollectionSheetBody(roomId: roomId),
      );
    },
  );
}

class AddToCollectionSheetBody extends StatelessWidget {
  final int roomId;

  const AddToCollectionSheetBody({super.key, required this.roomId});

  void _showTopSnackBar(
    BuildContext context,
    String message,
    Color backgroundColor,
  ) {
    final screenHeight = MediaQuery.of(context).size.height;
    final topMargin = screenHeight - 150;

    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.up,
        margin: EdgeInsets.only(bottom: topMargin, left: 20, right: 20),
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDarkMode ? Colors.white : const Color(0xFF0F4A42);

    return MultiBlocListener(
      listeners: [
        BlocListener<AddRoomToCollectionCubit, AddRoomToCollectionState>(
          listener: (context, state) {
            state.whenOrNull(
              success: () {
                Navigator.pop(context);
                _showTopSnackBar(context, 'Saved to collection!', Colors.green);
              },
              error: (message) {
                _showTopSnackBar(context, message, Colors.red);
              },
            );
          },
        ),
        BlocListener<CreateCollectionCubit, CreateCollectionState>(
          listener: (context, state) {
            state.whenOrNull(
              success: () {
                context.read<CollectionCubit>().fetchAllCollections();
                _showTopSnackBar(
                  context,
                  'Collection created successfully!',
                  Colors.green,
                );
              },
              error: (message) {
                _showTopSnackBar(context, message, Colors.red);
              },
            );
          },
        ),
      ],
      child: Container(
        height: MediaQuery.of(context).size.height * 0.55,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Save to collection',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                TextButton.icon(
                  onPressed: () => _showCreateCollectionDialog(context),
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text(
                    'Create Collection',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            Expanded(
              child: BlocBuilder<CollectionCubit, CollectionState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => const SizedBox.shrink(),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (message) => Center(
                      child: Text(
                        message,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                    success: (collections) {
                      if (collections.isEmpty) {
                        return Center(
                          child: Text(
                            'No collections yet. Create one now!',
                            style: TextStyle(
                              color: textColor.withOpacity(0.6),
                              fontSize: 14,
                            ),
                          ),
                        );
                      }

                      return ListView.separated(
                        itemCount: collections.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final collectionItem = collections[index];
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: textColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.bookmark_border_rounded,
                                color: textColor,
                              ),
                            ),
                            title: Text(
                              collectionItem.name,
                              style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                            trailing:
                                BlocBuilder<
                                  AddRoomToCollectionCubit,
                                  AddRoomToCollectionState
                                >(
                                  builder: (context, addState) {
                                    final isLoading = addState.maybeWhen(
                                      loading: () => true,
                                      orElse: () => false,
                                    );
                                    return isLoading
                                        ? const SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                            ),
                                          )
                                        : Icon(
                                            Icons.chevron_right_rounded,
                                            color: textColor.withOpacity(0.5),
                                          );
                                  },
                                ),
                            onTap: () {
                              context
                                  .read<AddRoomToCollectionCubit>()
                                  .addRoomToCollection(
                                    collectionItem.id,
                                    roomId,
                                  );
                            },
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCreateCollectionDialog(BuildContext parentContext) {
    final textController = TextEditingController();

    showDialog(
      context: parentContext,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('New Collection'),
          content: TextField(controller: textController, autofocus: true),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final name = textController.text.trim();
                if (name.isNotEmpty) {
                  parentContext.read<CreateCollectionCubit>().createCollection(
                    name,
                  );
                  Navigator.pop(dialogContext);
                }
              },
              child: const Text('Create'),
            ),
          ],
        );
      },
    );
  }
}
