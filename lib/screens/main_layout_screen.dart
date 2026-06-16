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
    return Scaffold(
      // الـ IndexedStack يقوم بعرض الشاشة المطلوبة بناءً على الـ index
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
    const BymaChatScreen(),
    const SettingsRefinedScreen(),
  ],
),
      extendBody: true, 
      bottomNavigationBar: BymaBottomNav(
        activeTab: _currentTab,
        onTabSelected: (tab) {
          if (tab == BymaBottomNavTab.bookings) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const BookingsScreen()),
            );
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
            setState(() {
              _currentTab = tab;
            });
            return;
          }

          setState(() {
            _currentTab = tab; // تحديث الواجهة فوراً عند الضغط
          });
        },
      ),
    );
  }
}