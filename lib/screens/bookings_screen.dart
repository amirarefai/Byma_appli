import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../widgets/byma_bottom_nav.dart';
import 'main_layout_screen.dart';
import 'messages_final_navigation.dart'; // تأكد أن BymaChatScreen موجود هنا
import 'settings_refined_screen.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  String _selectedTab = 'All Stays';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor, 
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // الهيدر العلوي
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios_new, size: 20, color: theme.iconTheme.color),
                    onPressed: () => Navigator.maybePop(context),
                  ),
                  Text(
                    'BYMA',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900, 
                      color: theme.colorScheme.primary,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 8,
                        )
                      ],
                    ),
                    child: Icon(Icons.notifications_none_outlined, size: 22, color: theme.iconTheme.color),
                  ),
                ],
              ),
            ),

            // العناوين الترحيبية
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'journey_history'.tr(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: theme.colorScheme.secondary,
                      letterSpacing: 1.1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'your_stays'.tr(),
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'stays_subtitle'.tr(),
                    style: TextStyle(
                      fontSize: 14,
                      color: theme.colorScheme.tertiary, 
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            // أزرار الفلترة الأفقية
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    _buildTabButton('All Stays', 'all_stays'.tr(), theme),
                    const SizedBox(width: 10),
                    _buildTabButton('Upcoming', 'upcoming_tab'.tr(), theme),
                    const SizedBox(width: 10),
                    _buildTabButton('Completed', 'completed_tab'.tr(), theme),
                  ],
                ),
              ),
            ),

            // قائمة الحجوزات المفلترة ديناميكياً
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                children: [
                  if (_selectedTab == 'All Stays' || _selectedTab == 'Upcoming') ...[
                    _buildBookingCard(
                      context: context,
                      imageUrl: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=800&q=80',
                      tag: 'upcoming_tag'.tr(),
                      location: 'santorini_greece'.tr(),
                      title: 'azure_horizon'.tr(),
                      checkIn: 'Oct 12, 2024', 
                      nights: '5_nights'.tr(),
                      isUpcoming: true,
                      theme: theme,
                    ),
                    const SizedBox(height: 20),
                  ],
                  if (_selectedTab == 'All Stays' || _selectedTab == 'Completed') ...[
                    _buildBookingCard(
                      context: context,
                      imageUrl: 'https://images.unsplash.com/photo-1510798831971-661eb04b3739?auto=format&fit=crop&w=800&q=80',
                      tag: 'completed_tag'.tr(),
                      location: 'oslo_norway'.tr(),
                      title: 'nordic_pine'.tr(),
                      checkIn: '',
                      nights: '',
                      isUpcoming: false,
                      theme: theme,
                    ),
                    const SizedBox(height: 20),
                    _buildBookingCard(
                      context: context,
                      imageUrl: 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=800&q=80',
                      tag: 'completed_tag'.tr(),
                      location: 'new_york_usa'.tr(),
                      title: 'industrial_loft'.tr(),
                      checkIn: '',
                      nights: '',
                      isUpcoming: false,
                      theme: theme,
                    ),
                    const SizedBox(height: 20),
                  ],
                  const SizedBox(height: 160), 
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: BymaBottomNav(
        activeTab: BymaBottomNavTab.bookings,
        onTabSelected: (tab) {
          if (tab == BymaBottomNavTab.home) {
            Navigator.maybePop(context);
            return;
          }
          if (tab == BymaBottomNavTab.chat) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const BymaChatScreen()),
            );
            return;
          }
          if (tab == BymaBottomNavTab.profile) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsRefinedScreen()),
            );
            return;
          }
        },
      ),
    );
  }

  Widget _buildTabButton(String key, String translatedLabel, ThemeData theme) {
    final isActive = _selectedTab == key;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = key;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? theme.colorScheme.primary : theme.cardColor,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isActive ? Colors.transparent : theme.dividerColor,
          ),
        ),
        child: Text(
          translatedLabel,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: isActive 
                ? (theme.brightness == Brightness.dark && theme.colorScheme.primary == Colors.yellow ? Colors.black : Colors.white)
                : theme.colorScheme.secondary,
          ),
        ),
      ),
    );
  }

  Widget _buildBookingCard({
    required BuildContext context,
    required String imageUrl,
    required String tag,
    required String location,
    required String title,
    required String checkIn,
    required String nights,
    required bool isUpcoming,
    required ThemeData theme,
  }) {
    final isYellowTheme = theme.colorScheme.primary == Colors.yellow;

    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
                child: Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor,
                    border: Border.all(
                      color: theme.dividerColor,
                      width: 1.2,
                    ),
                  ),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Center(child: Icon(Icons.broken_image)),
                  ),
                ),
              ),
              Positioned(
                top: 14,
                left: 14,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isUpcoming 
                        ? (isYellowTheme ? Colors.yellow : const Color(0xFF38B6FF))
                        : (isYellowTheme ? Colors.white : Colors.black.withOpacity(0.6)), 
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    tag,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      color: isYellowTheme ? Colors.black : Colors.white,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  location.toUpperCase(),
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: theme.colorScheme.primary, 
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: theme.colorScheme.secondary,
                        ),
                      ),
                    ),
                    if (!isUpcoming)
                      Icon(Icons.check_circle, color: theme.colorScheme.primary, size: 20),
                  ],
                ),
                if (isUpcoming) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Divider(color: theme.dividerColor, height: 1),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('check_in_label'.tr(), style: TextStyle(fontSize: 10, color: theme.colorScheme.tertiary, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text(checkIn, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: theme.colorScheme.secondary)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('nights_label'.tr(), style: TextStyle(fontSize: 10, color: theme.colorScheme.tertiary, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text(nights, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: theme.colorScheme.secondary)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    height: 48,
                    decoration: BoxDecoration(
                      color: isYellowTheme ? Colors.yellow : null,
                      gradient: isYellowTheme ? null : const LinearGradient(
                        colors: [Color(0xFF50B5D9), Color(0xFF1F94A8)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: Text(
                        'manage_booking'.tr(),
                        style: TextStyle(
                          fontWeight: FontWeight.w800, 
                          fontSize: 14, 
                          color: isYellowTheme ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
                if (!isUpcoming) ...[
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'rate_now'.tr(),
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: theme.colorScheme.primary),
                      ),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(color: theme.dividerColor, shape: BoxShape.circle),
                        child: Icon(Icons.arrow_forward_ios, size: 10, color: theme.colorScheme.secondary),
                      )
                    ],
                  ),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}