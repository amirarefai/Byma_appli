import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // لتنسيق عرض التاريخ بشكل احترافي

import '../constance/app_colors.dart';
import '../state/favorites_scope.dart';
import '../state/favorites_store.dart';
import '../widgets/byma_bottom_nav.dart';
import 'bookings_screen.dart';
import 'main_layout_screen.dart';
import 'messages_final_navigation.dart';
import 'settings_refined_screen.dart';
import 'filtered_results_updated_screen.dart';

class HotelsScreen extends StatefulWidget {
  const HotelsScreen({super.key});

  @override
  State<HotelsScreen> createState() => _HotelsScreenState();
}

class _HotelsScreenState extends State<HotelsScreen> {
  int selectedCategoryIndex = 0;
  BymaBottomNavTab _currentNavTab = BymaBottomNavTab.home;

  // متغيرات الحالة (State) للموقع والتاريخ
  String selectedLocation = 'Location where to'; // القيمة الافتراضية للموقع
  DateTimeRange? selectedDateRange;     // لتخزين تاريخ البدء والانتهاء

  // قائمة المدن السورية المتاحة للاختيار
  final List<String> syrianCities = [
    'Damascus',
    'Rif Dimashq',
    'Aleppo',
    'Lattakia',
    'Tartous',
    'Homs',
    'Hama',
     'Daraa',
  'As-Suwayda',
  'Idlib',
    'Raqqa',
  'Deir ez-Zor',
  'Al-Hasakah',
  'Quneitra',

  ];

  // دالة إظهار قائمة المدن كمربع حوار (Dialog)
  void _showLocationPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Select Location in Syria',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: syrianCities.length,
              separatorBuilder: (_, _) => const Divider(),
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.location_on_outlined, color: Colors.grey),
                  title: Text(
                    syrianCities[index],
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  trailing: selectedLocation == syrianCities[index]
                      ? Icon(Icons.check_circle, color: AppTheme.kPrimaryColor)
                      : null,
                  onTap: () {
                    setState(() {
                      selectedLocation = syrianCities[index];
                    });
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  // دالة إظهار تقويم حقيقي (Date Range Picker) اختيار فترة الإقامة
  Future<void> _showDatePicker(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(), // يمنع اختيار تواريخ قديمة
      lastDate: DateTime.now().add(const Duration(days: 365)), // متاح لمدة سنة للأمام
      currentDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppTheme.kPrimaryColor, // لون التقويم الرئيسي
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: AppTheme.kTextColor,
            ),
            dialogTheme: const DialogThemeData(
              backgroundColor: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        selectedDateRange = picked;
      });
    }
  }

  // تنسيق نص التاريخ المعروض للمستخدم
  String get _dateRangeString {
    if (selectedDateRange == null) {
      return 'Add dates';
    }
    final start = DateFormat('MMM dd').format(selectedDateRange!.start);
    final end = DateFormat('MMM dd').format(selectedDateRange!.end);
    return '$start - $end';
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = AppTheme.kPrimaryColor;
    final darkTextColor = AppTheme.kTextColor;
    final secondaryTextColor = AppTheme.kSubTextColor;
    final backgroundColor = AppTheme.kBackgroundColor;

    final categories = [
      {'icon': Icons.king_bed_outlined, 'label': 'HOTELS'},
      {'icon': Icons.directions_car_outlined, 'label': 'CARS'},
      {'icon': Icons.restaurant_outlined, 'label': 'EATS'},
    ];

    final hotels = [
      {
        'image': 'assets/hotel_1.jpg',
        'title': 'Malibu Glass Villa',
        'subtitle': 'Oceanfront design with private garden',
        'rating': '4.8',
        'price': '\$2,400',
        'unit': '/night',
      },
      {
        'image': 'assets/hotel_2.jpg',
        'title': 'The Glass Pavilion',
        'subtitle': 'Pristine condition luxury stay',
        'rating': '4.9',
        'price': '\$2,450',
        'unit': '/night',
      },
      {
        'image': 'assets/hotel_3.jpg',
        'title': 'Oslo Penthouse',
        'subtitle': 'Sleek nordic design with harbor view',
        'rating': '4.7',
        'price': '\$1,900',
        'unit': '/night',
      },
      {
        'image': 'assets/hotel_4.jpg',
        'title': 'Azure Explorer',
        'subtitle': 'Full crewed day charter in Ibiza',
        'rating': '5.0',
        'price': '\$1,800',
        'unit': '/day',
      },
    ];

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // الهيدر الرئيسي (BYMA) مع زر الإشعارات الدائري
            SliverAppBar(
              floating: true,
              pinned: false,
              automaticallyImplyLeading: false,
              backgroundColor: backgroundColor,
              elevation: 0,
              centerTitle: false,
              titleSpacing: 0,
              toolbarHeight: 92,
              title: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
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
                      const Text(
                        'BYMA',
                        style: TextStyle(
                          color: AppTheme.kPrimaryColor,
                          fontWeight: FontWeight.w900,
                          fontSize: 24,
                          letterSpacing: 1.1,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF4F8F8),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.notifications_none_outlined,
                          color: AppTheme.kTextColor,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // عنوان الواجهة + كرت البحث الموحد التفاعلي + قائمة الأقسام الدائرية
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const SizedBox(height: 8),

                    // كرت البحث الرئيسي الموحد التفاعلي الكامل (Location & Stay)
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 24,
                            offset: const Offset(0, 12),
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              // قسم اختيار الموقع (تفاعلي)
                              Expanded(
                                child: InkWell(
                                  onTap: () => _showLocationPicker(context),
                                  borderRadius: BorderRadius.circular(12),
                                  child: _buildSearchSection(
                                    icon: Icons.location_on_rounded,
                                    title: 'LOCATION',
                                    subtitle: selectedLocation, 
                                    primaryColor: primaryColor,
                                  ),
                                ),
                              ),
                              // الخط الفاصل الخفيف المنتصف
                              Container(
                                height: 35,
                                width: 1,
                                color: Colors.black.withValues(alpha: 0.06),
                              ),
                              // قسم اختيار التواريخ والأيام (تفاعلي)
                              Expanded(
                                child: InkWell(
                                  onTap: () => _showDatePicker(context),
                                  borderRadius: BorderRadius.circular(12),
                                  child: _buildSearchSection(
                                    icon: Icons.calendar_month_rounded,
                                    title: 'STAY',
                                    subtitle: _dateRangeString, 
                                    primaryColor: primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          
                          // 🌟 تم دمج زر البحث التفاعلي هنا بنجاح 🌟
                          InkWell(
                            onTap: () {
                              final hasLocation = selectedLocation != 'Location where to';

                              if (!hasLocation) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Please select a location first!'),
                                    backgroundColor: Colors.amber,
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                                return;
                              }

                              if (selectedDateRange == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Please select your stay dates first!'),
                                    backgroundColor: Colors.amber,
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                                return;
                              }

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CuratedStaysScreen(
                                    location: selectedLocation,
                                    dateRange: selectedDateRange,
                                  ),
                                ),
                              );
                            },
                            borderRadius: BorderRadius.circular(18),
                            child: Container(
                              height: 54,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: const Center(
                                child: Icon(Icons.search, color: Colors.white, size: 26),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // قائمة التصنيفات الانسيابية (Hotels, Cars, Eats) الدائرية
                    SizedBox(
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(categories.length, (index) {
                          final category = categories[index];
                          final bool isSelected = index == selectedCategoryIndex;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedCategoryIndex = index;
                              });
                            },
                            child: Column(
                              children: [
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 250),
                                  height: 64,
                                  width: 64,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isSelected
                                        ? primaryColor
                                        : primaryColor.withValues(alpha: 0.08),
                                    boxShadow: isSelected
                                        ? [
                                            BoxShadow(
                                              color: primaryColor.withValues(alpha: 0.25),
                                              blurRadius: 14,
                                              offset: const Offset(0, 8),
                                            )
                                          ]
                                        : null,
                                  ),
                                  child: Icon(
                                    category['icon'] as IconData,
                                    color: isSelected ? Colors.white : primaryColor,
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  category['label'] as String,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                    color: isSelected ? primaryColor : secondaryTextColor,
                                    letterSpacing: 0.6,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),

            // قائمة عرض الفنادق الرأسية الفاخرة بالظلال والإطارات الجديدة
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final hotel = hotels[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: _buildVerticalHotelCard(
                        imagePath: hotel['image']!,
                        title: hotel['title']!,
                        subtitle: hotel['subtitle']!,
                        price: hotel['price']!,
                        unit: hotel['unit']!,
                        rating: hotel['rating']!,
                        primaryColor: primaryColor,
                        titleColor: darkTextColor,
                        subColor: secondaryTextColor,
                      ),
                    );
                  },
                  childCount: hotels.length,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BymaBottomNav(
        activeTab: _currentNavTab,
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
            return;
          }

          setState(() {
            _currentNavTab = tab;
          });
        },
      ),
    );
  }

  // الـ Widget المساعد لبناء تفاصيل النصوص والأيقونات داخل كرت البحث
  Widget _buildSearchSection({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color primaryColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      child: Row(
        children: [
          Icon(icon, color: primaryColor, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFFA1A8B9),
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E293B),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // الـ Widget المحدث لإطارات الصور بالظلال والحواف الدائرية الناعمة
  Widget _buildVerticalHotelCard({
    required String imagePath,
    required String title,
    required String subtitle,
    required String price,
    required String unit,
    required String rating,
    required Color primaryColor,
    required Color titleColor,
    required Color subColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26), 
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05), 
                blurRadius: 16,
                offset: const Offset(0, 8), 
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(26),
            child: Stack(
              children: [
                SizedBox(
                  height: 210,
                  width: double.infinity,
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 210,
                        width: double.infinity,
                        color: Colors.grey[200],
                        child: const Center(
                          child: Icon(
                            Icons.image_not_supported_outlined,
                            size: 56,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    },
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
        const SizedBox(height: 16), 
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w900,
                  color: titleColor,
                  letterSpacing: -0.2,
                ),
              ),
            ),
            Row(
              children: [
                const Icon(Icons.star, color: Color(0xFFFFB300), size: 18),
                const SizedBox(width: 4),
                Text(
                  rating,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: titleColor,
                  ),
                ),
              ],
            )
          ],
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 13,
            color: subColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: price,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: primaryColor),
              ),
              TextSpan(
                text: ' $unit',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: subColor),
              ),
            ],
          ),
        ),
      ],
    );
  }

}