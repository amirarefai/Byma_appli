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
      home: ReservationsScreen(),
    );
  }
}

// نموذج بيانات الحجز
class ReservationItem {
  final String hotelName;
  final String roomNumber;
  final String price;
  final String date;
  final String status; // 'Booking', 'Update', 'Cancel'

  ReservationItem({
    required this.hotelName,
    required this.roomNumber,
    required this.price,
    required this.date,
    required this.status,
  });
}

class ReservationsScreen extends StatefulWidget {
  const ReservationsScreen({super.key});

  @override
  State<ReservationsScreen> createState() => _ReservationsScreenState();
}

class _ReservationsScreenState extends State<ReservationsScreen> {
  // القائمة المطابقة للصورة
  final List<ReservationItem> reservations = [
    ReservationItem(
      hotelName: 'Grand Palace Hotel',
      roomNumber: 'Room 302',
      price: '450.00',
      date: 'Oct 25, 2023 - 11:00 AM',
      status: 'Booking',
    ),
    ReservationItem(
      hotelName: 'Seaside Resort & Spa',
      roomNumber: 'Room 114',
      price: '820.00',
      date: 'Oct 22, 2023 - 09:15 AM',
      status: 'Update',
    ),
    ReservationItem(
      hotelName: 'Mountain View Lodge',
      roomNumber: 'Room 45',
      price: '120.00',
      date: 'Oct 18, 2023 - 04:30 PM',
      status: 'Cancel',
    ),
    ReservationItem(
      hotelName: 'City Center Inn',
      roomNumber: 'Room 901',
      price: '285.50',
      date: 'Oct 10, 2023 - 02:45 PM',
      status: 'Booking',
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
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.menu, color: primaryDarkTeal, size: 26),
                          onPressed: () {},
                        ),
                        const Expanded(
                          child: Text(
                            'Reservations',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: primaryDarkTeal,
                            ),
                          ),
                        ),
                        const SizedBox(width: 48), // لموازنة الأيقونة الجانبية
                      ],
                    ),
                  ),
                  const Divider(color: Color(0xFFE5EAEF), height: 1, thickness: 1),
                ],
              ),

              // قائمة بطاقات الحجوزات
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  itemCount: reservations.length,
                  itemBuilder: (context, index) {
                    final item = reservations[index];
                    return _buildReservationCard(item);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ودجت بناء كل بطاقة حجز
  Widget _buildReservationCard(ReservationItem item) {
    // تحديد لون الوسم (Badge) حسب الحالة
    Color statusBgColor;
    Color statusTextColor;

    switch (item.status) {
      case 'Booking':
        statusBgColor = const Color(0xFFBCEEE1);
        statusTextColor = const Color(0xFF0F7263);
        break;
      case 'Update':
        statusBgColor = const Color(0xFFFDECDA);
        statusTextColor = const Color(0xFFC86E1B);
        break;
      case 'Cancel':
      default:
        statusBgColor = const Color(0xFFFCD8DA);
        statusTextColor = const Color(0xFFD33947);
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
          // السطر الأول: اسم الفندق والوسم
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  item.hotelName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E282C),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
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
          const SizedBox(height: 6),

          // السطر الثاني: أيقونة الباب ورقم الغرفة
          Row(
            children: [
              const Icon(
                Icons.meeting_room_outlined,
                size: 18,
                color: Color(0xFF62727D),
              ),
              const SizedBox(width: 6),
              Text(
                item.roomNumber,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF62727D),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // السطر الثالث: السعر والتاريخ
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // السعر مع رمز الدولار
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  const Text(
                    '\$ ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F5B78),
                    ),
                  ),
                  Text(
                    item.price,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F5B78),
                    ),
                  ),
                ],
              ),

              // أيقونة الساعة والتاريخ
              Row(
                children: [
                  const Icon(
                    Icons.access_time,
                    size: 15,
                    color: Color(0xFF7D8C97),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    item.date,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF7D8C97),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}