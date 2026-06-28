import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'payment_screen.dart';

import '../state/favorites_scope.dart';
import '../state/favorites_store.dart';

class RoomDetailsScreen extends StatelessWidget {
  final String roomTitle;
  final String pricePerNight;

  const RoomDetailsScreen({
    super.key,
    required this.roomTitle,
    required this.pricePerNight,
  });

  @override
  Widget build(BuildContext context) {
    const teal = Color(0xFF0E6F63);
    const teal2 = Color(0xFF0FA37A);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'room_details_title'.tr(),
          style: const TextStyle(fontWeight: FontWeight.w900, color: Colors.black),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_border, color: Colors.black),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 10, 18, 24),
          children: [
            // Image / carousel (static)
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: AspectRatio(
                aspectRatio: 16 / 10,
                child: Stack(
                  children: [
                    Container(
                      color: Colors.black12,
                      child: const Center(
                        child: Icon(Icons.hotel, size: 72, color: Colors.black26),
                      ),
                    ),
                    // left/right arrows
                    Positioned(
                      left: 10,
                      top: 90,
                      child: const _CircleArrow(icon: Icons.chevron_left),
                    ),
                    Positioned(
                      right: 10,
                      top: 90,
                      child: const _CircleArrow(icon: Icons.chevron_right),
                    ),

                    // heart button inside photo
                    Positioned(
                      right: 14,
                      top: 14,
                      child: AnimatedBuilder(
                        animation: FavoritesScope.of(context),
                        builder: (context, _) {
                          final store = FavoritesScope.of(context);
                          final isFav = store.isFavorite(roomTitle);
                          return GestureDetector(
                            onTap: () {
                              final item = FavoriteItem(
                                id: roomTitle,
                                title: roomTitle,
                                subtitle: 'room_details_title'.tr(),
                                rating: '4.9',
                                fromText: '',
                                price: '\$${pricePerNight.replaceAll(RegExp(r'[^0-9.]'), '')}/${'per_night_short'.tr()}',
                                ctaText: '',
                                imageAsset: '',
                                compactBadge: null,
                              );
                              store.toggleFavorite(item);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.75),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                isFav ? Icons.favorite_rounded : Icons.favorite_border,
                                color: teal,
                                size: 20,
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    Positioned(
                      right: 14,
                      bottom: 14,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          'photos_count'.tr(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 14),

            // Premium tag
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    color: const Color(0xFF2FE3CF).withOpacity(0.18),
                    border: Border.all(color: teal.withOpacity(0.18), width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Text(
                    'premium_experience_tag'.tr(),
                    style: const TextStyle(
                      color: teal,
                      fontWeight: FontWeight.w900,
                      fontSize: 11,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Room dynamic title
            Text(
              roomTitle,
              style: const TextStyle(
                fontSize: 28,
                height: 1.08,
                fontWeight: FontWeight.w900,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 10),

            // Price row
            Row(
              children: [
                Text(
                  pricePerNight,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 28,
                    color: teal2,
                  ),
                ),
                const Spacer(),
                Text(
                  'per_night_label'.tr(),
                  style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w800, fontSize: 11),
                )
              ],
            ),

            const SizedBox(height: 14),

            // Feature chips
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: teal.withOpacity(0.22), width: 1.2),
              ),
              child: Row(
                children: [
                  _InfoChip(icon: Icons.person, text: 'guests_count_chip'.tr()),
                  const SizedBox(width: 10),
                  _InfoChip(icon: Icons.square_foot, text: 'room_size_chip'.tr()),
                  const SizedBox(width: 10),
                  _InfoChip(icon: Icons.king_bed, text: 'bed_type_chip'.tr()),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // Experience / Description
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: teal.withOpacity(0.35), width: 1.2),
              ),
              child: Text(
                'room_description_text'.tr(),
                style: TextStyle(
                  color: Colors.black54.withOpacity(0.95),
                  height: 1.55,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Services & Features Header
            _SectionHeader(title: 'services_features_title'.tr(), teal: teal),
            const SizedBox(height: 12),

            // Two cards
            Row(
              children: [
                Expanded(
                  child: _ServiceTile(
                    icon: Icons.bathtub_outlined,
                    title: 'service_balcony_title'.tr(),
                    subtitle: 'service_balcony_sub'.tr(),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _ServiceTile(
                    icon: Icons.wifi,
                    title: 'service_smart_title'.tr(),
                    subtitle: 'service_smart_sub'.tr(),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Review highlight
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: teal),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.star_rounded, color: teal2, size: 18),
                      const Icon(Icons.star_rounded, color: teal2, size: 18),
                      const Icon(Icons.star_rounded, color: teal2, size: 18),
                      const Icon(Icons.star_rounded, color: teal2, size: 18),
                      const Icon(Icons.star_rounded, color: teal2, size: 18),
                      const SizedBox(width: 10),
                      Text(
                        'reviews_score_label'.tr(),
                        style: const TextStyle(fontWeight: FontWeight.w900, color: teal),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'review_quote_text'.tr(),
                    style: const TextStyle(fontStyle: FontStyle.italic, color: Colors.black54, height: 1.5, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // Special Requests Section
            _SectionHeader(title: 'special_requests_title'.tr(), teal: teal),
            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: teal2.withOpacity(0.5), width: 1.2),
                color: teal2.withOpacity(0.06),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        backgroundColor: teal,
                        radius: 24,
                        child: Icon(Icons.info, color: Colors.white),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          'special_requests_info'.tr(),
                          style: TextStyle(
                            color: Colors.black54.withOpacity(0.95),
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
                          MaterialPageRoute(
                            builder: (_) => FinalizeReservationScreen(
                              roomTitle: roomTitle,
                              pricePerNight: pricePerNight,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: teal,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'contact_support_btn'.tr(),
                            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 14, color: Colors.white),
                          ),
                          const SizedBox(width: 14),
                          const Icon(Icons.chat_bubble_outline_rounded, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 26),

            // Reserve button
            SizedBox(
              height: 54,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FinalizeReservationScreen(
                        roomTitle: roomTitle,
                        pricePerNight: pricePerNight,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlueAccent.withOpacity(0.75),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                ),
                child: Text(
                  'reserve_room_btn'.tr(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                    color: Colors.white,
                    letterSpacing: 0.2,
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

class _CircleArrow extends StatelessWidget {
  final IconData icon;
  const _CircleArrow({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.25),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.white),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InfoChip({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16, color: const Color(0xFF0E6F63)),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                  fontSize: 12.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final Color teal;

  const _SectionHeader({
    required this.title,
    required this.teal,
  });

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
        )
      ],
    );
  }
}

class _ServiceTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _ServiceTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFF0FA37A).withOpacity(0.22),
          width: 1.2,
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFF0FA37A).withOpacity(0.12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF0FA37A),
              size: 22,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 14.5,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.black54.withOpacity(0.95),
              height: 1.35,
              fontWeight: FontWeight.w600,
              fontSize: 12.5,
            ),
          ),
        ],
      ),
    );
  }
}