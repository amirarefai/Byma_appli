import 'package:flutter/material.dart';

import 'bookings_screen.dart';
import 'main_layout_screen.dart';
import 'settings_refined_screen.dart';
import 'conversation_screen.dart';

class BymaChatScreen extends StatefulWidget {
  const BymaChatScreen({super.key});

  @override
  State<BymaChatScreen> createState() => _BymaChatScreenState();
}

class _BymaChatScreenState extends State<BymaChatScreen> {
  // نحدد التبويب النشط (رقم 2 هو الشات)
  int _activeTabIndex = 2; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // لجعل المحتوى يمتد خلف شريط التنقل السفلي العائم
      extendBody: true, 
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back, color: Color(0xFF0F2942)),
        title: const Text(
          'BYMA',
          style: TextStyle(
            color: Color(0xFF0F2942),
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Color(0xFF0F2942)),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Messages',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                color: Color(0xFF0F2942),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Coordinate your stays with our expert property curators.',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 24),
            
            // Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F5F7),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search properties or messages...',
                  prefixIcon: Icon(Icons.search, color: Color(0xFF64748B)),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 28),
            
            // قائمة المحادثات (إطارات رمادية فاتحة وموحدة وقابلة للضغط)
            _buildChatItem(context, 'property_1.jpg', 'The Azure Heights', '12:45 PM', 'Your late check-in has been approved. We look forward to your stay!'),
            _buildChatItem(context, 'property_2.jpg', 'Velvet Palms Resort', 'JUST NOW', 'New booking request received. Tap to view custom details.'),
            _buildChatItem(context, 'property_3.jpg', 'EcoStone Villas', 'YESTERDAY', 'How was your stay? We would love to hear your feedback!'),
            _buildChatItem(context, 'property_4.jpg', 'The Obsidian Suite', 'TUESDAY', 'Your receipt for the additional room service is ready.'),
            
            const SizedBox(height: 100), // مساحة إضافية لكي لا يغطي الشريط آخر محادثة
          ],
        ),
      ),

      // تصميم شريط التنقل السفلي العائم مع النقطة
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ويدجت شريط التنقل السفلي
  Widget _buildBottomNav() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
        child: Container(
          height: 72,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(35),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(Icons.explore_outlined, "EXPLORE", 0),
              _navItem(Icons.calendar_month_outlined, "BOOKINGS", 1),
              _navItem(Icons.chat_bubble_outline, "CHAT", 2),
              _navItem(Icons.person_outline, "PROFILE", 3),
            ],
          ),
        ),
      ),
    );
  }

  // بناء كل أيقونة في شريط التنقل مع النقطة العلوية عند التفعيل
  Widget _navItem(IconData icon, String label, int index) {
    bool isActive = _activeTabIndex == index;
    Color activeColor = const Color(0xFF0FA37A); // اللون الأخضر في الصورة
    Color inactiveColor = const Color(0xFF64748B);

    return GestureDetector(
      onTap: () {
        if (index == 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const MainLayoutScreen()),
          );
          return;
        }

        if (index == 1) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const BookingsScreen()),
          );
          return;
        }

        if (index == 3) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const SettingsRefinedScreen()),
          );
          return;
        }

        setState(() {
          _activeTabIndex = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // النقطة التي تظهر فوق التبويب النشط
          Container(
            height: 4,
            width: 4,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive ? const Color(0xFF0F2942) : Colors.transparent,
            ),
          ),
          const SizedBox(height: 4),
          Icon(icon, color: isActive ? activeColor : inactiveColor, size: 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: isActive ? FontWeight.w900 : FontWeight.w600,
              color: isActive ? activeColor : inactiveColor,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  // ويدجت بطاقة المحادثة (رمادية موحدة وقابلة للضغط)
  Widget _buildChatItem(BuildContext context, String img, String name, String time, String msg) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9), // رمادي فاتح موحد
        borderRadius: BorderRadius.circular(24),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const ConversationScreen(),
            ),
          );
        },
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              CircleAvatar(
                radius: 34,
                backgroundColor: const Color(0xFFE2E8F0),
                backgroundImage: AssetImage('assets/images/$img'),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(name, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Color(0xFF0F2942))),
                        Text(time, style: const TextStyle(fontSize: 12, color: Color(0xFF64748B), fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(msg, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 14, color: Color(0xFF64748B), height: 1.3)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}