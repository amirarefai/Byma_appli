import 'package:flutter/material.dart';

enum BymaBottomNavTab { home, bookings, chat, profile }

class BymaBottomNav extends StatelessWidget {
  final BymaBottomNavTab activeTab;
  final ValueChanged<BymaBottomNavTab> onTabSelected; // يحل مشكلة الخطأ الأحمر في مشروعك

  const BymaBottomNav({
    super.key, 
    required this.activeTab, 
    required this.onTabSelected,
  });

  Color _activeColor(BuildContext context) => const Color(0xFF0FA37A);
  Color _inactiveTextColor(BuildContext context) => const Color(0xFF94A3B8);

  @override
  Widget build(BuildContext context) {
    final activeColor = _activeColor(context);
    final inactiveColor = _inactiveTextColor(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 0, 18, 14),
      child: Container(
        height: 74,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.96),
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 18,
              offset: const Offset(0, 8),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(
              icon: Icons.home_outlined,
              label: 'HOME',
              active: activeTab == BymaBottomNavTab.home,
              onTap: () => onTabSelected(BymaBottomNavTab.home),
              activeColor: activeColor,
              inactiveColor: inactiveColor,
            ),
            _NavItem(
              icon: Icons.calendar_today_outlined,
              label: 'BOOKINGS',
              active: activeTab == BymaBottomNavTab.bookings,
              onTap: () => onTabSelected(BymaBottomNavTab.bookings), // يأخذك لواجهة الحجوزات فوراً
              activeColor: activeColor,
              inactiveColor: inactiveColor,
            ),
            _NavItem(
              icon: Icons.chat_bubble_outline,
              label: 'CHAT',
              active: activeTab == BymaBottomNavTab.chat,
              onTap: () => onTabSelected(BymaBottomNavTab.chat),
              activeColor: activeColor,
              inactiveColor: inactiveColor,
            ),
            _NavItem(
              icon: Icons.person_outline,
              label: 'PROFILE',
              active: activeTab == BymaBottomNavTab.profile,
              onTap: () => onTabSelected(BymaBottomNavTab.profile),
              activeColor: activeColor,
              inactiveColor: inactiveColor,
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;
  final Color activeColor;
  final Color inactiveColor;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    final color = active ? activeColor : inactiveColor;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (active)
              Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                  color: activeColor,
                  shape: BoxShape.circle,
                ),
              )
            else
              const SizedBox(height: 4),
            const SizedBox(height: 2),
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 11.5,
                letterSpacing: 1,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}