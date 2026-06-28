import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart'; // مكتبة الترجمة

import '../state/favorites_scope.dart';
import '../state/favorites_store.dart';
import 'reserve_your_stay_screen.dart';

class HotelDetailsScreen extends StatelessWidget {
  final String title;
  final String imageUrl;

  const HotelDetailsScreen({
    super.key,
    required this.title,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    final primaryTeal = theme.colorScheme.primary; 
    final secondaryTeal = theme.colorScheme.secondary;
    final cardBgColor = theme.cardColor;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor ?? theme.scaffoldBackgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 6),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new, 
              color: theme.iconTheme.color, 
              size: 20
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: AnimatedBuilder(
              animation: FavoritesScope.of(context),
              builder: (context, _) {
                final isFav = FavoritesScope.of(context).isFavorite(title);
                return IconButton(
                  onPressed: () {
                    FavoritesScope.of(context).toggleFavorite(
                      FavoriteItem(
                        id: 'hotel:$imageUrl',
                        title: 'Hotel',
                        subtitle: 'Hotel',
                        rating: '4.9',
                        fromText: '',
                        price: '',
                        ctaText: '',
                        imageAsset: '',
                        compactBadge: null,
                      ),
                    );
                  },
                  icon: Icon(
                    isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                    size: 22,
                    color: isFav ? secondaryTeal : theme.iconTheme.color?.withOpacity(0.6),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
              children: [
                _HeroImage(secondaryTeal: secondaryTeal, imageUrl: imageUrl),
                const SizedBox(height: 12),
                _RatingsRow(secondaryTeal: secondaryTeal),
                const SizedBox(height: 10),
                _PriceRow(secondaryTeal: secondaryTeal),
                const SizedBox(height: 14),

                _UnderlineTitle(titleKey: 'premiumAmenities', color: secondaryTeal),
                const SizedBox(height: 10),
                _AmenitiesGrid(
                  teal: primaryTeal,
                  // تم إزالة const من هنا لإصلاح الإيرور
                  items: [
                    const _Amen(icon: Icons.waves_outlined, labelKey: 'infinityPool'),
                    const _Amen(icon: Icons.wifi, labelKey: 'ultraFastWifi'),
                    const _Amen(icon: Icons.restaurant_outlined, labelKey: 'privateChef'),
                    const _Amen(icon: Icons.ac_unit_outlined, labelKey: 'climateControl'),
                  ],
                ),
                const SizedBox(height: 20),

                _DescriptionCard(
                  teal: primaryTeal,
                  titleKey: 'descriptionTitle',
                  textKey: 'descriptionBody',
                ),
                const SizedBox(height: 20),

                _UnderlineTitle(titleKey: 'locationTitle', color: secondaryTeal),
                const SizedBox(height: 10),
                _LocationCard(secondaryTeal: secondaryTeal),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      backgroundColor: theme.canvasColor,
                      foregroundColor: secondaryTeal,
                      side: BorderSide(color: secondaryTeal.withOpacity(0.25)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                            color: secondaryTeal
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 22),

                _UnderlineTitle(titleKey: 'policyHighlights', color: secondaryTeal),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: cardBgColor,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: secondaryTeal.withOpacity(0.28), width: 1.4),
                  ),
                  child: _PolicyList(
                    secondaryTeal: secondaryTeal,
                    // تم إزالة const من هنا لإصلاح الإيرور
                    items: [
                      const _Policy(icon: Icons.check_circle_outline, titleKey: 'freeCancellationTitle', subtitleKey: 'freeCancellationSub'),
                      const _Policy(icon: Icons.swap_horiz_outlined, titleKey: 'checkInOutTitle', subtitleKey: 'checkInOutSub'),
                      const _Policy(icon: Icons.no_meeting_room_outlined, titleKey: 'houseRulesTitle', subtitleKey: 'houseRulesSub'),
                    ],
                  ),
                ),
                const SizedBox(height: 18),

                _UnderlineTitle(titleKey: 'guestReviews', color: secondaryTeal),
                const SizedBox(height: 10),
                _ReviewsHeader(secondaryTeal: secondaryTeal),
                const SizedBox(height: 12),
                _ReviewsRow(teal: primaryTeal, secondaryTeal: secondaryTeal),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      backgroundColor: theme.canvasColor,
                      side: BorderSide(color: theme.dividerColor),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                    child: Text(
                      context.tr('viewAllReviews'),
                      style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12),
                    ),
                  ),
                ),
                const SizedBox(height: 90),
              ],
            ),

            // كبسولة الحجز السفلية (كما هي تماماً في التصميم الأصلي)
            Align(
              alignment: Alignment.bottomCenter,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
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
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min, 
                      children: [
                        Container(
                          width: 54,
                          height: 54,
                          decoration: const BoxDecoration(
                            color: Color(0xFF006653), 
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.chat_bubble_outline_rounded,
                              color: Colors.white,
                              size: 21,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: SizedBox(
                            height: 54,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => const ReserveYourStayScreen()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF63D3FF), 
                                foregroundColor: const Color(0xFF231F20), 
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: Text(
                                context.tr('bookNow'),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  letterSpacing: 1.2,
                                ),
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
      ),
    );
  }
}

class _HeroImage extends StatelessWidget {
  final String imageUrl;
  final Color secondaryTeal;

  const _HeroImage({required this.imageUrl, required this.secondaryTeal});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(26),
      child: Container(
        height: 235,
        decoration: BoxDecoration(
          border: Border.all(color: theme.dividerColor, width: 0.8),
          gradient: LinearGradient(
            colors: [theme.disabledColor.withOpacity(0.1), theme.disabledColor.withOpacity(0.2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 16,
              top: 16,
              child: AnimatedBuilder(
                animation: FavoritesScope.of(context),
                builder: (context, _) {
                  final isFav = FavoritesScope.of(context).isFavorite('hotel:$imageUrl');
                  return Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(color: theme.canvasColor, shape: BoxShape.circle),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        FavoritesScope.of(context).toggleFavorite(
                          FavoriteItem(
                            id: 'hotel:$imageUrl',
                            title: 'Hotel',
                            subtitle: 'Hotel',
                            rating: '4.9',
                            fromText: '',
                            price: '',
                            ctaText: '',
                            imageAsset: '',
                            compactBadge: null,
                          ),
                        );
                      },
                      icon: Icon(
                        isFav ? Icons.favorite_rounded : Icons.favorite_border,
                        color: isFav ? secondaryTeal : theme.iconTheme.color,
                      ),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              left: 16,
              top: 98,
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: theme.canvasColor.withOpacity(0.82),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  icon: const Icon(Icons.chevron_left_rounded, size: 22),
                ),
              ),
            ),
            Positioned(
              right: 16,
              top: 98,
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: theme.canvasColor.withOpacity(0.82),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  icon: const Icon(Icons.chevron_right_rounded, size: 22),
                ),
              ),
            ),
            Positioned(
              right: 16,
              bottom: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  context.tr('photosCount'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                    letterSpacing: 0.4,
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

class _RatingsRow extends StatelessWidget {
  final Color secondaryTeal;
  const _RatingsRow({required this.secondaryTeal});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.star, size: 18, color: secondaryTeal),
        const SizedBox(width: 6),
        const Text('4.9', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15)),
        const SizedBox(width: 12),
        Icon(Icons.location_on_outlined, size: 18, color: secondaryTeal),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            context.tr('hotelLocation'),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12.5, height: 1.05),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
          decoration: BoxDecoration(
            color: secondaryTeal,
            borderRadius: BorderRadius.circular(999),
          ),
          child: const Row(
            children: [
              Text('500%', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 12)),
              SizedBox(width: 8),
              Icon(Icons.bolt_rounded, size: 16, color: Colors.white),
            ],
          ),
        ),
      ],
    );
  }
}

class _PriceRow extends StatelessWidget {
  final Color secondaryTeal;
  const _PriceRow({required this.secondaryTeal});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: secondaryTeal.withOpacity(0.18), width: 1),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('\$1,200', style: TextStyle(fontWeight: FontWeight.w900, color: secondaryTeal, fontSize: 20)),
                const SizedBox(height: 3),
                Text(context.tr('night'), style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12.5)),
                const SizedBox(height: 6),
                Text(
                  context.tr('instantBooking'),
                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 11.5, letterSpacing: 0.5),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          SizedBox(
            width: 130,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryTeal,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text(
                context.tr('availableNow'),
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 11.5, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}class _UnderlineTitle extends StatelessWidget {
  final String titleKey;
  final Color color;

  const _UnderlineTitle({
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

class _AmenitiesGrid extends StatelessWidget {
  final Color teal;
  final List<_Amen> items;

  const _AmenitiesGrid({required this.teal, required this.items});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.1,
      ),
      itemBuilder: (context, i) {
        final item = items[i];
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: theme.dividerColor),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(item.icon, size: 28, color: teal),
              const SizedBox(height: 10),
              Text(
                context.tr(item.labelKey).toUpperCase(), 
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 10.5, letterSpacing: 0.3),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Amen {
  final IconData icon;
  final String labelKey;
  const _Amen({required this.icon, required this.labelKey});
}

class _DescriptionCard extends StatelessWidget {
  final Color teal;
  final String titleKey;
  final String textKey;

  const _DescriptionCard({required this.teal, required this.titleKey, required this.textKey});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: teal.withOpacity(0.12), 
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.tr(titleKey), style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900)),
          const SizedBox(height: 10),
          Text(
            context.tr(textKey),
            style: const TextStyle(fontSize: 12.8, height: 1.5, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class _LocationCard extends StatelessWidget {
  final Color secondaryTeal;
  const _LocationCard({required this.secondaryTeal});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 170,
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Stack(
        children: [
          Center(
            child: Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: secondaryTeal,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: secondaryTeal.withOpacity(0.35), blurRadius: 14, offset: const Offset(0, 8)),
                ],
              ),
              child: const Center(
                child: Icon(Icons.location_on, color: Colors.white, size: 22),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PolicyList extends StatelessWidget {
  final Color secondaryTeal;
  final List<_Policy> items;

  const _PolicyList({required this.secondaryTeal, required this.items});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: items
          .map(
            (p) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: theme.canvasColor.withOpacity(0.4),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: theme.dividerColor),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(p.icon, size: 20, color: secondaryTeal),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(context.tr(p.titleKey), style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12.5)),
                        const SizedBox(height: 4),
                        Text(
                          context.tr(p.subtitleKey),
                          style: const TextStyle(
                            fontSize: 11.5,
                            height: 1.35,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

class _Policy {
  final IconData icon;
  final String titleKey;
  final String subtitleKey;

  const _Policy({required this.icon, required this.titleKey, required this.subtitleKey});
}

class _ReviewsHeader extends StatelessWidget {
  final Color secondaryTeal;
  const _ReviewsHeader({required this.secondaryTeal});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: theme.dividerColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Row(
            children: [
              Icon(Icons.star, size: 16, color: secondaryTeal),
              const SizedBox(width: 6),
              const Text('4.9', style: TextStyle(fontWeight: FontWeight.w900)),
              const SizedBox(width: 8),
              const Text('(128)', style: TextStyle(fontWeight: FontWeight.w800)),
            ],
          ),
        ),
      ],
    );
  }
}

class _ReviewsRow extends StatelessWidget {
  final Color teal;
  final Color secondaryTeal;

  const _ReviewsRow({required this.teal, required this.secondaryTeal});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _ReviewCard(
                name: 'Elena M.',
                // تم تعديلها هنا لاستقبال الترجمة بشكل صحيح وبدون إيرور
                monthDay: context.tr('reviewMonth1'),
                text: context.tr('reviewText1'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _ReviewCard(
                name: 'Jar',
                monthDay: context.tr('reviewMonth2'),
                text: context.tr('reviewText2'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final String name;
  final String monthDay;
  final String text;

  const _ReviewCard({
    required this.name,
    required this.monthDay,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: theme.dividerColor.withOpacity(0.5))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 14)),
                    const SizedBox(height: 4),
                    Text(monthDay, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: theme.colorScheme.primary)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            text,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 13, height: 1.5),
          ),
        ],
      ),
    );
  }
}