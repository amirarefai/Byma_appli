import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'filters_advanced_screen.dart';
import 'hotel_details_screen.dart';

class FilteredResultsUpdatedScreen extends StatelessWidget {
  final String? location;
  final DateTimeRange? dateRange;

  const FilteredResultsUpdatedScreen({
    super.key,
    this.location,
    this.dateRange, String? hotelName,
  });

  Widget _buildHotelCard({
    required BuildContext context,
    required String imageUrl,
    required String title,
    required String subtitle,
    required double rating,
    required double price,
    required String nightsLabel,
    required ThemeData theme,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withValues(alpha: 0.15),
            blurRadius: 18,
            offset: const Offset(0, 8),
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
                      imageUrl: imageUrl, id: '',
                    ),
                  ),
                );
              },
              child: SizedBox(
                height: 165,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(26),
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.dividerColor.withValues(alpha: 0.2),
                      border: Border.all(
                        color: theme.dividerColor,
                        width: 1.2,
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image_outlined, 
                            size: 38, 
                            color: theme.iconTheme.color?.withValues(alpha: 0.5),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'image_preview_placeholder'.tr(),
                            style: TextStyle(
                              color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.6),
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ],
                      ),
                    ),
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
                          title.tr(), // دعم ترجمة أسماء الفنادق الديناميكية إذا لزم الأمر
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: theme.textTheme.titleLarge?.color,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 10),
                      _RatingChip(rating: rating, theme: theme),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle.tr(),
                    style: TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w500,
                      color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _PriceBlock(
                        price: price, 
                        nightsLabel: nightsLabel.tr(), 
                        theme: theme,
                      ),
                      const Spacer(),
                      _BookNowButton(theme: theme),
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
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
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
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: theme.shadowColor.withValues(alpha: 0.06),
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
                          color: theme.dividerColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Icon(Icons.arrow_back_ios_new, size: 18, color: theme.iconTheme.color),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'selected_stays'.tr(),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: theme.textTheme.titleLarge?.color,
                              letterSpacing: -0.2,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'selected_stays_sub'.tr(),
                            style: TextStyle(
                              fontSize: 11,
                              color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.6),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
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
                  padding: const EdgeInsets.only(bottom: 30),
                  children: [
                    // Destination card
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: theme.primaryColor.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: theme.primaryColor.withValues(alpha: 0.3),
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
                                  'destination_label'.tr(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 1.1,
                                    color: theme.primaryColor,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'amalfi_coast_mock'.tr(), 
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w900,
                                    color: theme.textTheme.titleLarge?.color,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'trip_details_mock'.tr(),
                                  style: TextStyle(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w600,
                                    color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
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
                                  builder: (_) => const FiltersAdvancedScreen(),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 18),
                              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                              decoration: BoxDecoration(
                                color: theme.primaryColor,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Text(
                                'edit_button'.tr(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.4,
                                  color: theme.colorScheme.onPrimary,
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
                      imageUrl: '',
                      title: 'sea_view_suite_title',
                      subtitle: 'grand_miramar_resort_sub',
                      rating: 4.9,
                      price: 420,
                      nightsLabel: 'per_night',
                      theme: theme,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RatingChip extends StatelessWidget {
  final double rating;
  final ThemeData theme;
  const _RatingChip({required this.rating, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondary.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: theme.colorScheme.secondary.withValues(alpha: 0.4),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star, size: 14, color: Colors.amber),
          const SizedBox(width: 4),
          Text(
            rating.toStringAsFixed(1),
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 13,
              color: theme.textTheme.titleLarge?.color,
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
  final ThemeData theme;

  const _PriceBlock({
    required this.price,
    required this.nightsLabel,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    // استخدام Text.rich بدلاً من RichText لضمان وراثة خصائص محاذاة النص والاتجاهات الافتراضية للثيم
    return Text.rich(
      TextSpan(
        style: TextStyle(
          fontWeight: FontWeight.w800,
          color: theme.primaryColor,
          fontSize: 22,
        ),
        children: [
          TextSpan(
            text: '\$${price.toInt()}',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 22,
              color: theme.primaryColor,
            ),
          ),
          TextSpan(
            text: ' $nightsLabel', // إضافة مسافة بادئة لتجنب الالتصاق بالرقم
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }
}

class _BookNowButton extends StatelessWidget {
  final ThemeData theme;
  const _BookNowButton({required this.theme});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: theme.primaryColor,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(
          'book_now'.tr(),
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: theme.colorScheme.onPrimary,
            fontSize: 14,
            letterSpacing: 0.2,
          ),
        ),
      ),
    );
  }
}