import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart'; // استيراد الترجمة

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
  int _activeTabIndex = 2; 

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      extendBody: true, 
      appBar: AppBar(
        leading: Icon(Icons.arrow_back, color: theme.appBarTheme.iconTheme?.color ?? theme.primaryColor),
        title: Text(
          'BYMA',
          style: TextStyle(
            color: theme.appBarTheme.titleTextStyle?.color ?? theme.primaryColor,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: theme.appBarTheme.iconTheme?.color ?? theme.primaryColor),
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
            Text(
              'chat_title'.tr(), // مترجم
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                color: theme.textTheme.headlineLarge?.color,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'chat_subtitle'.tr(), // مترجم
              style: TextStyle(
                fontSize: 16,
                color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 24),
            
            // Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: isDarkMode ? theme.cardColor : const Color(0xFFF3F5F7),
                borderRadius: BorderRadius.circular(24),
              ),
              child: TextField(
                style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                decoration: InputDecoration(
                  hintText: 'chat_search_hint'.tr(), // مترجم
                  hintStyle: TextStyle(color: theme.hintColor.withOpacity(0.6)),
                  prefixIcon: Icon(Icons.search, color: theme.hintColor),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 28),
            
            // قائمة المحادثات (تعتمد على ألوان الثيم وتدعم الترجمة التلقائية للوقت)
            _buildChatItem(context, theme, isDarkMode, 'property_1.jpg', 'The Azure Heights', '12:45 PM', 'chat_msg_1'.tr()),
            _buildChatItem(context, theme, isDarkMode, 'property_2.jpg', 'Velvet Palms Resort', 'chat_time_just_now'.tr(), 'chat_msg_2'.tr()),
            _buildChatItem(context, theme, isDarkMode, 'property_3.jpg', 'EcoStone Villas', 'chat_time_yesterday'.tr(), 'chat_msg_3'.tr()),
            _buildChatItem(context, theme, isDarkMode, 'property_4.jpg', 'The Obsidian Suite', 'chat_time_tuesday'.tr(), 'chat_msg_4'.tr()),
            
            const SizedBox(height: 100), 
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(theme, isDarkMode),
    );
  }

  Widget _buildBottomNav(ThemeData theme, bool isDarkMode) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
        child: Container(
          height: 72,
          decoration: BoxDecoration(
            color: theme.bottomAppBarTheme.color ?? theme.cardColor,
            borderRadius: BorderRadius.circular(35),
            boxShadow: [
              BoxShadow(
                color: isDarkMode ? Colors.black26 : Colors.black.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(theme, Icons.explore_outlined, "nav_home".tr().toUpperCase(), 0),
              _navItem(theme, Icons.calendar_month_outlined, "nav_bookings".tr().toUpperCase(), 1),
              _navItem(theme, Icons.chat_bubble_outline, "nav_chat".tr().toUpperCase(), 2),
              _navItem(theme, Icons.person_outline, "nav_settings".tr().toUpperCase(), 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(ThemeData theme, IconData icon, String label, int index) {
    bool isActive = _activeTabIndex == index;
    Color activeColor = theme.colorScheme.secondary; // معتمد على لون الإبراز في الثيم
    Color inactiveColor = theme.hintColor;

    return GestureDetector(
      onTap: () {
        if (index == 0) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainLayoutScreen()));
          return;
        }
        if (index == 1) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const BookingsScreen()));
          return;
        }
        if (index == 3) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const SettingsRefinedScreen()));
          return;
        }
        setState(() {
          _activeTabIndex = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 4,
            width: 4,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive ? theme.textTheme.bodyLarge?.color : Colors.transparent,
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

  Widget _buildChatItem(BuildContext context, ThemeData theme, bool isDarkMode, String img, String name, String time, String msg) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: isDarkMode ? theme.cardColor.withOpacity(0.6) : const Color(0xFFF1F5F9), 
        borderRadius: BorderRadius.circular(24),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ConversationScreen()),
          );
        },
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              CircleAvatar(
                radius: 34,
                backgroundColor: isDarkMode ? theme.dividerColor : const Color(0xFFE2E8F0),
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
                        Text(
                          name, 
                          style: TextStyle(
                            fontSize: 17, 
                            fontWeight: FontWeight.w800, 
                            color: theme.textTheme.bodyLarge?.color
                          ),
                        ),
                        Text(
                          time, 
                          style: TextStyle(
                            fontSize: 12, 
                            color: theme.hintColor, 
                            fontWeight: FontWeight.w600
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      msg, 
                      maxLines: 2, 
                      overflow: TextOverflow.ellipsis, 
                      style: TextStyle(
                        fontSize: 14, 
                        color: theme.textTheme.bodyMedium?.color?.withOpacity(0.8), 
                        height: 1.3
                      ),
                    ),
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