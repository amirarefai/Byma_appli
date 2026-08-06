import 'package:byma_app/data/models/room_amenity_model.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:byma_app/screens/conversation_screen.dart';

class RoomStatusBadge extends StatelessWidget {
  final String status;

  const RoomStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final isAvailable = status.toLowerCase() == 'available' || status == 'متاح';
    final badgeColor = isAvailable ? Colors.green : Colors.orange;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: badgeColor.withOpacity(0.6), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: badgeColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            status,
            style: TextStyle(
              color: badgeColor,
              fontWeight: FontWeight.w800,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class RoomInfoChip extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;

  const RoomInfoChip({
    super.key,
    required this.icon,
    required this.text,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      width: double.infinity, // Stretches across the full column width
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.white10 : Colors.black12,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start, // Left-aligns icon and text
        children: [
          Icon(icon, size: 18, color: iconColor),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: theme.colorScheme.primary,
                fontSize: 13.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RoomSectionHeader extends StatelessWidget {
  final String title;
  final Color teal;

  const RoomSectionHeader({super.key, required this.title, required this.teal});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 16,
            color: teal,
          ),
        ),
        const Spacer(),
        Container(
          width: 54,
          height: 10,
          decoration: BoxDecoration(
            color: teal.withOpacity(0.14),
            borderRadius: BorderRadius.circular(999),
          ),
        ),
      ],
    );
  }
}

class RoomAmenitiesSection extends StatelessWidget {
  final List<RoomAmenityModel> amenities;
  final Color tealColor;

  const RoomAmenitiesSection({
    super.key,
    required this.amenities,
    required this.tealColor,
  });

  IconData _mapAmenityIcon(String? name) {
    final lower = (name ?? '').toLowerCase();
    if (lower.contains('wifi')) return Icons.wifi;
    if (lower.contains('tv')) return Icons.tv;
    if (lower.contains('pool')) return Icons.pool;
    if (lower.contains('chef') || lower.contains('food') || lower.contains('restaurant')) {
      return Icons.restaurant_outlined;
    }
    if (lower.contains('ac') || lower.contains('climate') || lower.contains('air')) {
      return Icons.ac_unit_outlined;
    }
    if (lower.contains('gym') || lower.contains('fitness')) return Icons.fitness_center;
    if (lower.contains('bath') || lower.contains('shower')) return Icons.bathroom_outlined;
    if (lower.contains('bed')) return Icons.bed_outlined;
    return Icons.check_circle_outline;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (amenities.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          'No Amenities Available'.tr(),
          style: TextStyle(
            color: theme.disabledColor,
            fontWeight: FontWeight.w600,
          ),
        ),
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
              Icon(_mapAmenityIcon(amenityName), size: 22, color: tealColor),
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


class SpecialRequestsCard extends StatelessWidget {
  final Color dynamicTeal;
  final Color dynamicTeal2;
  final Color textColor;
  final bool isHighContrast;

  const SpecialRequestsCard({
    super.key,
    required this.dynamicTeal,
    required this.dynamicTeal2,
    required this.textColor,
    required this.isHighContrast,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: dynamicTeal2.withOpacity(0.5), width: 1.2),
        color: isHighContrast ? Colors.black : dynamicTeal2.withOpacity(0.06),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: dynamicTeal,
                radius: 24,
                child: Icon(
                  Icons.info,
                  color: isHighContrast ? Colors.black : Colors.white,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  'special_requests_info'.tr(),
                  style: TextStyle(
                    color: textColor.withOpacity(0.9),
                    height: 1.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 52,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ConversationScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: dynamicTeal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
                side: isHighContrast
                    ? const BorderSide(color: Colors.white, width: 1.5)
                    : null,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'contact_support_btn'.tr(),
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                      color: isHighContrast ? Colors.black : Colors.white,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Icon(
                    Icons.chat_bubble_outline_rounded,
                    color: isHighContrast ? Colors.black : Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RoomPhotoCarousel extends StatefulWidget {
  final List<String> imageUrls;
  final bool isDarkMode;
  final bool isHighContrast;
  final Color activeColor;

  const RoomPhotoCarousel({
    super.key,
    required this.imageUrls,
    required this.isDarkMode,
    required this.isHighContrast,
    required this.activeColor,
  });

  @override
  State<RoomPhotoCarousel> createState() => _RoomPhotoCarouselState();
}

class _RoomPhotoCarouselState extends State<RoomPhotoCarousel> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasMultiplePhotos = widget.imageUrls.length > 1;

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: AspectRatio(
        aspectRatio: 16 / 10,
        child: Stack(
          children: [
            // 1. Photo PageView
            PageView.builder(
              controller: _pageController,
              itemCount: widget.imageUrls.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                final imageUrl = widget.imageUrls[index];
                final isAsset = imageUrl.startsWith('assets/');

                if (isAsset) {
                  return Image.asset(
                    imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  );
                }

                return Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: widget.isDarkMode
                          ? Colors.white10
                          : Colors.black12,
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: widget.isDarkMode
                          ? Colors.white10
                          : Colors.black12,
                      child: const Center(
                        child: Icon(
                          Icons.broken_image,
                          size: 48,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  },
                );
              },
            ),

            // 2. Dot Indicators (Bottom Center)
            if (hasMultiplePhotos)
              Positioned(
                bottom: 14,
                right: 14,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(widget.imageUrls.length, (index) {
                    final isSelected = _currentIndex == index;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: isSelected ? 20 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? widget.activeColor
                            : Colors.white.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  }),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
