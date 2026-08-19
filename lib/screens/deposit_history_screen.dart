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
      home: DepositHistoryScreen(),
    );
  }
}

// نموذج بيانات لعملية الإيداع
class DepositItem {
  final String txnId;
  final String amount;
  final String status; // 'Pending', 'Accepted', 'Rejected'
  final String date;
  final String? imageUrl; // يمكن تمرير رابط الصورة هنا

  DepositItem({
    required this.txnId,
    required this.amount,
    required this.status,
    required this.date,
    this.imageUrl,
  });
}

class DepositHistoryScreen extends StatefulWidget {
  const DepositHistoryScreen({super.key});

  @override
  State<DepositHistoryScreen> createState() => _DepositHistoryScreenState();
}

class _DepositHistoryScreenState extends State<DepositHistoryScreen> {
  // قائمة البيانات التجريبية المطابقة للصورة
  final List<DepositItem> deposits = [
    DepositItem(
      txnId: 'TXN-12345',
      amount: '500.00',
      status: 'Pending',
      date: 'Oct 24, 2023 - 10:30 AM',
    ),
    DepositItem(
      txnId: 'TXN-87654',
      amount: '1,250.00',
      status: 'Accepted',
      date: 'Oct 23, 2023 - 02:15 PM',
    ),
    DepositItem(
      txnId: 'TXN-99887',
      amount: '300.00',
      status: 'Rejected',
      date: 'Oct 21, 2023 - 09:00 AM',
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
                            'Deposit History',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: primaryDarkTeal,
                            ),
                          ),
                        ),
                        const SizedBox(width: 48), // لموازنة زر الرجوع
                      ],
                    ),
                  ),
                  const Divider(color: Color(0xFFE5EAEF), height: 1, thickness: 1),
                ],
              ),

              // قائمة بطاقات الإيداع
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  itemCount: deposits.length,
                  itemBuilder: (context, index) {
                    final item = deposits[index];
                    return _buildDepositCard(item);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ودجت بناء كل بطاقة إيداع
  Widget _buildDepositCard(DepositItem item) {
    // تخصيص الألوان حسب الحالة
    Color statusBgColor;
    Color statusTextColor;

    switch (item.status) {
      case 'Pending':
        statusBgColor = const Color(0xFFFEF3D6);
        statusTextColor = const Color(0xFFD9822B);
        break;
      case 'Accepted':
        statusBgColor = const Color(0xFFE2F7ED);
        statusTextColor = const Color(0xFF279663);
        break;
      case 'Rejected':
      default:
        statusBgColor = const Color(0xFFFDE8E8);
        statusTextColor = const Color(0xFFE54D4D);
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // القسم العلوي من البطاقة
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // الدائرة الرمادية للصورة
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: const Color(0xFFE0E0E0),
                  shape: BoxShape.circle,
                  image: item.imageUrl != null
                      ? DecorationImage(
                          image: NetworkImage(item.imageUrl!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
              ),
              const SizedBox(width: 14),

              // رقم العملية والشارة (Pending/Accepted/Rejected)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.txnId,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                      decoration: BoxDecoration(
                        color: statusBgColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        item.status,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: statusTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // جهة اليمين: AMOUNT مع القيمة
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'AMOUNT',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8C98A4),
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        item.amount,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F5B78),
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        '\$',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),
          const Divider(color: Color(0xFFF0F3F5), height: 1, thickness: 1),
          const SizedBox(height: 14),

          // السطر السفلي: CREATED AT والتاريخ
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'CREATED AT',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8C98A4),
                  letterSpacing: 0.5,
                ),
              ),
              Text(
                item.date,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF52606D),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}