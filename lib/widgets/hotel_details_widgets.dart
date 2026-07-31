import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:byma_app/data/models/hotel_amenity_model.dart';
import 'package:byma_app/data/models/review_model.dart';
import 'package:byma_app/data/models/room_model.dart';
import 'package:byma_app/screens/room_details_screen.dart';
import 'package:byma_app/screens/recently_viewed.dart';
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
    if (lower.contains('chef') || lower.contains('food') || lower.contains('restaurant')) {
      return Icons.restaurant_outlined;
    }
    if (lower.contains('ac') || lower.contains('climate') || lower.contains('air')) {
      return Icons.ac_unit_outlined;
    }
    if (lower.contains('gym') || lower.contains('fitness')) return Icons.fitness_center;
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
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w900,
            ),
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.tr('Not Available'))),
        );
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
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          onTap: hasPhone ? () => _callPhoneNumber(context) : null,
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: primaryTeal.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.phone_in_talk_rounded,
              color: primaryTeal,
            ),
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
// 8. Room Card Widget (Uses RoomModel)
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
          addRecentlyViewedItem(RecentlyViewedItem(
            id: 'room:$title',
            nameEn: title,
            nameAr: title,
            locationEn: hotelName,
            locationAr: hotelName,
            imageUrl: imageUrl,
            price: parsedPrice,
            type: RecentlyItemType.room,
          ));
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (_) => RoomDetailsScreen(
          //       roomTitle: title,
          //       pricePerNight: priceText,
          //       id: room.id.toString(),
          //     ),
          //   ),
          // );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => RoomDetailsScreen(
                roomId: int.parse(room.id.toString()),
              ),
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
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
                style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
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