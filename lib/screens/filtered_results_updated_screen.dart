import 'package:flutter/material.dart';

import '../constance/app_colors.dart';
import '../state/favorites_scope.dart';
import '../state/favorites_store.dart';
import '../widgets/byma_bottom_nav.dart';
import 'bookings_screen.dart';
import 'filters_advanced_screen.dart';
import 'hotel_details_screen.dart';
import 'main_layout_screen.dart';
import 'messages_final_navigation.dart';
import 'reserve_your_stay_screen.dart';
import 'settings_refined_screen.dart';

class CuratedStaysScreen extends StatelessWidget {
  final String? location;
  final DateTimeRange? dateRange;

  const CuratedStaysScreen({
    super.key,
    this.location,
    this.dateRange,
  });

  Widget _buildHotelCard({
    required BuildContext context,
    required String imageUrl,
    required String title,
    required String subtitle,
    required double rating,
    required double price,
    required String nightsLabel,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.98),
        borderRadius: BorderRadius.circular(26),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(26),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HotelDetailsScreen(
                      title: title,
                      imageUrl: imageUrl,
                    ),
                  ),
                );
              },
              child: SizedBox(
                height: 165,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(26),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF3F6),
                          border: Border.all(
                            color: const Color(0xFFD9E2E8),
                            width: 1.2,
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.image_outlined, size: 38, color: Color(0xFFB7C3CB)),
                              SizedBox(height: 6),
                              Text(
                                'Photo placeholder',
                                style: TextStyle(
                                  color: Color(0xFF7E8A95),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        right: 15,
                        top: 15,
                        child: AnimatedBuilder(
                          animation: FavoritesScope.of(context),
                          builder: (context, _) {
                            final isFav = FavoritesScope.of(context).isFavorite(title);
                            return InkWell(
                              borderRadius: BorderRadius.circular(999),
                              onTap: () {
                                FavoritesScope.of(context).toggleFavorite(
                                  FavoriteItem(
                                    id: title,
                                    title: title,
                                    subtitle: subtitle,
                                    rating: rating.toString(),
                                    fromText: '',
                                    price: '\$${price.toInt()}/night',
                                    ctaText: '',
                                    imageAsset: '',
                                    compactBadge: null,
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.75),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  isFav ? Icons.favorite_rounded : Icons.favorite_border,
                                  color: isFav ? const Color(0xFF0FA37A) : const Color(0xFF0F4A42),
                                  size: 20,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 14, 18, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.kTextColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 10),
                      _RatingChip(rating: rating),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.kSubTextColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _PriceBlock(price: price, nightsLabel: nightsLabel),
                      const Spacer(),
                      _BookNowButton(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final topPad = media.padding.top;

    return Scaffold(
      backgroundColor: AppTheme.kBackgroundColor,
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.fromLTRB(16, topPad + 6, 16, 10),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(18),
                      onTap: () => Navigator.maybePop(context),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF4F8F8),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Icon(Icons.arrow_back_ios_new, size: 18, color: AppTheme.kTextColor),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Curated Stays',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: AppTheme.kTextColor,
                              letterSpacing: -0.2,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Hand-picked stays for your trip',
                            style: TextStyle(
                              fontSize: 11,
                              color: AppTheme.kSubTextColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF4F8F8),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.notifications_none_outlined, size: 20, color: AppTheme.kTextColor),
                    ),
                  ],
                ),
              ),
            ),

            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 6, 18, 0),
                child: ListView(
                  padding: const EdgeInsets.only(bottom: 90),
                  children: [
                    // Destination card
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: AppTheme.kPrimaryColor.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: AppTheme.kPrimaryColor.withValues(alpha: 0.18),
                          width: 1.2,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'DESTINATION',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 1.1,
                                    color: AppTheme.kPrimaryColor,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Amalfi Coast, Italy',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w900,
                                    color: AppTheme.kTextColor,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Oct 12 — Oct 18 • 2 Guests',
                                  style: const TextStyle(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.kSubTextColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            borderRadius: BorderRadius.circular(18),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const FiltersScreen(),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 18),
                              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                              decoration: BoxDecoration(
                                color: AppTheme.kPrimaryColor,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: const Text(
                                'MODIFY',
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.4,
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Hotel cards
                    _buildHotelCard(
                      context: context,
                      imageUrl:
                          'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?auto=format&fit=crop&w=1200&q=80',
                      title: 'Sea View Suite',
                      subtitle: 'Grand Miramare Resort • Positano',
                      rating: 4.9,
                      price: 420,
                      nightsLabel: '/night',
                    ),
                    _buildHotelCard(
                      context: context,
                      imageUrl:
                          'https://images.unsplash.com/photo-1500375592092-40eb2168fd21?auto=format&fit=crop&w=1200&q=80',
                      title: 'Panoramic Penthouse',
                      subtitle: 'Grand Miramare Resort • Positano',
                      rating: 4.9,
                      price: 850,
                      nightsLabel: '/night',
                    ),
                    _buildHotelCard(
                      context: context,
                      imageUrl:
                          'https://images.unsplash.com/photo-1505691938895-1758d7feb511?auto=format&fit=crop&w=1200&q=80',
                      title: 'Terrace Double',
                      subtitle: 'Azurea Cliffside Villa • Praiano',
                      rating: 4.8,
                      price: 310,
                      nightsLabel: '/night',
                    ),
                  ],
                ),
              ),
            ),

            BymaBottomNav(
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
          ],
        ),
      ),
    );
  }
}

class _RatingChip extends StatelessWidget {
  final double rating;
  const _RatingChip({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.kSecondaryColor.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: AppTheme.kSecondaryColor.withValues(alpha: 0.55),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.star, size: 14, color: Colors.white),
          const SizedBox(width: 4),
          Text(
            rating.toStringAsFixed(1),
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 13,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black,
                  blurRadius: 10,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PriceBlock extends StatelessWidget {
  final double price;
  final String nightsLabel;

  const _PriceBlock({
    required this.price,
    required this.nightsLabel,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontWeight: FontWeight.w800,
          color: AppTheme.kPrimaryColor,
          fontSize: 22,
        ),
        children: [
          TextSpan(
            text: '\$${price.toInt()}',
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 22,
              color: AppTheme.kPrimaryColor,
            ),
          ),
          TextSpan(
            text: nightsLabel,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: AppTheme.kSubTextColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _BookNowButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const ReserveYourStayScreen(),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: AppTheme.kPrimaryColor,
          borderRadius: BorderRadius.circular(18),
        ),
        child: const Text(
          'BOOK NOW',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: Colors.white,
            fontSize: 14,
            letterSpacing: 0.2,
          ),
        ),
      ),
    );
  }
}

