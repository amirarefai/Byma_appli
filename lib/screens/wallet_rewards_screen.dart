import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class WalletRewardsScreen extends StatelessWidget {
  const WalletRewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _TopBar(
              title: 'wallet_rewards_title'.tr(),
              onBack: () => Navigator.pop(context),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // BYMA WALLET BALANCE CARD
                    Container(
                      padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            theme.colorScheme.primary,
                            theme.colorScheme.primary.withOpacity(0.6),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'wallet_balance_label'.tr(),
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 1.2,
                                    color: theme.colorScheme.onPrimary,
                                  ),
                                ),
                              ),
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.onPrimary.withOpacity(0.22),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: theme.colorScheme.onPrimary.withOpacity(0.22),
                                  ),
                                ),
                                child: Icon(
                                  Icons.copy,
                                  color: theme.colorScheme.onPrimary,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            '\$4,250.00', // يمكن ربطه لاحقاً بمتغير قادم من السيرفر أو الكيوبيت
                            style: TextStyle(
                              fontSize: 44,
                              fontWeight: FontWeight.w900,
                              color: theme.colorScheme.onPrimary,
                              height: 1.05,
                            ),
                          ),
                          const SizedBox(height: 14),
                          Row(
                            children: [
                              Icon(
                                Icons.verified_rounded,
                                size: 18,
                                color: theme.colorScheme.onPrimary,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'secured_encrypted'.tr(),
                                style: TextStyle(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 0.8,
                                  color: theme.colorScheme.onPrimary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Reward points card
                    Container(
                      padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
                      decoration: BoxDecoration(
                        color: theme.cardColor,
                        borderRadius: BorderRadius.circular(26),
                        border: Border.all(
                          color: theme.dividerColor.withOpacity(0.2),
                          width: 2,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: theme.colorScheme.secondary.withOpacity(0.15),
                              border: Border.all(
                                color: theme.colorScheme.secondary.withOpacity(0.3),
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: theme.colorScheme.secondary.withOpacity(0.1),
                                  blurRadius: 16,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.star_rounded,
                              color: theme.colorScheme.secondary,
                              size: 26,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'reward_points_label'.tr(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 13,
                                        color: theme.textTheme.titleLarge?.color,
                                      ),
                                    ),
                                    const Spacer(),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: theme.colorScheme.secondary.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        '+15%',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          color: theme.colorScheme.secondary,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  '1,250 ${'pts'.tr()}',
                                  style: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.w900,
                                    color: theme.textTheme.titleLarge?.color,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'redeem_hint'.tr(),
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: theme.colorScheme.secondary,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 22),

                    // Payment Methods header
                    _SectionHeader(
                      left: 'payment_methods_title'.tr(),
                      rightText: 'manage_btn'.tr(),
                    ),

                    const SizedBox(height: 10),

                    // Primary source card
                    Container(
                      padding: const EdgeInsets.fromLTRB(18, 18, 16, 16),
                      decoration: BoxDecoration(
                        color: theme.brightness == Brightness.light 
                            ? const Color(0xFF2A3B45) 
                            : theme.cardColor,
                        borderRadius: BorderRadius.circular(26),
                        border: Border.all(
                          color: theme.dividerColor.withOpacity(0.3),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 22,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 58,
                            height: 58,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: theme.colorScheme.primary.withOpacity(0.4),
                                width: 2,
                              ),
                            ),
                            child: Icon(
                              Icons.credit_card_rounded,
                              size: 24,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'primary_source_label'.tr(),
                                  style: const TextStyle(
                                    fontSize: 11.5,
                                    letterSpacing: 2,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white70,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'byma_wallet_text'.tr(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 22),
                                Text(
                                  'available_balance_label'.tr(),
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white60,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                const Text(
                                  '\$4,250.00',
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.secondary.withOpacity(0.18),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Icon(
                                  Icons.copy,
                                  size: 18,
                                  color: theme.colorScheme.secondary,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primary.withOpacity(0.45),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'status_active'.tr(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        color: theme.brightness == Brightness.light ? const Color(0xFF06343A) : Colors.white,
                                        fontSize: 12.5,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      size: 18,
                                      color: theme.brightness == Brightness.light ? const Color(0xFF06343A) : Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 22),

                    // Recent Activity header
                    _SectionHeader(
                      left: 'recent_activity_title'.tr(),
                      rightIcon: Icons.filter_list,
                      rightText: null,
                    ),

                    const SizedBox(height: 10),

                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: theme.cardColor,
                        borderRadius: BorderRadius.circular(26),
                        border: Border.all(color: theme.dividerColor.withOpacity(0.1)),
                      ),
                      child: Column(
                        children: [
                          _ActivityRow(
                            iconBg: theme.colorScheme.primary.withOpacity(0.15),
                            icon: Icons.location_city_outlined,
                            title: 'The Glass House',
                            subtitle: 'activity_type_rental'.tr(),
                            dateText: 'May 12, 2024 • 02:30 PM',
                            amountText: '- \$1,200.00',
                            amountColor: Colors.redAccent,
                            statusText: 'status_pending'.tr(),
                          ),
                          const SizedBox(height: 14),
                          _ActivityRow(
                            iconBg: theme.colorScheme.secondary.withOpacity(0.15),
                            icon: Icons.emoji_events_outlined,
                            title: 'loyalty_reward_title'.tr(),
                            subtitle: 'activity_type_points'.tr(),
                            dateText: 'May 10, 2024 • 11:15 AM',
                            amountText: '+ 250 pts',
                            amountColor: theme.colorScheme.secondary,
                            statusText: 'status_earned'.tr(),
                          ),
                          const SizedBox(height: 14),
                          _ActivityRow(
                            iconBg: theme.disabledColor.withOpacity(0.15),
                            icon: Icons.receipt_long_outlined,
                            title: 'wallet_refund_title'.tr(),
                            subtitle: '',
                            dateText: 'May 08, 2024 • 09:00 AM',
                            amountText: '+ \$45.00',
                            amountColor: Colors.blueAccent,
                            statusText: 'status_completed'.tr(),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final String title;
  final VoidCallback onBack;

  const _TopBar({required this.title, required this.onBack});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: theme.dividerColor.withOpacity(0.2)),
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new, size: 18, color: theme.textTheme.titleLarge?.color),
              onPressed: onBack,
              splashRadius: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 22,
                color: theme.textTheme.titleLarge?.color,
              ),
            ),
          ),
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: theme.dividerColor.withOpacity(0.2)),
            ),
            child: Icon(
              Icons.notifications_none_outlined,
              size: 20,
              color: theme.textTheme.titleLarge?.color,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String left;
  final String? rightText;
  final IconData? rightIcon;

  const _SectionHeader({
    required this.left,
    this.rightText,
    this.rightIcon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: Text(
            left,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: theme.textTheme.titleLarge?.color,
            ),
          ),
        ),
        if (rightText != null) ...[
          Text(
            rightText!,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: theme.colorScheme.primary,
            ),
          ),
        ] else if (rightIcon != null) ...[
          Icon(
            rightIcon,
            size: 22,
            color: theme.textTheme.titleLarge?.color,
          ),
        ],
      ],
    );
  }
}

class _ActivityRow extends StatelessWidget {
  final Color iconBg;
  final IconData icon;
  final String title;
  final String subtitle;
  final String dateText;
  final String amountText;
  final Color amountColor;
  final String statusText;

  const _ActivityRow({
    required this.iconBg,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.dateText,
    required this.amountText,
    required this.amountColor,
    required this.statusText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: iconBg,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Center(
            child: Icon(
              icon,
              size: 22,
              color: theme.colorScheme.primary,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: theme.textTheme.titleLarge?.color,
                ),
              ),
              if (subtitle.isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: theme.textTheme.bodyMedium?.color?.withOpacity(0.8),
                  ),
                ),
              ],
              const SizedBox(height: 6),
              Text(
                dateText,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: theme.hintColor,
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              amountText,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: amountColor,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              statusText,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w900,
                color: amountColor,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ],
    );
  }
}