import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart'; // استيراد حزمة الترجمة

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
    // جلب ألوان الثيم ديناميكياً
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    // ألوان الهوية البصرية (تتكيف مع وضع الثيم)
    final tealColor = isDarkMode ? const Color(0xFF0FA37A) : const Color(0xFF0E6F63);
    final accentTeal = const Color(0xFF0FA37A);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: theme.iconTheme.color),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'finalize_secure_booking'.tr(), // مترجم
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: theme.textTheme.titleLarge?.color,
          ),
        ),
        centerTitle: false,
        actions: const [], // تم إفراغ القائمة وحذف زر الثلاث نقاط من هنا
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(18, 8, 18, 18),
                children: [
                  const SizedBox(height: 8),
                  Text(
                    'finalize_payment_method'.tr().toUpperCase(), // مترجم
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 12,
                      color: theme.hintColor,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'finalize_title'.tr(), // مترجم
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 40,
                      height: 1.05,
                      color: theme.textTheme.headlineLarge?.color,
                    ),
                  ),
                  const SizedBox(height: 18),

                  // تم الإبقاء على خياري الدفع عند الوصول والتحويل البنكي فقط
                  _PaymentOption(
                    index: 0,
                    selectedIndex: _selectedPayment,
                    title: 'pay_at_arrival_title'.tr().toUpperCase(),
                    subtitle: 'pay_at_arrival_sub'.tr().toUpperCase(),
                    iconBackground: tealColor,
                    icon: Icons.credit_card,
                    iconColor: Colors.white,
                  ),
                  const SizedBox(height: 14),
                  _PaymentOption(
                    index: 1,
                    selectedIndex: _selectedPayment,
                    title: 'bank_transfer_title'.tr().toUpperCase(),
                    subtitle: 'bank_transfer_sub'.tr().toUpperCase(),
                    iconBackground: tealColor,
                    icon: Icons.account_balance_outlined,
                    iconColor: Colors.white,
                  ),

                  const SizedBox(height: 20),

                  // شارات الأمان والحماية المترجمة
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _TinyBadge(
                        leftIcon: Icons.shield, 
                        text1: 'badge_secure_ssl'.tr().toUpperCase(), 
                        text2: 'badge_encryption'.tr().toUpperCase(),
                      ),
                      _TinyBadge(
                        leftIcon: Icons.security, 
                        text1: 'badge_fraud_protection'.tr().toUpperCase(), 
                        text2: 'badge_active'.tr().toUpperCase(),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // الموافقة على الشروط والسياسات
                  Row(
                    children: [
                      Checkbox(
                        value: _acceptedPolicy,
                        onChanged: (v) => setState(() => _acceptedPolicy = v ?? false),
                        activeColor: accentTeal,
                        checkColor: Colors.white,
                        side: BorderSide(color: theme.hintColor),
                      ),
                      Expanded(
                        child: Text(
                          'finalize_agree_policy'.tr(), // مترجم
                          textAlign: TextAlign.start, // يدعم اتجاهات اللغات تلقائياً
                          style: TextStyle(
                            color: theme.textTheme.bodyMedium?.color,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),

            // زر التأكيد النهائي السفلي
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _acceptedPolicy
                        ? () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('finalize_processing'.tr())),
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accentTeal.withOpacity(_acceptedPolicy ? 1 : 0.5),
                      disabledBackgroundColor: theme.disabledColor.withOpacity(0.15),
                      elevation: _acceptedPolicy ? 2 : 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    child: Text(
                      'finalize_btn_confirm'.tr().toUpperCase(), // مترجم
                      style: TextStyle(
                        fontWeight: FontWeight.w900, 
                        fontSize: 16, 
                        letterSpacing: 0.8,
                        color: _acceptedPolicy ? Colors.white : theme.disabledColor,
                      ),
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
    final theme = Theme.of(context);
    final isSelected = index == selectedIndex;

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
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(26),
          border: Border.all(
            color: isSelected ? const Color(0xFF0FA37A) : Colors.transparent,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(theme.brightness == Brightness.dark ? 0.2 : 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: iconBackground,
              radius: 30,
              child: Icon(icon, color: iconColor, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 15,
                      color: theme.textTheme.bodyLarge?.color,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 11,
                      color: theme.textTheme.bodyMedium?.color?.withOpacity(0.6),
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
    final theme = Theme.of(context);
    return Column(
      children: [
         Icon(leftIcon, color: const Color(0xFF0FA37A), size: 18),
        const SizedBox(height: 6),
        Text(
          text1,
          style: TextStyle(
            fontWeight: FontWeight.w900, 
            fontSize: 11,
            color: theme.textTheme.bodyLarge?.color,
          ),
        ),
        Text(
          text2,
          style: TextStyle(
            fontWeight: FontWeight.w800, 
            fontSize: 11, 
            color: theme.hintColor,
          ),
        ),
      ],
    );
  }
}