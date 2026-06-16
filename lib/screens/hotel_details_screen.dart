import 'package:flutter/material.dart';

import 'reserve_your_stay_screen.dart';

class HotelDetailsScreen extends StatelessWidget {
  final String title;
  final String imageUrl;

  const HotelDetailsScreen({
    super.key,
    required this.title,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    const teal = Color(0xFF0F8B78);
    const teal2 = Color(0xFF0FA37A);
    const lightCard = Color(0xFFEEF9F6);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 6),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87, size: 20),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: const Text(
          'Hotel Details',
          style: TextStyle(fontWeight: FontWeight.w900, color: Colors.black87, fontSize: 16.5),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite_border_rounded, size: 22, color: teal2),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
              children: [
                _HeroImage(teal2: teal2, imageUrl: imageUrl),
                const SizedBox(height: 12),
                _RatingsRow(teal2: teal2),
                const SizedBox(height: 10),
                _PriceRow(teal2: teal2),
                const SizedBox(height: 14),

                _UnderlineTitle(title: 'Premium Amenities', color: teal2),
                const SizedBox(height: 10),
                _AmenitiesGrid(
                  teal: teal,
                  items: const [
                    _Amen(icon: Icons.waves_outlined, label: 'INFINITY POOL'),
                    _Amen(icon: Icons.wifi, label: 'ULTRA FAST\nWIFI'),
                    _Amen(icon: Icons.restaurant_outlined, label: 'PRIVATE CHEF'),
                    _Amen(icon: Icons.ac_unit_outlined, label: 'CLIMATE\nCONTROL'),
                  ],
                ),
                const SizedBox(height: 20),

                _DescriptionCard(
                  teal: teal,
                  title: 'Description',
                  text:
                      'Experience unparalleled luxury in this cliffside architectural masterpiece. Azure Horizon offers panoramic views of the Aegean Sea, featuring a signature private infinity pool, minimalist interior design, and state-of-the-art smart home integration.',
                ),
                const SizedBox(height: 20),

                _UnderlineTitle(title: 'Location', color: teal2),
                const SizedBox(height: 10),
                _LocationCard(teal2: teal2),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: teal2,
                      side: BorderSide(color: teal2.withOpacity(0.25)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.open_in_new_rounded, size: 18),
                        SizedBox(width: 10),
                        Text(
                          'OPEN IN MAPS',
                          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12, letterSpacing: 0.6),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 22),

                _UnderlineTitle(title: 'Policy Highlights', color: teal2),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: lightCard,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: teal2.withOpacity(0.28), width: 1.4),
                  ),
                  child: _PolicyList(
                    teal2: teal2,
                    items: const [
                      _Policy(icon: Icons.check_circle_outline, title: 'FREE CANCELLATION', subtitle: 'Full refund if canceled before June 15, 2024.'),
                      _Policy(icon: Icons.swap_horiz_outlined, title: 'CHECK-IN & OUT', subtitle: 'In: 3:00 PM   Out: 11:00 AM'),
                      _Policy(icon: Icons.no_meeting_room_outlined, title: 'HOUSE RULES', subtitle: 'No smoking   Pets   No parties'),
                    ],
                  ),
                ),
                const SizedBox(height: 18),

                _UnderlineTitle(title: 'Guest Reviews', color: teal2),
                const SizedBox(height: 10),
                _ReviewsHeader(teal2: teal2),
                const SizedBox(height: 12),
                _ReviewsRow(teal: teal, teal2: teal2),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                    child: const Text(
                      'VIEW ALL 128 REVIEWS',
                      style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12, color: Colors.black54),
                    ),
                  ),
                ),
                const SizedBox(height: 90),
              ],
            ),

            // Bottom sticky BOOK NOW
           // Bottom sticky BOOK NOW
         // Bottom floating capsule (Chat & BOOK NOW)
            Align(
              alignment: Alignment.bottomCenter,
              child: SafeArea(
                child: Padding(
                  // إعطاء مسافة (Margin) من الحواف الجانبية والسفلية لتظهر عائمة تماماً كالصورة
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4F9F8), // لون الخلفية الفاتح المائل للأبيض للكبسولة الخارجية
                      borderRadius: BorderRadius.circular(40), // حواف دائرية كبيرة للإطار الخارجي
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 16,
                          offset: const Offset(0, 6), // ظل ناعم للأسفل يعطي إيحاء العمق
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min, // تجعل الحاوية تلتف حول العناصر بالتساوي
                      children: [
                        // زر الشات الدائري الأخضر الغامق
                        Container(
                          width: 54,
                          height: 54,
                          decoration: const BoxDecoration(
                            color: Color(0xFF006653), // نفس درجة الأخضر الغامق بالصورة
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () {
                              // حدث فتح الشات هنا
                            },
                            icon: const Icon(
                              Icons.chat_bubble_outline_rounded,
                              color: Colors.white,
                              size: 21,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        // زر الـ BOOK NOW الأزرق السماوي
                        Expanded(
                          child: SizedBox(
                            height: 54,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => const ReserveYourStayScreen()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF63D3FF), // الأزرق السماوي المطابق للصورة
                                foregroundColor: const Color(0xFF231F20), // لون النص الداكن
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text(
                                'BOOK NOW',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // ==================================================================
          ],
        ),
      ),
    );
  }
}

class _HeroImage extends StatelessWidget {
  final String imageUrl;
  final Color teal2;

  const _HeroImage({required this.imageUrl, required this.teal2});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(26),
      child: Container(
        height: 235,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFD9E2E8), width: 0.8),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
          gradient: const LinearGradient(
            colors: [Color(0xFF0B3E68), Color(0xFF0E7B6F)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 18,
              top: 14,
              child: _PhotoProgressDots(teal2: teal2),
            ),
            Positioned(
              left: 16,
              top: 16,
              child: Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  icon: const Icon(Icons.favorite_border, color: Colors.black54),
                ),
              ),
            ),
            Positioned(
              right: 16,
              bottom: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: Colors.white.withOpacity(0.15)),
                ),
                child: const Text(
                  '1/12 PHOTOS',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ),
            // simple map pin decoration
            Positioned(
              right: 22,
              top: 112,
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: teal2.withOpacity(0.20),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PhotoProgressDots extends StatelessWidget {
  final Color teal2;
  const _PhotoProgressDots({required this.teal2});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.92),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withOpacity(0.9)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.circle, size: 7, color: Color(0xFF0FA37A)),
          SizedBox(width: 4),
          Icon(Icons.circle_outlined, size: 7, color: Color(0xFF0FA37A)),
          SizedBox(width: 4),
          Icon(Icons.circle_outlined, size: 7, color: Color(0xFF0FA37A)),
        ],
      ),
    );
  }
}

class _RatingsRow extends StatelessWidget {
  final Color teal2;
  const _RatingsRow({required this.teal2});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.star, size: 18, color: Color(0xFF0FA37A)),
        const SizedBox(width: 6),
        const Text('4.9', style: TextStyle(fontWeight: FontWeight.w900, color: Colors.black87, fontSize: 15)),
        const SizedBox(width: 12),
        const Icon(Icons.location_on_outlined, size: 18, color: Color(0xFF0FA37A)),
        const SizedBox(width: 6),
        const Expanded(
          child: Text(
            'Santorini,\nGreece',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black54, fontSize: 12.5, height: 1.05),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
          decoration: BoxDecoration(
            color: teal2,
            borderRadius: BorderRadius.circular(999),
          ),
          child: const Row(
            children: [
              Text('500%', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 12)),
              SizedBox(width: 8),
              Icon(Icons.bolt_rounded, size: 16, color: Colors.white),
            ],
          ),
        ),
      ],
    );
  }
}

class _PriceRow extends StatelessWidget {
  final Color teal2;
  const _PriceRow({required this.teal2});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('\$1,200', style: TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF0FA37A), fontSize: 20)),
                SizedBox(height: 3),
                Text('/ night', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black54, fontSize: 12.5)),
                SizedBox(height: 6),
                Text(
                  'INSTANT BOOKING',
                  style: TextStyle(fontWeight: FontWeight.w800, color: Colors.black38, fontSize: 11.5, letterSpacing: 0.5),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 130,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: teal2,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: const Text(
              'AVAILABLE NOW',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 11.5, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

class _UnderlineTitle extends StatelessWidget {
  final String title;
  final Color color;
  const _UnderlineTitle({required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.remove_circle_outline, color: color, size: 18),
            const SizedBox(width: 10),
            Text(title, style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: Colors.black87)),
          ],
        ),
        const SizedBox(height: 6),
        Container(height: 3, width: 56, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(999))),
      ],
    );
  }
}

class _AmenitiesGrid extends StatelessWidget {
  final Color teal;
  final List<_Amen> items;

  const _AmenitiesGrid({required this.teal, required this.items});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.1,
      ),
      itemBuilder: (context, i) {
        final item = items[i];
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(item.icon, size: 28, color: teal),
              const SizedBox(height: 10),
              Text(
                item.label,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 10.5, color: Colors.black54, letterSpacing: 0.3),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Amen {
  final IconData icon;
  final String label;
  const _Amen({required this.icon, required this.label});
}

class _DescriptionCard extends StatelessWidget {
  final Color teal;
  final String title;
  final String text;

  const _DescriptionCard({required this.teal, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: teal.withOpacity(0.95),
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16.5, color: Colors.black)),
          const SizedBox(height: 10),
          Text(
            text,
            style: const TextStyle(color: Colors.black, fontSize: 12.8, height: 1.5, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class _LocationCard extends StatelessWidget {
  final Color teal2;
  const _LocationCard({required this.teal2});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Column(
                children: [
                  Container(height: 32, color: Colors.grey.shade200),
                  Expanded(
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 1,
                        crossAxisSpacing: 1,
                      ),
                      itemCount: 16,
                      itemBuilder: (_, __) => Container(color: Colors.grey.shade100),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: teal2,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: teal2.withOpacity(0.35), blurRadius: 14, offset: const Offset(0, 8)),
                ],
              ),
              child: const Center(
                child: Icon(Icons.location_on, color: Colors.white, size: 22),
              ),
            ),
          ),
          const Positioned(
            left: 18,
            right: 18,
            bottom: 16,
            child: Center(
              child: Text(
                'OIA, SANTORINI',
                style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w700, fontSize: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PolicyList extends StatelessWidget {
  final Color teal2;
  final List<_Policy> items;

  const _PolicyList({required this.teal2, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items
          .map(
            (p) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.grey.shade100.withOpacity(0.55),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.grey.shade200.withOpacity(0.8)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(p.icon, size: 20, color: teal2),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(p.title, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12.5, color: Colors.black87)),
                        const SizedBox(height: 4),
                        Text(
                          p.subtitle,
                          style: TextStyle(
                            fontSize: 11.5,
                            color: Colors.black54.withOpacity(0.85),
                            height: 1.35,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

class _Policy {
  final IconData icon;
  final String title;
  final String subtitle;

  const _Policy({required this.icon, required this.title, required this.subtitle});
}

class _ReviewsHeader extends StatelessWidget {
  final Color teal2;
  const _ReviewsHeader({required this.teal2});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.04),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Row(
            children: [
              Icon(Icons.star, size: 16, color: teal2),
              const SizedBox(width: 6),
              const Text('4.9', style: TextStyle(fontWeight: FontWeight.w900, color: Colors.black87)),
              const SizedBox(width: 8),
              const Text('(128)', style: TextStyle(fontWeight: FontWeight.w800, color: Colors.black54)),
            ],
          ),
        ),
      ],
    );
  }
}

class _ReviewsRow extends StatelessWidget {
  final Color teal;
  final Color teal2;

  const _ReviewsRow({required this.teal, required this.teal2});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _ReviewCard(
                name: 'Elena M.',
                monthDay: 'MARCH 2024',
                text:
                    '“Absolutely breathtaking views. The infinity pool at sunset is an experience I’ll never forget.”',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _ReviewCard(
                name: 'Jar',
                monthDay: 'FEB',
                text: '“The experience was amazing.”',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final String name;
  final String monthDay;
  final String text;

  const _ReviewCard({
    required this.name,
    required this.monthDay,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F7F8),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      monthDay,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: Colors.teal,
                      ),
                    ),
                  ],
                ),
              ),
              const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star_border, size: 12),
                  Icon(Icons.star_border, size: 12),
                  Icon(Icons.star_border, size: 12),
                  Icon(Icons.star_border, size: 12),
                  Icon(Icons.star_border, size: 12),
                ],
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            text,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13,
              height: 1.5,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}