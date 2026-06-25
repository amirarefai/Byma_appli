import 'package:flutter/material.dart';

class FinalizeReservationScreen extends StatefulWidget {
  final String roomTitle;
  final String pricePerNight;

  const FinalizeReservationScreen({
    super.key,
    required this.roomTitle,
    required this.pricePerNight,
  });

  @override
  State<FinalizeReservationScreen> createState() => _FinalizeReservationScreenState();
}

class _FinalizeReservationScreenState extends State<FinalizeReservationScreen> {
  int _selectedPayment = 0;
  bool _acceptedPolicy = false;

  @override
  Widget build(BuildContext context) {
    const teal = Color(0xFF0E6F63);
    const teal2 = Color(0xFF0FA37A);

    final bg = const Color(0xFFF2F6F8);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.0),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Secure Booking',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        centerTitle: false,
        actions: const [
          Icon(Icons.more_vert),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(18, 8, 18, 18),
                children: [
                  const SizedBox(height: 8),
                  const Text(
                    'PAYMENT METHOD',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 12,
                      color: Colors.black54,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Finalize your\nreservation.',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 40,
                      height: 1.05,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 18),

                  _PaymentOption(
                    index: 0,
                    selectedIndex: _selectedPayment,
                    title: 'PAY AT ARRIVAL',
                    subtitle: 'NO PREPAYMENT NEEDED',
                    iconBackground: teal,
                    icon: Icons.credit_card,
                    iconColor: Colors.white,
                  ),
                  const SizedBox(height: 14),
                  _PaymentOption(
                    index: 1,
                    selectedIndex: _selectedPayment,
                    title: 'BANK TRANSFER',
                    subtitle: '1–2 BUSINESS DAYS',
                    iconBackground: const Color(0xFF0E6F63),
                    icon: Icons.account_balance_outlined,
                    iconColor: Colors.white,
                  ),
                  const SizedBox(height: 14),
                  _PaymentOption(
                    index: 2,
                    selectedIndex: _selectedPayment,
                    title: 'SHAM CASH',
                    subtitle: 'INSTANT WALLET TRANSFER',
                    iconBackground: const Color(0xFF2A3D4B),
                    icon: Icons.payment_rounded,
                    iconColor: Colors.white,
                  ),
                  const SizedBox(height: 14),
                  _PaymentOption(
                    index: 3,
                    selectedIndex: _selectedPayment,
                    title: 'MONEY TRANSFER\nCOMPANIES',
                    subtitle: 'GLOBAL REACH',
                    iconBackground: const Color(0xFF71D3FF),
                    icon: Icons.store,
                    iconColor: Colors.white,
                  ),
                  const SizedBox(height: 14),
                  _PaymentOption(
                    index: 4,
                    selectedIndex: _selectedPayment,
                    title: 'MY WALLET',
                    subtitle: 'USE YOUR AVAILABLE BALANCE',
                    iconBackground: teal,
                    icon: Icons.wallet_rounded,
                    iconColor: Colors.white,
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      _TinyBadge(leftIcon: Icons.shield, text1: 'SECURE SSL', text2: 'ENCRYPTION'),
                      _TinyBadge(leftIcon: Icons.security, text1: 'FRAUD PROTECTION', text2: 'ACTIVE'),
                    ],
                  ),

                  const SizedBox(height: 14),

                  Row(
                    children: [
                      Checkbox(
                        value: _acceptedPolicy,
                        onChanged: (v) => setState(() => _acceptedPolicy = v ?? false),
                        activeColor: teal2,
                      ),
                      Expanded(
                        child: const Text(
                          'I agree to the Booking Policies and Cancellation Terms.',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),

            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                child: SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _acceptedPolicy
                        ? () {
                            // TODO: Connect to real booking/payment logic
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Confirmed & paying now...')),
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: teal2.withOpacity(_acceptedPolicy ? 1 : 0.5),
                      disabledBackgroundColor: teal2.withOpacity(0.5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    child: const Text(
                      'CONFIRM & PAY NOW',
                      style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, letterSpacing: 0.8),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PaymentOption extends StatelessWidget {
  final int index;
  final int selectedIndex;
  final String title;
  final String subtitle;
  final Color iconBackground;
  final IconData icon;
  final Color iconColor;

  const _PaymentOption({
    required this.index,
    required this.selectedIndex,
    required this.title,
    required this.subtitle,
    required this.iconBackground,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final state = context.findAncestorStateOfType<_FinalizeReservationScreenState>();
        if (state != null) {
          state.setState(() => state._selectedPayment = index);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(26),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: iconBackground,
              radius: 34,
              child: Icon(icon, color: iconColor, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                      height: 1.0,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 11,
                      color: Colors.black54.withOpacity(0.75),
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),
            Radio<int>(
              value: index,
              groupValue: selectedIndex,
              onChanged: (_) {
                final state = context.findAncestorStateOfType<_FinalizeReservationScreenState>();
                if (state != null) {
                  state.setState(() => state._selectedPayment = index);
                }
              },
              activeColor: const Color(0xFF0FA37A),
            ),
          ],
        ),
      ),
    );
  }
}

class _TinyBadge extends StatelessWidget {
  final IconData leftIcon;
  final String text1;
  final String text2;

  const _TinyBadge({
    required this.leftIcon,
    required this.text1,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(leftIcon, color: const Color(0xFF0FA37A), size: 18),
        const SizedBox(height: 6),
        Text(
          text1,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 11),
        ),
        Text(
          text2,
          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 11, color: Colors.black54),
        ),
      ],
    );
  }
}

// Needed for access from _PaymentOption
extension _FindFinalizeState on BuildContext {
  _FinalizeReservationScreenState? get finalizeState =>
      findAncestorStateOfType<_FinalizeReservationScreenState>();
}
