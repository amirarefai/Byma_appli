import 'package:flutter/material.dart';

import '../widgets/byma_bottom_nav.dart';
import 'main_layout_screen.dart';
import 'messages_final_navigation.dart';
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
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9), 
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
                    icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                    onPressed: () => Navigator.maybePop(context),
                  ),
                  const Text(
                    'BYMA',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900, 
                      color: Color(0xFF0F2942),
                      letterSpacing: 1.2,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 8,
                        )
                      ],
                    ),
                    child: const Icon(Icons.notifications_none_outlined, size: 22),
                  ),
                ],
              ),
            ),

            // العناوين الترحيبية
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'JOURNEY HISTORY',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF64748B),
                      letterSpacing: 1.1,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Your Stays.',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF0F2942),
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Relive your most extraordinary moments or prepare for your upcoming adventures.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF64748B),
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
                    _buildTabButton('All Stays'),
                    const SizedBox(width: 10),
                    _buildTabButton('Upcoming'),
                    const SizedBox(width: 10),
                    _buildTabButton('Completed'),
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
                      imageUrl: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=800&q=80',
                      tag: 'UPCOMING',
                      location: 'SANTORINI, GREECE',
                      title: 'Azure Horizon Estate',
                      checkIn: 'Oct 12, 2024',
                      nights: '5 Nights',
                      isUpcoming: true,
                    ),
                    const SizedBox(height: 20),
                  ],
                  if (_selectedTab == 'All Stays' || _selectedTab == 'Completed') ...[
                    _buildBookingCard(
                      imageUrl: 'https://images.unsplash.com/photo-1510798831971-661eb04b3739?auto=format&fit=crop&w=800&q=80',
                      tag: 'COMPLETED',
                      location: 'Oslo, Norway • Aug 14 - 18',
                      title: 'Nordic Pine Retreat',
                      checkIn: '',
                      nights: '',
                      isUpcoming: false,
                    ),
                    const SizedBox(height: 20),
                  ],
                  if (_selectedTab == 'All Stays' || _selectedTab == 'Completed') ...[
                    _buildBookingCard(
                      imageUrl: 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=800&q=80',
                      tag: 'COMPLETED',
                      location: 'New York, USA • June 02 - 05',
                      title: 'The Industrial Loft',
                      checkIn: '',
                      nights: '',
                      isUpcoming: false,
                    ),
                    const SizedBox(height: 20),
                  ],
                  // تباعد إضافي أسفل القائمة لمنع اختفاء الكروت خلف الأزرار والشريط السفلي
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
          }
        },
      ),

    );
  }

  Widget _buildTabButton(String label) {
    final isActive = _selectedTab == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF0FA37A) : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isActive ? Colors.transparent : const Color(0xFFE2E8F0),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: isActive ? Colors.white : const Color(0xFF0F2942),
          ),
        ),
      ),
    );
  }

  Widget _buildBookingCard({
    required String imageUrl,
    required String tag,
    required String location,
    required String title,
    required String checkIn,
    required String nights,
    required bool isUpcoming,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
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
                    color: const Color(0xFFEFF3F6),
                    border: Border.all(
                      color: const Color(0xFFD9E2E8),
                      width: 1.2,
                    ),
                  ),
                  child: const SizedBox(),
                ),
              ),
              Positioned(
                top: 14,
                left: 14,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isUpcoming ? const Color(0xFF38B6FF).withOpacity(0.9) : Colors.black.withOpacity(0.6), 
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    tag,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
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
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0FA37A),
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
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF0F2942),
                        ),
                      ),
                    ),
                    if (!isUpcoming)
                      const Icon(Icons.check_circle, color: Color(0xFF0FA37A), size: 20),
                  ],
                ),
                if (isUpcoming) ...[
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Divider(color: Color(0xFFF1F5F9), height: 1),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('CHECK IN', style: TextStyle(fontSize: 10, color: Color(0xFF94A3B8), fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text(checkIn, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Color(0xFF0F2942))),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('NIGHTS', style: TextStyle(fontSize: 10, color: Color(0xFF94A3B8), fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text(nights, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Color(0xFF0F2942))),
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
                      gradient: const LinearGradient(
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
                      child: const Text(
                        'Manage Booking',
                        style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: Colors.white),
                      ),
                    ),
                  ),
                ],
                if (!isUpcoming) ...[
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Rate Now',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF0FA37A)),
                      ),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(color: Color(0xFFE2E8F0), shape: BoxShape.circle),
                        child: const Icon(Icons.arrow_forward_ios, size: 10, color: Color(0xFF475569)),
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