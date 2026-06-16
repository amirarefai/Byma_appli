import 'package:flutter/material.dart';
import 'room_details_screen.dart';

class ReserveYourStayScreen extends StatefulWidget {
  const ReserveYourStayScreen({super.key});

  @override
  State<ReserveYourStayScreen> createState() => _ReserveYourStayScreenState();
}

class _ReserveYourStayScreenState extends State<ReserveYourStayScreen> {
  int _adults = 2;
  int _children = 0;
  int _infants = 0;

  bool _pets = false;
  bool _nearElevator = true;
  bool _quietZone = false;

  String _preferredFloor = 'low';

  final List<String> _floorOptions = ['low', 'high', 'any'];

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFFF3F7F8);
    const teal = Color(0xFF0F8B78);
    const teal2 = Color(0xFF0FA37A);
    const cardBorder = Color(0xFFE0E8E9);
    const textMuted = Color(0xFF7A8A8F);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Reserve Your Stay',
          style: TextStyle(fontWeight: FontWeight.w900, color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 16, 18, 24),
          children: [
            const SizedBox(height: 2),

            // Booking process label
            const Text(
              'BOOKING PROCESS',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 10),

            // Title
            const Text(
              'Preference &\nBooking',
              style: TextStyle(
                fontSize: 32,
                height: 1.05,
                fontWeight: FontWeight.w900,
                color: Color(0xFF0E6F63),
              ),
            ),

            const SizedBox(height: 16),

            _GuestsCard(
              adults: _adults,
              children: _children,
              infants: _infants,
              onAdultsChanged: (v) => setState(() => _adults = v),
              onChildrenChanged: (v) => setState(() => _children = v),
              onInfantsChanged: (v) => setState(() => _infants = v),
            ),

            const SizedBox(height: 12),

            _ToggleCard(
              icon: Icons.pets_outlined,
              title: 'Traveling with Pets?',
              subtitle: 'Pet-friendly floors',
              value: _pets,
              color: teal2,
              onChanged: (v) => setState(() => _pets = v),
            ),
            const SizedBox(height: 10),
            _ToggleCard(
              icon: Icons.accessible_outlined,
              title: 'Near Elevator?',
              subtitle: 'Easy accessibility',
              value: _nearElevator,
              color: teal,
              onChanged: (v) => setState(() => _nearElevator = v),
            ),
            const SizedBox(height: 10),
            _ToggleCard(
              icon: Icons.speaker_notes_outlined,
              title: 'Quiet Zone?',
              subtitle: 'Away from facilities',
              value: _quietZone,
              color: teal2,
              onChanged: (v) => setState(() => _quietZone = v),
            ),

            const SizedBox(height: 14),

            // Preferred floor
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: cardBorder),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'PREFERRED FLOOR',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 12,
                      letterSpacing: 0.6,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Column(
                    children: [
                      _FloorOption(
                        label: 'Low Floor',
                        selected: _preferredFloor == 'low',
                        onTap: () => setState(() => _preferredFloor = 'low'),
                        activeColor: teal2,
                      ),
                      const SizedBox(height: 10),
                      _FloorOption(
                        label: 'High Floor',
                        selected: _preferredFloor == 'high',
                        onTap: () => setState(() => _preferredFloor = 'high'),
                        activeColor: teal,
                      ),
                      const SizedBox(height: 10),
                      _FloorOption(
                        label: 'Any Floor',
                        selected: _preferredFloor == 'any',
                        onTap: () => setState(() => _preferredFloor = 'any'),
                        activeColor: teal2,
                      ),
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Available windows row
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Available Windows',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      color: Color(0xFF0E6F63),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'View Calendar',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 12.5,
                      color: Color(0xFF0E6F63),
                    ),
                  ),
                )
              ],
            ),

            const SizedBox(height: 10),

            // Two date windows (static UI)
            Row(
              children: [
                Expanded(
                  child: _DateWindow(
                    month: 'AUG',
                    day: '12',
                    selected: false,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: _DateWindow(
                    month: 'AUG',
                    day: '15',
                    selected: true,
                  ),
                )
              ],
            ),

            const SizedBox(height: 10),

            // Total stay price bubble
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: cardBorder),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: const [
                  Icon(Icons.attach_money_outlined, color: teal),
                  SizedBox(width: 10),
                  Text(
                    '\$1,450',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF0E6F63),
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'TOTAL STAY',
                    style: TextStyle(fontWeight: FontWeight.w800, color: Colors.black54),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // Perfect match header
            const Text(
              'Your Perfect Match',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 20,
                color: Color(0xFF0E6F63),
              ),
            ),
            const SizedBox(height: 12),

            // Recommended card
            _PerfectMatchCard(
              title: 'Family Executive\nSuite',
              subtitle: 'Optimized for your selections with elevator access and child-proof amenities.',
            ),
          ],
        ),
      ),
    );
  }
}

class _GuestsCard extends StatelessWidget {
  final int adults;
  final int children;
  final int infants;
  final ValueChanged<int> onAdultsChanged;
  final ValueChanged<int> onChildrenChanged;
  final ValueChanged<int> onInfantsChanged;

  const _GuestsCard({
    required this.adults,
    required this.children,
    required this.infants,
    required this.onAdultsChanged,
    required this.onChildrenChanged,
    required this.onInfantsChanged,
  });

  @override
  Widget build(BuildContext context) {
    const teal = Color(0xFF0FA37A);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.98),
        border: Border.all(color: const Color(0xFFE0E8E9)),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const Row(
            children: [
              Icon(Icons.people_outline, color: Color(0xFF0E6F63)),
              SizedBox(width: 10),
              Text(
                'GUESTS & FAMILIES',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                  color: Color(0xFF0E6F63),
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _CounterRow(
            label: 'Adults',
            value: adults,
            onChanged: onAdultsChanged,
          ),
          const SizedBox(height: 12),
          _CounterRow(
            label: 'Children',
            value: children,
            hint: '(Ages 3–16)',
            onChanged: onChildrenChanged,
          ),
          const SizedBox(height: 12),
          _CounterRow(
            label: 'Infants',
            value: infants,
            hint: '(Under 3)',
            onChanged: onInfantsChanged,
          ),
        ],
      ),
    );
  }
}

class _CounterRow extends StatelessWidget {
  final String label;
  final int value;
  final String? hint;
  final ValueChanged<int> onChanged;

  const _CounterRow({
    required this.label,
    required this.value,
    this.hint,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const teal = Color(0xFF0FA37A);

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.w900, color: Colors.black, fontSize: 13.5),
              ),
              if (hint != null)
                Text(
                  hint!,
                  style: const TextStyle(color: Colors.black54, fontSize: 11.5),
                ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        _PlusMinus(
          value: value,
          onIncrement: () => onChanged(value + 1),
          onDecrement: () {
            if (value <= 0) return;
            onChanged(value - 1);
          },
          activeColor: teal,
        ),
      ],
    );
  }
}

class _PlusMinus extends StatelessWidget {
  final int value;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final Color activeColor;

  const _PlusMinus({
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
    required this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    final bool isZero = value == 0;

    return Row(
      children: [
        CircleAvatar(
          backgroundColor: isZero ? const Color(0xFFE9EEF0) : Colors.white,
          radius: 22,
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: onDecrement,
            icon: Icon(Icons.remove, color: isZero ? const Color(0xFF99A8AE) : activeColor, size: 18),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          value.toString().padLeft(2, '0'),
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: Colors.black54),
        ),
        const SizedBox(width: 10),
        CircleAvatar(
          backgroundColor: activeColor,
          radius: 22,
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: onIncrement,
            icon: const Icon(Icons.add, color: Colors.white, size: 18),
          ),
        ),
      ],
    );
  }
}

class _ToggleCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final Color color;
  final ValueChanged<bool> onChanged;

  const _ToggleCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.color,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.98),
        border: Border.all(color: const Color(0xFFE0E8E9)),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.12),
            radius: 20,
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 13.5)),
                const SizedBox(height: 2),
                Text(subtitle, style: const TextStyle(color: Colors.black54, fontSize: 11.5)),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: color,
          ),
        ],
      ),
    );
  }
}

class _FloorOption extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color activeColor;

  const _FloorOption({
    required this.label,
    required this.selected,
    required this.onTap,
    required this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        width: double.infinity,
        decoration: BoxDecoration(
          color: selected ? activeColor : Colors.white,
          borderRadius: BorderRadius.circular(999),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: activeColor.withOpacity(0.25),
                    blurRadius: 10,
                    offset: const Offset(0, 6),
                  )
                ]
              : null,
          border: Border.all(
            color: selected ? Colors.transparent : const Color(0xFFE0E8E9),
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: selected ? Colors.white : const Color(0xFF0E6F63),
              fontSize: 13.5,
            ),
          ),
        ),
      ),
    );
  }
}

class _DateWindow extends StatelessWidget {
  final String month;
  final String day;
  final bool selected;

  const _DateWindow({
    required this.month,
    required this.day,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    const teal = Color(0xFF0E6F63);

    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: selected ? teal : const Color(0xFFE0E8E9),
          width: selected ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            month,
            style: TextStyle(
              color: selected ? teal : Colors.black54,
              fontWeight: FontWeight.w900,
              fontSize: 12,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            day,
            style: TextStyle(
              color: selected ? teal : Colors.black87,
              fontWeight: FontWeight.w900,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class _PerfectMatchCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const _PerfectMatchCard({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    const teal = Color(0xFF0E6F63);

    return Container(
      height: 240,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: const Color(0xFFE3EAEB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
        gradient: const LinearGradient(
          colors: [Color(0xFF0A4F47), Color(0xFF0E6F63)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          // image placeholder
          ClipRRect(
            borderRadius: BorderRadius.circular(26),
            child: Container(
              color: Colors.black.withOpacity(0.12),
              child: const Center(
                child: Icon(Icons.hotel, color: Colors.white54, size: 80),
              ),
            ),
          ),
          Positioned(
            left: 16,
            top: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.18),
                borderRadius: BorderRadius.circular(999),
              ),
              child: const Text(
                'RECOMMENDED FOR YOU',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 10.5,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ),
          Positioned(
            right: 14,
            top: 14,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(999),
              ),
              child: const Text(
                '\$450/night',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                  color: teal,
                ),
              ),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 18,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 22,
                    height: 1.05,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.5,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 12),
                InkWell(
                  borderRadius: BorderRadius.circular(999),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RoomDetailsScreen(
                          roomTitle: title.replaceAll('\n', ' '),
                          pricePerNight: '450',
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.14),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: const Text(
                      'CLICK TO VIEW & BOOK ROOM  →',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 12,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
