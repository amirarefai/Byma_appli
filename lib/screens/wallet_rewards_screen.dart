import 'package:flutter/material.dart';

class WalletRewardsScreen extends StatelessWidget {
  const WalletRewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFFF2F6F7);
    const deepTeal = Color(0xFF072332);
    const tealBrand = Color(0xFF0B6B7C);
    const aquaBrand = Color(0xFF4FC3C9);

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _TopBar(
              title: 'Wallet & Rewards',
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
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFF0B6B7C), Color(0xFF6ED2E4)],
                        ),
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  'BYMA WALLET BALANCE',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 1.2,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.22),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.22),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.copy,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            '\$4,250.00',
                            style: TextStyle(
                              fontSize: 44,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              height: 1.05,
                            ),
                          ),
                          const SizedBox(height: 14),
                          Row(
                            children: const [
                              Icon(
                                Icons.verified_rounded,
                                size: 18,
                                color: Colors.white,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'SECURED & ENCRYPTED',
                                style: TextStyle(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 0.8,
                                  color: Colors.white,
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
                        color: Colors.white.withOpacity(0.88),
                        borderRadius: BorderRadius.circular(26),
                        border: Border.all(
                          color: deepTeal.withOpacity(0.11),
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
                              color: const Color(0xFFD9F7F3),
                              border: Border.all(
                                color: const Color(0xFF19B9A7).withOpacity(0.25),
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF19B9A7).withOpacity(0.15),
                                  blurRadius: 16,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.star_rounded,
                              color: Color(0xFF0FA37A),
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
                                    const Text(
                                      'REWARD POINTS',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 13,
                                        color: Color(0xFF072332),
                                      ),
                                    ),
                                    const Spacer(),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF6DE6D3)
                                            .withOpacity(0.35),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Text(
                                        '+15%',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          color: Color(0xFF0FA37A),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  '1,250 pts',
                                  style: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xFF072332),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                const Text(
                                  'Redeem for exclusive rentals',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xFF0FA37A),
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
                      left: 'Payment Methods',
                      rightText: 'Manage',
                    ),

                    const SizedBox(height: 10),

                    // Primary source card
                    Container(
                      padding: const EdgeInsets.fromLTRB(18, 18, 16, 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2A3B45).withOpacity(0.95),
                        borderRadius: BorderRadius.circular(26),
                        border: Border.all(
                          color: Colors.black.withOpacity(0.08),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: deepTeal.withOpacity(0.22),
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
                                color: aquaBrand.withOpacity(0.18),
                                width: 2,
                              ),
                            ),
                            child: const Icon(
                              Icons.credit_card_rounded,
                              size: 24,
                              color: Color(0xFF1DD3C0),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'PRIMARY SOURCE',
                                  style: TextStyle(
                                    fontSize: 11.5,
                                    letterSpacing: 2,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white70,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'BYMA Wallet',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 22),
                                const Text(
                                  'Available Balance',
                                  style: TextStyle(
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
                                  color: const Color(0xFF0FA37A).withOpacity(0.18),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: const Icon(
                                  Icons.copy,
                                  size: 18,
                                  color: Color(0xFF0FA37A),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: aquaBrand.withOpacity(0.45),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'ACTIVE',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        color: Color(0xFF06343A),
                                        fontSize: 12.5,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      size: 18,
                                      color: Color(0xFF06343A),
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
                      left: 'Recent Activity',
                      rightIcon: Icons.filter_list,
                      rightText: null,
                    ),

                    const SizedBox(height: 10),

                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.88),
                        borderRadius: BorderRadius.circular(26),
                      ),
                      child: Column(
                        children: [
                          _ActivityRow(
                            iconBg: const Color(0xFF6ED2E4).withOpacity(0.25),
                            icon: Icons.location_city_outlined,
                            title: 'The Glass House',
                            subtitle: 'Rental',
                            dateText: 'May 12, 2024 • 02:30 PM',
                            amountText: '- \$1,200.00',
                            amountColor: const Color(0xFFEF4444),
                            statusText: 'PENDING',
                          ),
                          const SizedBox(height: 14),
                          _ActivityRow(
                            iconBg: const Color(0xFF7CF5D8).withOpacity(0.22),
                            icon: Icons.emoji_events_outlined,
                            title: 'Loyalty Reward',
                            subtitle: 'Points',
                            dateText: 'May 10, 2024 • 11:15 AM',
                            amountText: '+ 250 pts',
                            amountColor: const Color(0xFF0FA37A),
                            statusText: 'EARNED',
                          ),
                          const SizedBox(height: 14),
                          _ActivityRow(
                            iconBg: const Color(0xFF9CA3AF).withOpacity(0.22),
                            icon: Icons.receipt_long_outlined,
                            title: 'Wallet Refund',
                            subtitle: '',
                            dateText: 'May 08, 2024 • 09:00 AM',
                            amountText: '+ \$45.00',
                            amountColor: const Color(0xFF0B88FF),
                            statusText: 'COMPLETED',
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.85),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.black.withOpacity(0.06)),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 18),
              onPressed: onBack,
              splashRadius: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 22,
                color: Color(0xFF072332),
              ),
            ),
          ),
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.85),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.black.withOpacity(0.06)),
            ),
            child: const Icon(
              Icons.notifications_none_outlined,
              size: 20,
              color: Color(0xFF072332),
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
    return Row(
      children: [
        Expanded(
          child: Text(
            left,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: Color(0xFF072332),
            ),
          ),
        ),
        if (rightText != null) ...[
          Text(
            rightText!,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Color(0xFF0B2530),
            ),
          ),
        ] else if (rightIcon != null) ...[
          Icon(
            rightIcon,
            size: 22,
            color: const Color(0xFF0B2530),
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
              color: const Color(0xFF0B6B7C),
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
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF072332),
                ),
              ),
              if (subtitle.isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF334D5C),
                  ),
                ),
              ],
              const SizedBox(height: 6),
              Text(
                dateText,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black.withOpacity(0.5),
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
