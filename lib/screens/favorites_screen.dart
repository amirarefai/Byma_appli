import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../state/favorites_scope.dart';
import '../state/favorites_store.dart';


// استيراد شاشات التفاصيل الخاصة بك
import '../screens/hotel_details_screen.dart';
import '../screens/room_details_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // الهيدر العلوي
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 6),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: theme.dividerColor),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                      onPressed: () => Navigator.pop(context),
                      splashRadius: 18,
                      color: theme.iconTheme.color,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'curated_collection_label'.tr(),
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.2,
                            color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.6),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'favorites_title'.tr(),
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: theme.textTheme.titleLarge?.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),

            // قائمة العناصر المفضلة مقسمة أفقياً
            Expanded(
              child: AnimatedBuilder(
                animation: FavoritesScope.of(context),
                builder: (context, _) {
                  final favorites = FavoritesScope.of(context).favorites;

                  if (favorites.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          'no_favorites_message'.tr(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.5),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }

                  // الفصل التام بناءً على المعرف ID
                  final hotels = favorites.where((item) => 
                    item.id.toLowerCase().contains('hotel') || (item.ctaText.isNotEmpty && item.ctaText != 'view_details')
                  ).toList();
                  
                  final rooms = favorites.where((item) => 
                    !hotels.contains(item)
                  ).toList();

                  return ListView(
                    padding: const EdgeInsets.only(bottom: 24),
                    children: [
                      // ----- 1. قسم الغرف المفضلّة (سكرول عرضي علوي) -----
                      if (rooms.isNotEmpty) ...[
                        _buildSectionHeader(theme, 'favorite_rooms_label'.tr()),
                        SizedBox(
                          height: 340, 
                          child: ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            scrollDirection: Axis.horizontal,
                            itemCount: rooms.length,
                            separatorBuilder: (_, __) => const SizedBox(width: 16),
                            itemBuilder: (context, index) {
                              return SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8, 
                                child: _FavoriteCard(
                                  item: rooms[index],
                                  theme: theme,
                                  isHotel: false, // تحديد نوع الكرت كغرفة
                                ),
                              );
                            },
                          ),
                        ),
                      ],

                      if (rooms.isNotEmpty && hotels.isNotEmpty) const SizedBox(height: 24),

                      // ----- 2. قسم الفنادق المفضلّة (سكرول عرضي سفلي) -----
                      if (hotels.isNotEmpty) ...[
                        _buildSectionHeader(theme, 'favorite_hotels_label'.tr()),
                        SizedBox(
                          height: 380, 
                          child: ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            scrollDirection: Axis.horizontal,
                            itemCount: hotels.length,
                            separatorBuilder: (_, __) => const SizedBox(width: 16),
                            itemBuilder: (context, index) {
                              return SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: _FavoriteCard(
                                  item: hotels[index],
                                  theme: theme,
                                  isHotel: true, // تحديد نوع الكرت كفندق
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(ThemeData theme, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w900,
          color: theme.textTheme.titleLarge?.color,
        ),
      ),
    );
  }
}

class _FavoriteCard extends StatelessWidget {
  final FavoriteItem item;
  final ThemeData theme;
  final bool isHotel; 

  const _FavoriteCard({
    required this.item,
    required this.theme,
    required this.isHotel,
  });

  @override
  Widget build(BuildContext context) {
    final isHighContrast = theme.colorScheme.primary == Colors.yellow;

    return GestureDetector(
      onTap: () {
        // الانتقال للشاشة الصحيحة بناءً على المتغير الممرر
        if (isHotel) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HotelDetailsScreen(id: item.id, title: '', imageUrl: '',),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RoomDetailsScreen(id: item.id, roomTitle: '', pricePerNight: '',),
            ),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(26),
          border: Border.all(color: theme.dividerColor),
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withValues(alpha: 0.08),
              blurRadius: 18,
              offset: const Offset(0, 10),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                  child: AspectRatio(
                    aspectRatio: 1.55,
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.dividerColor.withValues(alpha: 0.2),
                      ),
                      child: item.imageAsset.isEmpty
                          ? const SizedBox.shrink()
                          : Image.asset(item.imageAsset, fit: BoxFit.cover),
                    ),
                  ),
                ),
                // زر إلغاء المفضلة
                Positioned(
                  right: 14,
                  top: 14,
                  child: GestureDetector(
                    onTap: () {
                      FavoritesScope.of(context).toggleFavorite(item);
                    },
                    child: Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: theme.cardColor.withValues(alpha: 0.85),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: theme.dividerColor),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.favorite_rounded,
                          color: theme.primaryColor,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                if (item.compactBadge != null)
                  Positioned(
                    left: 14,
                    top: 14,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: theme.primaryColor.withValues(alpha: 0.95),
                        borderRadius: BorderRadius.circular(999),
                        border: isHighContrast ? Border.all(color: Colors.black) : null,
                      ),
                      child: Text(
                        item.compactBadge!.tr(),
                        style: TextStyle(
                          color: theme.colorScheme.onPrimary,
                          fontWeight: FontWeight.w900,
                          fontSize: 12,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ),
                  ),
                if (isHotel)
                  Positioned(
                    left: 14,
                    bottom: 14,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 26,
                            height: 26,
                            decoration: BoxDecoration(
                              color: theme.cardColor.withValues(alpha: 0.9),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.star_rounded,
                              size: 16,
                              color: theme.primaryColor,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            item.rating,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.title.tr(),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: theme.textTheme.titleLarge?.color,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (!isHotel)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: theme.scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(color: theme.dividerColor),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.star_rounded, size: 16, color: theme.primaryColor),
                              const SizedBox(width: 6),
                              Text(
                                item.rating,
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: theme.textTheme.titleLarge?.color,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.subtitle.tr(),
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.6),
                      fontSize: 13,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      if (item.fromText.isNotEmpty)
                        Text(
                          '${item.fromText.tr()} ',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.5),
                            fontSize: 13,
                          ),
                        ),
                      Text(
                        item.price.tr(),
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: theme.textTheme.titleLarge?.color,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  if (isHotel && item.ctaText.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 44,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HotelDetailsScreen(id: item.id, title: '', imageUrl: '',),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.primaryColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        child: Text(
                          item.ctaText.tr(),
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                            color: theme.colorScheme.onPrimary,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}