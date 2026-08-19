import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:easy_localization/easy_localization.dart';

import '../main.dart'; // للتحكم بالثيمات الثلاثة
import 'bookings_screen.dart';
import 'messages_final_navigation.dart';
import 'main_layout_screen.dart';
import 'profile_security_updated.dart';
import 'favorites_screen.dart';
import '../widgets/byma_bottom_nav.dart';

// استيراد الشاشات المطلوبة بعد تعديل أسمائها
import 'notifications_screen.dart';
import 'login_screen.dart';
// استيراد الشاشات الجديدة للاتصال بالأزرار
import 'recently_viewed_screen.dart';
import 'collections_screen.dart';
import 'withdrawa_screen.dart';
import 'deposit_request_screen.dart';
import 'withdrawa_history_screen.dart';
import 'deposit_history_screen.dart';
import 'convert_points_screen.dart';


class SettingsRefinedScreen extends StatefulWidget {
  const SettingsRefinedScreen({super.key});

  @override
  State<SettingsRefinedScreen> createState() => _SettingsRefinedScreenState();
}

class _SettingsRefinedScreenState extends State<SettingsRefinedScreen> {
  XFile? _avatarXFile;

  Future<void> _pickAvatar(ImageSource source) async {
    final picker = ImagePicker();
    final xfile = await picker.pickImage(source: source);
    if (!mounted) return;
    if (xfile == null) return;

    setState(() {
      _avatarXFile = xfile;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      bottomNavigationBar: BymaBottomNav(
        activeTab: BymaBottomNavTab.profile,
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
            return;
          }
          if (tab == BymaBottomNavTab.home) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const MainLayoutScreen()),
            );
            return;
          }
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),

              // الأعلى: الاسم والإشعارات
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'BYMA',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                      fontSize: 18,
                      color: theme.colorScheme.primary,
                    ),
                  ),

                  // زر الجرس بعد التفعيل وربطه بـ NotificationsScreen
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const NotificationsScreen(),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: theme.cardColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: theme.dividerColor),
                      ),
                      child: Icon(
                        Icons.notifications_none_outlined,
                        size: 18,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // الصورة الشخصية (الأفاتار)
              Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      width: 130,
                      height: 100,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF072332).withOpacity(0.85),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: _avatarXFile == null
                            ? Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0xFF0B2B3A),
                                      Color(0xFF0D3A4E),
                                    ],
                                  ),
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(18),
                                child: Image.file(
                                  File(_avatarXFile!.path),
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                    ),
                    Positioned(
                      right: -6,
                      bottom: 26,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(999),
                        onTap: () {
                          showDialog<void>(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: Text('change_photo_title'.tr()),
                              content: Text('change_photo_subtitle'.tr()),
                              actions: [
                                TextButton(
                                  onPressed: () async {
                                    Navigator.of(ctx).pop();
                                    await _pickAvatar(ImageSource.camera);
                                  },
                                  child: Text('camera_option'.tr()),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    Navigator.of(ctx).pop();
                                    await _pickAvatar(ImageSource.gallery);
                                  },
                                  child: Text('gallery_option'.tr()),
                                ),
                              ],
                            ),
                          );
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFF4FC3C9),
                            border: Border.all(
                              width: 3,
                              color: theme.scaffoldBackgroundColor,
                            ),
                          ),
                          child: const Icon(
                            Icons.edit,
                            size: 18,
                            color: Color(0xFF08313F),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // الاسم
              Center(
                child: Column(
                  children: [
                    Text(
                      'Alex Curator',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 26),

              // الإحصائيات (الكرت الثنائي)
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      title: 'Balance'.tr(),
                      value: '03',
                     icon: Icons.payments_outlined,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _StatCard(
                      title: 'points_earned_label'.tr(),
                      value: '1,240',
                      icon: Icons.stars_outlined,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 22),

              // مجموعة الأزرار الأولى (المفضلة، شوهد مؤخراً، المجموعات)
              _ActionGroup(
                items: [
                  _SettingRow(
                    leading: const _CircleIcon(
                      bg: Color(0xFFD7F0F6),
                      iconBg: Color(0xFF2F7F8F),
                      icon: Icons.favorite_border,
                    ),
                    title: 'favorites_title'.tr(),
                    trailingIcon: Icons.chevron_right,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const FavoritesScreen(),
                        ),
                      );
                    },
                  ),
                  const _SettingDivider(),
                  _SettingRow(
                    leading: const _CircleIcon(
                      bg: Color(0xFFE2F3F5),
                      iconBg: Color(0xFF0E7E8A),
                      icon: Icons.history_outlined,
                    ),
                    title: 'recently_viewed_title'.tr(),
                    trailingIcon: Icons.chevron_right,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const RecentlyViewedScreen(),
                        ),
                      );
                    },
                  ),
                  const _SettingDivider(),
                  _SettingRow(
                    leading: const _CircleIcon(
                      bg: Color(0xFFE8F1F5),
                      iconBg: Color(0xFF4A7A96),
                      icon: Icons.folder_open_outlined,
                    ),
                    title: 'collections_title'.tr(),
                    trailingIcon: Icons.chevron_right,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const CollectionsScreen()),
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 22),

              _ActionGroup(
                items: [
                  _SettingRow(
                    leading: const _CircleIcon(
                      bg: Color(0xFFD8E2E6),
                      iconBg: Color(0xFF576E7C),
                      icon: Icons.settings_outlined,
                    ),
                    title: 'account_settings_title'.tr(),
                    trailingIcon: Icons.chevron_right,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const ProfileSecurityUpdated(),
                        ),
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 22),

              _ActionGroup(
                items: [
                  _SettingRow(
                    leading: const _CircleIcon(
                      bg: Color(0xFFD8E2E6),
                      iconBg: Color(0xFF576E7C),
                      icon: Icons.language_outlined,
                    ),
                    title: 'language_title'.tr(),
                    trailingWidget: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          context.locale.languageCode.toUpperCase(),
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: theme.colorScheme.primary,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Icon(
                          Icons.swap_horiz,
                          size: 18,
                          color: theme.colorScheme.primary,
                        ),
                      ],
                    ),
                    onTap: () {
                      if (context.locale.languageCode == 'en') {
                        context.setLocale(const Locale('ar'));
                      } else {
                        context.setLocale(const Locale('en'));
                      }
                    },
                  ),
                  const _SettingDivider(),
                  _SettingRow(
                    leading: const _CircleIcon(
                      bg: Color(0xFFD8E2E6),
                      iconBg: Color(0xFF576E7C),
                      icon: Icons.palette_outlined,
                    ),
                    title: 'theme_title'.tr(),
                    trailingIcon: Icons.arrow_drop_down,
                    onTap: () {
                      showModalBottomSheet<void>(
                        context: context,
                        backgroundColor: theme.cardColor,
                        builder: (ctx) => SafeArea(
                          child: Wrap(
                            children: [
                              ListTile(
                                leading: const Icon(Icons.wb_sunny_outlined),
                                title: Text(
                                  'theme_light'.tr(),
                                  style: TextStyle(
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                                onTap: () {
                                  BymaApp.of(context)?.changeTheme('light');
                                  Navigator.pop(ctx);
                                },
                              ),
                              ListTile(
                                leading: const Icon(
                                  Icons.nightlight_round_outlined,
                                ),
                                title: Text(
                                  'theme_dark'.tr(),
                                  style: TextStyle(
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                                onTap: () {
                                  BymaApp.of(context)?.changeTheme('dark');
                                  Navigator.pop(ctx);
                                },
                              ),
                              ListTile(
                                leading: const Icon(
                                  Icons.visibility_outlined,
                                  color: Colors.yellow,
                                ),
                                title: Text(
                                  'theme_high_contrast'.tr(),
                                  style: TextStyle(
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                                onTap: () {
                                  BymaApp.of(
                                    context,
                                  )?.changeTheme('high_contrast');
                                  Navigator.pop(ctx);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 22),

              _SectionTitle(title: 'Financial'.tr()),
              const SizedBox(height: 10),

              _ActionGroup(
                items: [
                 _SettingRow(
                    leading: const _CircleIcon(
                      bg: Color(0xFFD8E2E6),
                      iconBg: Color(0xFF576E7C),
                      icon: Icons.calendar_today_outlined,
                    ),
                    title: 'reservations'.tr(),
                    trailingIcon: Icons.chevron_right,
                    onTap: () {},
                  ),
                  const _SettingDivider(),
                  _SettingRow(
                    leading: const _CircleIcon(
                      bg: Color(0xFFD8E2E6),
                      iconBg: Color(0xFF576E7C),
                      icon: Icons.stars_outlined,
                    ),
                    title: 'points transformation'.tr(),
                    trailingIcon: Icons.chevron_right,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ConvertPointsScreen(),
                        ),
                      );
                    },
                  ),
                  const _SettingDivider(),
                  _SettingRow(
                    leading: const _CircleIcon(
                      bg: Color(0xFFD8E2E6),
                      iconBg: Color(0xFF576E7C),
                      icon: Icons.upload_outlined,
                    ),
                    title: 'withdraw request'.tr(),
                    trailingIcon: Icons.chevron_right,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const WithdrawaScreen(),
                        ),
                      );
                    },
                  ),
                  const _SettingDivider(),
                  _SettingRow(
                    leading: const _CircleIcon(
                      bg: Color(0xFFD8E2E6),
                      iconBg: Color(0xFF576E7C),
                      icon: Icons.download_outlined,
                    ),
                    title: 'deposit request'.tr(),
                    trailingIcon: Icons.chevron_right,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const DepositRequestScreen(),
                        ),
                      );
                    },
                  ),
                  const _SettingDivider(),
                  _SettingRow(
                    leading: const _CircleIcon(
                      bg: Color(0xFFD8E2E6),
                      iconBg: Color(0xFF576E7C),
                      icon: Icons.history,
                    ),
                    title: 'withdraw transformation history'.tr(),
                    trailingIcon: Icons.chevron_right,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const WithdrawaHistoryScreen(),
                        ),
                      );
                    },
                  ),
                  const _SettingDivider(),
                  _SettingRow(
                    leading: const _CircleIcon(
                      bg: Color(0xFFD8E2E6),
                      iconBg: Color(0xFF576E7C),
                      icon: Icons.receipt_long_outlined,
                    ),
                    title: 'deposit transformation history'.tr(),
                    trailingIcon: Icons.chevron_right,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const DepositHistoryScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 22),

              // زر تسجيل الخروج
              InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false,
                  );
                },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  height: 52,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0E9EC),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.logout,
                          size: 18,
                          color: Color(0xFFEF3A2D),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'logout_button_text'.tr(),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFFEF3A2D),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: theme.dividerColor),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 1,
              color: Color(0xFF7C8FA0),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF9FA),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 18, color: const Color(0xFF0F4B61)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.w900,
        letterSpacing: 0.4,
        fontSize: 13,
        color: Color(0xFF0F4B61),
      ),
    );
  }
}

class _ActionGroup extends StatelessWidget {
  final List<Widget> items;
  const _ActionGroup({required this.items});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(children: items),
    );
  }
}

class _SettingDivider extends StatelessWidget {
  const _SettingDivider();

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: Theme.of(context).dividerColor,
    );
  }
}

class _SettingRow extends StatelessWidget {
  final Widget leading;
  final String title;
  final String? subtitle;
  final IconData? trailingIcon;
  final Widget? trailingWidget;
  final VoidCallback onTap;

  const _SettingRow({
    required this.leading,
    required this.title,
    this.subtitle,
    this.trailingIcon,
    this.trailingWidget,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Widget trailing =
        trailingWidget ??
        (trailingIcon != null
            ? Icon(trailingIcon, size: 18, color: theme.colorScheme.primary)
            : const SizedBox.shrink());

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Row(
          children: [
            leading,
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle!,
                      style: const TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF7C8FA0),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}

class _CircleIcon extends StatelessWidget {
  final Color bg;
  final Color iconBg;
  final IconData icon;

  const _CircleIcon({
    required this.bg,
    required this.iconBg,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
      child: Center(
        child: Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: iconBg.withOpacity(0.14),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: 16, color: iconBg),
        ),
      ),
    );
  }
}
