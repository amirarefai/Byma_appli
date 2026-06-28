import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'bookings_screen.dart';
import 'messages_final_navigation.dart';
import 'settings_refined_screen.dart';
import '../widgets/byma_bottom_nav.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  BymaBottomNavTab _currentTab = BymaBottomNavTab.home;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor, // متناسق مع الثيم
      
      // الـ IndexedStack يعرض الشاشة المطلوبة بناءً على الـ index ويحافظ على حالتها
      body: IndexedStack(
        index: _currentTab.index,
        children: [
          HomeScreen(
            onTabChanged: (tab) {
              setState(() {
                _currentTab = tab;
              });
            },
          ), // index 0
          const BookingsScreen(), // index 1
          const BymaChatScreen(), // index 2
          const SettingsRefinedScreen(), // index 3
        ],
      ),
      
      extendBody: true, 
      bottomNavigationBar: BymaBottomNav(
        activeTab: _currentTab,
        onTabSelected: (tab) {
          // تم تبسيط الكود: بمجرد الضغط على أي تبويب، يتم الانتقال إليه داخل الـ Stack
          setState(() {
            _currentTab = tab; 
          });
        },
      ),
    );
  }
}