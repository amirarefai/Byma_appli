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
      home: WithdrawaHistoryScreen(),
    );
  }
}

// نموذج بيانات لعملية السحب
class WithdrawaItem {
  final String amount;
  final String status; // 'PENDING', 'ACCEPTED', 'REJECTED'
  final String date;

  WithdrawaItem({
    required this.amount,
    required this.status,
    required this.date,
  });
}

class WithdrawaHistoryScreen extends StatefulWidget {
  const WithdrawaHistoryScreen({super.key});

  @override
  State<WithdrawaHistoryScreen> createState() => _WithdrawaHistoryScreenState();
}

class _WithdrawaHistoryScreenState extends State<WithdrawaHistoryScreen> {
  // قائمة البيانات التجريبية
  final List<WithdrawaItem> withdrawas = [
    WithdrawaItem(
      amount: '\$500.00',
      status: 'PENDING',
      date: 'Oct 24, 2023 - 10:30 AM',
    ),
    WithdrawaItem(
      amount: '\$1,250.00',
      status: 'ACCEPTED',
      date: 'Oct 21, 2023 - 02:15 PM',
    ),
    WithdrawaItem(
      amount: '\$75.50',
      status: 'REJECTED',
      date: 'Oct 19, 2023 - 09:45 AM',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    const primaryDarkTeal = Color(0xFF0F5B78);
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
          child: Column(
            children: [
              // الشريط العلوي (App Bar)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, color: primaryDarkTeal, size: 24),
                          onPressed: () {
                            if (Navigator.canPop(context)) {
                              Navigator.of(context).pop();
                            }
                          },
                        ),
                        const Expanded(
                          child: Text(
                            'Withdrawa History',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: primaryDarkTeal,
                            ),
                          ),
                        ),
                        const SizedBox(width: 48),
                      ],
                    ),
                  ),
                  const Divider(color: Color(0xFFE5EAEF), height: 1, thickness: 1),
                ],
              ),

              // قائمة بطاقات السحب
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  itemCount: withdrawas.length,
                  itemBuilder: (context, index) {
                    final item = withdrawas[index];
                    return _buildWithdrawaCard(item);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ودجت بناء كل بطاقة سحب
  Widget _buildWithdrawaCard(WithdrawaItem item) {
    Color statusBgColor;
    Color statusTextColor;
    IconData statusIcon;

    switch (item.status) {
      case 'PENDING':
        statusBgColor = const Color(0xFFFDF0E2);
        statusTextColor = const Color(0xFFC87023);
        statusIcon = Icons.access_time_rounded;
        break;
      case 'ACCEPTED':
        statusBgColor = const Color(0xFFE2F7ED);
        statusTextColor = const Color(0xFF279663);
        statusIcon = Icons.check_circle_outline_rounded;
        break;
      case 'REJECTED':
      default:
        statusBgColor = const Color(0xFFFDE8E8);
        statusTextColor = const Color(0xFFC53939);
        statusIcon = Icons.cancel_outlined;
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'AMOUNT',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6C757D),
                  letterSpacing: 0.8,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: statusBgColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  item.status,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: statusTextColor,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          Text(
            item.amount,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          const Divider(color: Color(0xFFF0F3F5), height: 1, thickness: 1),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    statusIcon,
                    size: 16,
                    color: const Color(0xFF6C757D),
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    'Created At',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF6C757D),
                    ),
                  ),
                ],
              ),
              Text(
                item.date,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}