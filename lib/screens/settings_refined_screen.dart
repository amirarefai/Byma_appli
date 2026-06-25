import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'bookings_screen.dart';
import 'messages_final_navigation.dart';
import 'main_layout_screen.dart';
import 'profile_security_updated.dart';
import 'wallet_rewards_screen.dart';
import 'favorites_screen.dart';
import '../widgets/byma_bottom_nav.dart';

class SettingsRefinedScreen extends StatefulWidget {
  const SettingsRefinedScreen({super.key});

  @override
  State<SettingsRefinedScreen> createState() => _SettingsRefinedScreenState();
}

class _SettingsRefinedScreenState extends State<SettingsRefinedScreen> {
  bool _themeOn = false;
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
    final bg = const Color(0xFFF2F6F7);

    return Scaffold(
      backgroundColor: bg,
      // موجود دائماً "آخر الواجهة" حتى لو فتحت SettingsRefinedScreen من أي مكان
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
            return; // نفس الصفحة
          }
          if (tab == BymaBottomNavTab.home) {
            // Home بتنقلك للـ layout اللي فيه الـ BottomNav ويدير الـ tabs
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

              // Top row: BYMA + bell
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'BYMA',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                      fontSize: 18,
                      color: Color(0xFF0B2530),
                    ),
                  ),
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black.withOpacity(0.06)),
                    ),
                    child: const Icon(
                      Icons.notifications_none_outlined,
                      size: 18,
                      color: Color(0xFF0B2530),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // Avatar card
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
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF072332).withOpacity(0.18),
                            blurRadius: 18,
                            offset: const Offset(0, 8),
                          ),
                        ],
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
                                child: const Center(
                                  child: SizedBox(
                                    width: 54,
                                    height: 70,
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
                              title: const Text('Change photo'),
                              content: const Text('Select from Camera or Gallery'),
                              actions: [
                                TextButton(
                                  onPressed: () async {
                                    Navigator.of(ctx).pop();
                                    await _pickAvatar(ImageSource.camera);
                                  },
                                  child: const Text('Camera'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    Navigator.of(ctx).pop();
                                    await _pickAvatar(ImageSource.gallery);
                                  },
                                  child: const Text('Gallery'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.of(ctx).pop(),
                                  child: const Text('Cancel'),
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
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF4FC3C9).withOpacity(0.35),
                                blurRadius: 14,
                                offset: const Offset(0, 6),
                              ),
                            ],
                            border: Border.all(
                              width: 3,
                              color: bg,
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

              // Name + premium badge
              Center(
                child: Column(
                  children: [
                    const Text(
                      'Alex Curator',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF072332),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFBFE6F2).withOpacity(0.65),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Text(
                        'PREMIUM MEMBER',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.4,
                          color: Color(0xFF0F4B61),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 26),

              // 2-column stats
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      title: 'ACTIVE RENTALS',
                      value: '03',
                      icon: Icons.home_outlined,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _StatCard(
                      title: 'POINTS EARNED',
                      value: '1,240',
                      icon: Icons.stars_outlined,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 22),

              _SectionTitle(title: 'Manage Experience'),
              const SizedBox(height: 10),

                  _ActionGroup(
                items: [
                  _SettingRow(
                    leading: _CircleIcon(
                      bg: const Color(0xFFD7F0F6),
                      iconBg: const Color(0xFF2F7F8F),
                      icon: Icons.favorite_border,
                    ),
                    title: 'Favorites',
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
                    leading: _CircleIcon(
                      bg: const Color(0xFFD4E9EA),
                      iconBg: const Color(0xFF0F8E88),
                      icon: Icons.account_balance_wallet_outlined,
                    ),
                    title: 'Payment & Wallet',
                    subtitle: 'VISA •• 42',
                    trailingIcon: Icons.chevron_right,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const WalletRewardsScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 22),

              _SectionTitle(title: 'Preferences'),
              const SizedBox(height: 10),

              _ActionGroup(
                items: [
                  _SettingRow(
                    leading: _CircleIcon(
                      bg: const Color(0xFFD8E2E6),
                      iconBg: const Color(0xFF576E7C),
                      icon: Icons.settings_outlined,
                    ),
                    title: 'Account Settings',
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

              _SectionTitle(title: 'Accessibility'),
              const SizedBox(height: 10),

              _ActionGroup(
                items: [
                  _SettingRow(
                    leading: _CircleIcon(
                      bg: const Color(0xFFD8E2E6),
                      iconBg: const Color(0xFF576E7C),
                      icon: Icons.language_outlined,
                    ),
                    title: 'Language',
                    trailingWidget: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          'EN',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0F4B61),
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(
                          Icons.keyboard_arrow_down,
                          size: 18,
                          color: Color(0xFF0F4B61),
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                  const _SettingDivider(),
                  _SettingRow(
                    leading: _CircleIcon(
                      bg: const Color(0xFFD8E2E6),
                      iconBg: const Color(0xFF576E7C),
                      icon: Icons.nightlight_round_outlined,
                    ),
                    title: 'Theme',
                    trailingWidget: Switch(
                      value: _themeOn,
                      activeColor: const Color(0xFF0FA37A),
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: const Color(0xFFD5DADF),
                      onChanged: (v) => setState(() => _themeOn = v),
                    ),
                    onTap: () {},
                  ),
                ],
              ),

              const SizedBox(height: 22),

              _SectionTitle(title: 'Policies & Legal'),
              const SizedBox(height: 10),

              _ActionGroup(
                items: [
                  _SettingRow(
                    leading: _CircleIcon(
                      bg: const Color(0xFFD8E2E6),
                      iconBg: const Color(0xFF576E7C),
                      icon: Icons.description_outlined,
                    ),
                    title: 'Compensation Policy',
                    trailingIcon: Icons.chevron_right,
                    onTap: () {},
                  ),
                  const _SettingDivider(),
                  _SettingRow(
                    leading: _CircleIcon(
                      bg: const Color(0xFFD8E2E6),
                      iconBg: const Color(0xFF576E7C),
                      icon: Icons.event_note_outlined,
                    ),
                    title: 'Cancellation Terms',
                    trailingIcon: Icons.chevron_right,
                    onTap: () {},
                  ),
                  const _SettingDivider(),
                  _SettingRow(
                    leading: _CircleIcon(
                      bg: const Color(0xFFD8E2E6),
                      iconBg: const Color(0xFF576E7C),
                      icon: Icons.gavel_outlined,
                    ),
                    title: 'Legal Accountability',
                    trailingIcon: Icons.chevron_right,
                    onTap: () {},
                  ),
                ],
              ),

              const SizedBox(height: 22),

              // Logout button
              Container(
                height: 52,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0E9EC),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFFF0E9EC),
                  ),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.logout,
                        size: 18,
                        color: Color(0xFFEF3A2D),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'LOGOUT FROM BYMA',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFFEF3A2D),
                        ),
                      ),
                    ],
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
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.55),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFF1F2937).withOpacity(0.06),
        ),
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
                  border: Border.all(
                    color: const Color(0xFF0F8E88).withOpacity(0.14),
                  ),
                ),
                child: Icon(
                  icon,
                  size: 18,
                  color: const Color(0xFF0F4B61),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  value,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF072332),
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.55),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF1F2937).withOpacity(0.06)),
      ),
      child: Column(
        children: items,
      ),
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
      color: const Color(0xFF1F2937).withOpacity(0.06),
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
    final Widget trailing;
    if (trailingWidget != null) {
      trailing = trailingWidget!;
    } else if (trailingIcon != null) {
      trailing = Icon(
        trailingIcon,
        size: 18,
        color: const Color(0xFF0B2530),
      );
    } else {
      trailing = const SizedBox.shrink();
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            leading,
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF072332),
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
      decoration: BoxDecoration(
        color: bg,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: iconBg.withOpacity(0.14),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: iconBg.withOpacity(0.28)),
          ),
          child: Icon(
            icon,
            size: 16,
            color: iconBg,
          ),
        ),
      ),
    );
  }
}
