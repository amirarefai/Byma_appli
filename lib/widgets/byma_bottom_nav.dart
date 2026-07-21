import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

enum BymaBottomNavTab { home, bookings, chat, profile }

class BymaBottomNav extends StatelessWidget {
  final BymaBottomNavTab activeTab;
  final ValueChanged<BymaBottomNavTab> onTabSelected;

  const BymaBottomNav({
    super.key, 
    required this.activeTab, 
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    // جلب الثيم الحالي المطبق في ملف main.dart مباشرة
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // تحديد ما إذا كان الثيم الحالي هو وضع التباين العالي (High Contrast)
    final isHighContrast = colorScheme.primary == Colors.yellow;

    // ربط ألوان الـ Container بألوان الثيم الممرر من الـ main.dart
    final containerBg = theme.cardColor; 
    final containerBorder = theme.dividerColor;

    // ربط الألوان النشطة وغير النشطة بألوان الـ ColorScheme المحددة لديك
    final activeColor = colorScheme.primary;
    final inactiveColor = colorScheme.tertiary;

    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 0, 18, 14),
      child: Container(
        height: 74,
        decoration: BoxDecoration(
          color: containerBg,
          borderRadius: BorderRadius.circular(40),
          // إضافة حواف بارزة فقط في وضع التباين العالي أو الوضع الداكن لتحديد الواجهة
          border: Border.all(
            color: containerBorder, 
            width: isHighContrast ? 2 : 1,
          ),
          boxShadow: isHighContrast ? [] : [
            BoxShadow(
              color: Colors.black.withOpacity(theme.brightness == Brightness.dark ? 0.25 : 0.06),
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
              label: 'home_tab'.tr(),
              active: activeTab == BymaBottomNavTab.home,
              onTap: () => onTabSelected(BymaBottomNavTab.home),
              activeColor: activeColor,
              inactiveColor: inactiveColor,
            ),
            _NavItem(
              icon: Icons.calendar_month_outlined,
              label: 'bookings_tab'.tr(),
              active: activeTab == BymaBottomNavTab.bookings,
              onTap: () => onTabSelected(BymaBottomNavTab.bookings),
              activeColor: activeColor,
              inactiveColor: inactiveColor,
            ),
            _NavItem(
              icon: Icons.chat_bubble_outline,
              label: 'chat_tab'.tr(),
              active: activeTab == BymaBottomNavTab.chat,
              onTap: () => onTabSelected(BymaBottomNavTab.chat),
              activeColor: activeColor,
              inactiveColor: inactiveColor,
            ),
            _NavItem(
              icon: Icons.person_outline,
              label: 'profile_tab'.tr(),
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
                width: 5,
                height: 5,
                decoration: BoxDecoration(
                  color: activeColor,
                  shape: BoxShape.circle,
                ),
              )
            else
              const SizedBox(height: 5),
            const SizedBox(height: 2),
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 11.5,
                letterSpacing: 0.5,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}