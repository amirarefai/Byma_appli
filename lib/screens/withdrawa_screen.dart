import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WithdrawaScreen(),
    );
  }
}

class WithdrawaScreen extends StatefulWidget {
  const WithdrawaScreen({super.key});

  @override
  State<WithdrawaScreen> createState() => _WithdrawaScreenState();
}

class _WithdrawaScreenState extends State<WithdrawaScreen> {
  final TextEditingController _amountController = TextEditingController(text: "0.00");

  @override
  Widget build(BuildContext context) {
    const primaryDarkTeal = Color(0xFF0A5870);    // الأزرق الغامق للترويسة والأزرار
    const currencyBlue = Color(0xFF005B7F);       // لون رمز $
    const textDark = Color(0xFF1E282C);           // لون الرقم والمحتوى الداكن
    const buttonCyanLight = Color(0xFF67CEF5);    // الدرجة الفاتحة بالزر السفلي
    
    // درجات خلفية الشاشة
    const bgGradientStart = Color(0xFFF7FCFE);
    const bgGradientEnd = Color(0xFFEAF4F8);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [bgGradientStart, bgGradientEnd],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // الشريط العلوي (App Bar)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: primaryDarkTeal),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const Text(
                      'Withdrawa',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: primaryDarkTeal,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.help_outline, color: primaryDarkTeal, size: 26),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // النص الوصفي
                const Text(
                  'Enter the amount you wish to withdraw from your wallet. Funds will be transferred to your linked bank account.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF62727D),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 32),

                // بطاقة إدخال المبلغ (Withdrawa Amount Card)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Withdrawa Amount',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4A5A64),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            '\$',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: currencyBlue,
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: _amountController,
                              textAlign: TextAlign.right,
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              style: const TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: textDark,
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // زر تقديم الطلب (Submit Request Button)
                Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: const LinearGradient(
                      colors: [primaryDarkTeal, buttonCyanLight],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: buttonCyanLight.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Submit Request',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward, color: Colors.white),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}