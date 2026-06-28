import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../constance/app_colors.dart';
import '../state/favorites_scope.dart';
import '../state/favorites_store.dart';
import '../widgets/byma_bottom_nav.dart';
import 'bookings_screen.dart';
import 'messages_final_navigation.dart';
import 'hotels_screen.dart';
import 'main_layout_screen.dart';
import 'settings_refined_screen.dart';

class HomeScreen extends StatelessWidget {
  final ValueChanged<BymaBottomNavTab>? onTabChanged;

  const HomeScreen({super.key, this.onTabChanged});

  @override
  Widget build(BuildContext context) {
    // التحقق مما إذا كان التطبيق في الوضع الداكن حالياً
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // جلب الألوان ديناميكياً بناءً على الثيم
    final primaryColor = Theme.of(context).primaryColor;
    final darkGreenColor = isDarkMode ? AppColors.kPrimaryColor : AppColors.kPrimaryColor; 
    final darkTextColor = Theme.of(context).textTheme.bodyLarge?.color ?? AppColors.kTextColor;
    final bodyTextColor = Theme.of(context).textTheme.bodyMedium?.color ?? AppColors.kTextColor;
    final secondaryTextColor = Theme.of(context).textTheme.bodySmall?.color ?? AppColors.kSubTextColor;
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final cardColor = Theme.of(context).cardColor;

    return Scaffold(
      backgroundColor: backgroundColor,
      bottomNavigationBar: BymaBottomNav(
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
      body: SafeArea(
        top: false, 
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // 1. الهيدر العلوي (BYMA وزر التنبيهات)
            SliverAppBar(
              floating: true,
              pinned: false,
              backgroundColor: backgroundColor,
              elevation: 0,
              automaticallyImplyLeading: false,
              titleSpacing: 0,
              toolbarHeight: 92,
              title: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: isDarkMode ? 0.2 : 0.06),
                        blurRadius: 14,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'BYMA'.tr(), 
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w900,
                              fontSize: 24,
                              letterSpacing: 1.1,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'find_your_next_stay'.tr(), 
                            style: TextStyle(
                              color: secondaryTextColor,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: isDarkMode ? Colors.white.withValues(alpha: 0.05) : const Color(0xFFF4F8F8),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.notifications_none_outlined,
                          color: darkTextColor,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 2. محتويات الصفحة بالكامل
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    const SizedBox(height: 25),

                    // شريط البحث
                    _buildSearchBar(context, darkGreenColor, secondaryTextColor, cardColor),
                    const SizedBox(height: 35),

                    // قسم التصنيفات المموجة
                    _buildCategoriesSection(
                      context,
                      darkGreenColor,
                      primaryColor,
                      secondaryTextColor,
                    ),
                    const SizedBox(height: 35),

                    // عنوان قسم "Recently Viewed"
                    _buildSectionHeader('recently_viewed'.tr(), darkTextColor, primaryColor),
                    const SizedBox(height: 16),

                    // القائمة الأفقية للعناصر المشاهدة مؤخراً
                    _buildRecentlyViewedList(context, primaryColor, bodyTextColor),
                    const SizedBox(height: 35),

                    // الكرت الرئيسي الكبير مفرغ (The Glass Pavilion)
                    _buildFeaturedCard(context, cardColor, secondaryTextColor),
                    const SizedBox(height: 10),

                    // الكروت العمودية (تم ربط جميع النصوص بالترجمة داخل ملف الـ json الخاص بك)
                    _buildVerticalProductCard(
                      context,
                      title: "classic_67_rental_title".tr(),
                      subtitle: "classic_67_rental_sub".tr(),
                      price: "\$650",
                      unit: "day_unit".tr(),
                      rating: "4.8",
                      primaryColor: primaryColor,
                      titleColor: darkTextColor,
                      subColor: secondaryTextColor,
                    ),

                    _buildVerticalProductCard(
                      context,
                      title: "oslo_penthouse_title".tr(),
                      subtitle: "oslo_penthouse_sub".tr(),
                      price: "\$450",
                      unit: "night_unit".tr(),
                      rating: "4.9",
                      primaryColor: primaryColor,
                      titleColor: darkTextColor,
                      subColor: secondaryTextColor,
                    ),

                    _buildVerticalProductCard(
                      context,
                      title: "azure_explorer_title".tr(),
                      subtitle: "azure_explorer_sub".tr(),
                      price: "\$1,800",
                      unit: "day_unit".tr(),
                      rating: "5.0",
                      primaryColor: primaryColor,
                      titleColor: darkTextColor,
                      subColor: secondaryTextColor,
                    ),
                    const SizedBox(height: 100), 
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // شريط البحث المخصص
  Widget _buildSearchBar(BuildContext context, Color filterBgColor, Color textColor, Color cardColor) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 55,
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 12,
                  offset: const Offset(0, 5),
                )
              ],
            ),
            child: TextField(
              style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
              decoration: InputDecoration(
                hintText: 'search_hint'.tr(), 
                hintStyle: TextStyle(color: textColor.withValues(alpha: 0.5), fontSize: 15, fontWeight: FontWeight.w500),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 8.0),
                  child: Icon(Icons.search, color: textColor.withValues(alpha: 0.7), size: 22),
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          height: 55,
          width: 55,
          decoration: BoxDecoration(
            color: filterBgColor,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.tune, color: Colors.white, size: 22),
        ),
      ],
    );
  }

  // قسم الأيقونات
  Widget _buildCategoriesSection(
    BuildContext context,
    Color activeColor,
    Color inactiveIconColor,
    Color textColor,
  ) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const HotelsScreen()),
            );
          },
          child: _buildCategoryItem(
            Icons.king_bed_outlined,
            'HOTELS'.tr(), 
            isDarkMode ? Colors.white.withValues(alpha: 0.05) : const Color(0xFFEBF9F9),
            inactiveIconColor,
            textColor,
          ),
        ),
        Column(
          children: [
            Container(
              height: 75,
              width: 75,
              decoration: BoxDecoration(
                color: activeColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(40),
                  bottomLeft: Radius.circular(42),
                  bottomRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: activeColor.withValues(alpha: 0.25),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  )
                ],
              ),
              child: const Icon(Icons.directions_car_filled_outlined, color: Colors.white, size: 26),
            ),
            const SizedBox(height: 10),
            Text(
              'CARS'.tr(), 
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: activeColor, letterSpacing: 0.5),
            )
          ],
        ),
        _buildCategoryItem(
          Icons.restaurant_outlined,
          'EATS'.tr(), 
          isDarkMode ? Colors.white.withValues(alpha: 0.05) : const Color(0xFFFFF9F2),
          const Color(0xFFFFB057),
          textColor,
        ),
      ],
    );
  }

  Widget _buildCategoryItem(IconData icon, String label, Color bgColor, Color iconColor, Color textColor) {
    return Column(
      children: [
        Container(
          height: 75,
          width: 75,
          decoration: BoxDecoration(
            color: bgColor,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor, size: 26),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: textColor.withValues(alpha: 0.6), letterSpacing: 0.5),
        )
      ],
    );
  }

  Widget _buildSectionHeader(String title, Color textColor, Color actionColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: textColor, letterSpacing: -0.2),
        ),
        Text(
          'view_all'.tr(), 
          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: actionColor, letterSpacing: 0.8),
        ),
      ],
    );
  }

  Widget _buildRecentlyViewedList(BuildContext context, Color priceColor, Color textColor) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    // جعلنا الـ Keys والمحتوى يقبل الترجمة ديناميكياً
    final items = [
      {'title': 'modern_glass_villa_title'.tr(), 'price': '\$2,400', 'unit': 'night_unit'.tr()},
      {'title': "classic_67_edition_title".tr(), 'price': '\$650', 'unit': 'day_unit'.tr()},
    ];

    return SizedBox(
      height: 195,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Container(
            width: 170,
            margin: const EdgeInsets.only(right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 125,
                  width: 170,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: isDarkMode ? Colors.white.withValues(alpha: 0.05) : const Color(0xFFEFF3F6),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: isDarkMode ? Colors.white12 : const Color(0xFFD9E2E8), width: 1.2),
                        ),
                        child: Center(
                          child: Icon(Icons.image_outlined, size: 30, color: isDarkMode ? Colors.white30 : const Color(0xFFB7C3CB)),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        top: 10,
                        child: AnimatedBuilder(
                          animation: FavoritesScope.of(context),
                          builder: (context, _) {
                            final id = item['title'] as String;
                            final isFav = FavoritesScope.of(context).isFavorite(id);
                            return InkWell(
                              borderRadius: BorderRadius.circular(999),
                              onTap: () {
                                FavoritesScope.of(context).toggleFavorite(
                                  FavoriteItem(
                                    id: id,
                                    title: id,
                                    subtitle: id,
                                    rating: '4.9',
                                    fromText: '',
                                    price: item['price'] as String,
                                    ctaText: '',
                                    imageAsset: '',
                                    compactBadge: null,
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: isDarkMode ? 0.2 : 0.75),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  isFav ? Icons.favorite_rounded : Icons.favorite_border,
                                  color: isFav ? const Color(0xFF0FA37A) : (isDarkMode ? Colors.white : const Color(0xFF0F4A42)),
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
                const SizedBox(height: 10),
                Text(
                  item['title']!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: textColor),
                ),
                const SizedBox(height: 3),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: item['price']!,
                        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 13, color: priceColor),
                      ),
                      TextSpan(
                        text: ' ${item['unit']!}',
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 11, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeaturedCard(BuildContext context, Color cardColor, Color secondaryTextColor) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      height: 340,
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.white.withValues(alpha: 0.05) : const Color(0xFFE2E8F0), 
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: isDarkMode ? Colors.white10 : Colors.white, width: 1.5),
      ),
      child: Stack(
        children: [
          Center(
            child: Icon(
              Icons.image_not_supported_outlined,
              size: 75,
              color: isDarkMode ? Colors.white24 : const Color(0xFF94A3B8),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF62CDFF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'trending_now'.tr(), 
                    style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 0.6),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'glass_pavilion_title'.tr(),
                            style: TextStyle(color: isDarkMode ? Colors.white : const Color(0xFF0F4A42), fontSize: 26, fontWeight: FontWeight.w900, height: 1.15),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.location_on, color: isDarkMode ? secondaryTextColor : const Color(0xFF557C7D), size: 16),
                              const SizedBox(width: 4),
                              Text('malibu_california'.tr(), style: TextStyle(color: isDarkMode ? secondaryTextColor : const Color(0xFF557C7D), fontSize: 13, fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: cardColor.withValues(alpha: 0.85),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: isDarkMode ? Colors.white10 : Colors.white),
                      ),
                      child: Column(
                        children: [
                          Text('starting_from'.tr(), style: const TextStyle(color: Colors.grey, fontSize: 8, fontWeight: FontWeight.w900)),
                          Text('\$2,400/${'night_unit_short'.tr()}', style: const TextStyle(color: Color(0xFF006653), fontSize: 14, fontWeight: FontWeight.w900)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalProductCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String price,
    required String unit,
    required String rating,
    required Color primaryColor,
    required Color titleColor,
    required Color subColor,
  }) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.white.withValues(alpha: 0.05) : const Color(0xFFE2E8F0),
                  borderRadius: BorderRadius.circular(35),
                  border: Border.all(color: isDarkMode ? Colors.white10 : Colors.white, width: 1.5),
                ),
                child: Center(
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    size: 55,
                    color: isDarkMode ? Colors.white24 : const Color(0xFF94A3B8),
                  ),
                ),
              ),
              Positioned(
                top: 15,
                right: 15,
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
                            rating: rating,
                            fromText: '',
                            price: price,
                            ctaText: '',
                            imageAsset: '',
                            compactBadge: null,
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: isDarkMode ? 0.2 : 0.75),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isFav ? Icons.favorite_rounded : Icons.favorite_border,
                          color: isFav ? const Color(0xFF0FA37A) : (isDarkMode ? Colors.white : const Color(0xFF0F4A42)),
                          size: 20,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w900, color: titleColor, letterSpacing: -0.2),
              ),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 18),
                  const SizedBox(width: 4),
                  Text(
                    rating,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: titleColor),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(fontSize: 13, color: subColor, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: price,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: primaryColor),
                ),
                TextSpan(
                  text: ' $unit',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: subColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}