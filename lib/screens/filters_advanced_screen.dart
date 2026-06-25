import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  RangeValues _priceRange = const RangeValues(120, 850);

  int _adults = 2;
  int _children = 0;

 String _roomPrefs = '';

  String? _bedType = 'King';
  String? _floorPref = 'Mid';

  bool _privatePool = true;
  bool _balcony = false;
  bool _breakfastIncluded = false;
  bool _highSpeedWifi = true;

  bool _nearElevator = true;
  bool _stepFreeAccess = true;
  bool _petFriendly = false;

  Widget _switchRow({
    required bool value,
    required ValueChanged<bool> onChanged,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.blue.shade50,
            child: Icon(icon, size: 18, color: Colors.blue.shade700),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 11.5,
                    color: Colors.grey.shade600,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF0FA37A),
          ),
        ],
      ),
    );
  }

  Widget _toggleRow({
    required bool value,
    required ValueChanged<bool> onChanged,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: const Color(0xFF0FA37A)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 14),
                ),
                if (subtitle.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 11.5,
                      color: Colors.grey.shade600,
                      height: 1.2,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF0FA37A),
          ),
        ],
      ),
    );
  }

  Widget _circlePref({
    required bool selected,
    required String label,
    required IconData icon,
    Color selectedColor = const Color(0xFF7FE6D2),
    Color unselectedBg = const Color(0xFFECEFF2),
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: 74,
        height: 74,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: selected ? selectedColor : unselectedBg,
          borderRadius: BorderRadius.circular(999),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: selected ? 0.08 : 0.04),
              blurRadius: selected ? 14 : 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: selected ? Colors.white : const Color(0xFF2B2F33)),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: selected ? Colors.white : const Color(0xFF2B2F33),
                fontWeight: FontWeight.w900,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _pillPref({
    required bool selected,
    required String label,
    required VoidCallback onTap,
    Color selectedBg = const Color(0xFF7FE6D2),
    Color unselectedBg = const Color(0xFFECEFF2),
    Color? selectedTextColor,
    Color? unselectedTextColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 13),
        decoration: BoxDecoration(
          color: selected ? selectedBg : unselectedBg,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? (selectedTextColor ?? Colors.white) : (unselectedTextColor ?? const Color(0xFF2B2F33)),
            fontWeight: FontWeight.w900,
            fontSize: 13,
          ),
        ),
      ),
    );
  }


  Widget _guestCard({
    required String title,
    required int value,
    required VoidCallback onMinus,
    required VoidCallback onPlus,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'STAY WITH US',
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w800,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            onPressed: onMinus,
            icon: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.remove, color: Colors.black54),
            ),
          ),
          const SizedBox(width: 6),
          Text(
            '$value',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
          ),
          const SizedBox(width: 6),
          IconButton(
            onPressed: onPlus,
            icon: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF1FB0A0),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  String _formatPrice(double v) => '\$${v.round()}';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF6FAFA),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(110),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF4F8F8),
                        borderRadius: BorderRadius.all(Radius.circular(18)),
                      ),
                      child: const Icon(Icons.arrow_back_ios_new, size: 18, color: Color(0xFF263238)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          'Advanced Filters',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF263238),
                            letterSpacing: -0.2,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Refine your perfect stay',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF90A4AE),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _priceRange = const RangeValues(120, 850);
                        _adults = 2;
                        _children = 0;
                        _roomPrefs = 'Sea';
                        _privatePool = true;
                        _balcony = false;
                        _breakfastIncluded = false;
                        _highSpeedWifi = true;
                        _nearElevator = true;
                        _stepFreeAccess = true;
                        _petFriendly = false;
                      });
                    },
                    child: const Text(
                      'Reset',
                      style: TextStyle(
                        color: Color(0xFF0FA37A),
                        fontWeight: FontWeight.w800,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
          children: [
            const SizedBox(height: 6),

            // Price Range
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFE5EEEC), width: 1.2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Price Range',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color(0xFF263238)),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'MINIMUM',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w900,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _formatPrice(_priceRange.start),
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                              color: Color(0xFF0FA37A),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'MAXIMUM',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w900,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _formatPrice(_priceRange.end),
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                              color: Color(0xFF0FA37A),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  RangeSlider(
                    values: _priceRange,
                    min: 0,
                    max: 1000,
                    divisions: 20,
                    labels: RangeLabels(
                      _formatPrice(_priceRange.start),
                      _formatPrice(_priceRange.end),
                    ),
                    onChanged: (values) {
                      setState(() {
                        _priceRange = values;
                      });
                    },
                    activeColor: const Color(0xFF0FA37A),
                    inactiveColor: Colors.grey.shade300,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Guest selection
            const Text(
              'Guest selection',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 10),

            _guestCard(
              title: 'Adults',
              value: _adults,
              onMinus: () {
                setState(() {
                  _adults = (_adults - 1).clamp(0, 99);
                });
              },
              onPlus: () {
                setState(() {
                  _adults = (_adults + 1).clamp(0, 99);
                });
              },
            ),
            const SizedBox(height: 12),
            _guestCard(
              title: 'Children',
              value: _children,
              onMinus: () {
                setState(() {
                  _children = (_children - 1).clamp(0, 99);
                });
              },
              onPlus: () {
                setState(() {
                  _children = (_children + 1).clamp(0, 99);
                });
              },
            ),

            const SizedBox(height: 24),

            // Room Preferences
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFE5EEEC), width: 1.2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Room Preferences',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF263238),
                    ),
                  ),
                  const SizedBox(height: 12),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'VIEW TYPE',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  const SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _circlePref(
                        selected: _roomPrefs == 'Sea',
                        label: 'Sea',
                        icon: Icons.waves,
                        selectedColor: const Color(0xFF7FE6D2),
                        onTap: () => setState(() {
                          _roomPrefs = _roomPrefs == 'Sea' ? '' : 'Sea';
                        }),
                      ),
                      _circlePref(
                        selected: _roomPrefs == 'Garden',
                        label: 'Garden',
                        icon: Icons.eco_outlined,
                        selectedColor: const Color(0xFF7FE6D2),
                        onTap: () => setState(() {
                          _roomPrefs = _roomPrefs == 'Garden' ? '' : 'Garden';
                        }),
                      ),
                      _circlePref(
                        selected: _roomPrefs == 'City',
                        label: 'City',
                        icon: Icons.location_city_outlined,
                        selectedColor: const Color(0xFF7FE6D2),
                        onTap: () => setState(() {
                          _roomPrefs = _roomPrefs == 'City' ? '' : 'City';
                        }),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'BED TYPE',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  const SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _circlePref(
                        selected: _bedType == 'King',
                        label: 'King',
                        icon: Icons.hotel, // placeholder icon
                        selectedColor: const Color(0xFF7FE6D2),
                        onTap: () => setState(() => _bedType = 'King'),
                      ),
                      _circlePref(
                        selected: _bedType == 'Twin',
                        label: 'Twin',
                        icon: Icons.king_bed_outlined,
                        selectedColor: const Color(0xFF7FE6D2),
                        onTap: () => setState(() => _bedType = 'Twin'),
                      ),
                      _circlePref(
                        selected: _bedType == 'Queen',
                        label: 'Queen',
                        icon: Icons.bedroom_parent_outlined,
                        selectedColor: const Color(0xFF7FE6D2),
                        onTap: () => setState(() => _bedType = 'Queen'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'FLOOR PREFERENCE',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  const SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _circlePref(
                        selected: _floorPref == 'Ground',
                        label: 'Ground',
                        icon: Icons.terrain,
                        selectedColor: const Color(0xFF7FE6D2),
                        onTap: () => setState(() => _floorPref = 'Ground'),
                      ),
                      _circlePref(
                        selected: _floorPref == 'Mid',
                        label: 'Mid',
                        icon: Icons.height, // placeholder icon
                        selectedColor: const Color(0xFF7FE6D2),
                        onTap: () => setState(() => _floorPref = 'Mid'),
                      ),
                      _circlePref(
                        selected: _floorPref == 'High',
                        label: 'High',
                        icon: Icons.stairs_outlined,
                        selectedColor: const Color(0xFF7FE6D2),
                        onTap: () => setState(() => _floorPref = 'High'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),

            // Luxury Amenities
            const Text(
              'Luxury Amenities',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 10),

            _switchRow(
              value: _privatePool,
              onChanged: (v) => setState(() => _privatePool = v),
              icon: Icons.pool,
              title: 'Private Pool',
              subtitle: 'Exclusive pool in your suite',
            ),
            const SizedBox(height: 12),
            _switchRow(
              value: _balcony,
              onChanged: (v) => setState(() => _balcony = v),
              icon: Icons.wb_sunny_outlined,
              title: 'Balcony',
              subtitle: 'Private outdoor space',
            ),
            const SizedBox(height: 12),
            _switchRow(
              value: _breakfastIncluded,
              onChanged: (v) => setState(() => _breakfastIncluded = v),
              icon: Icons.free_breakfast,
              title: 'Breakfast Included',
              subtitle: 'Start your day right!',
            ),
            const SizedBox(height: 12),
            _switchRow(
              value: _highSpeedWifi,
              onChanged: (v) => setState(() => _highSpeedWifi = v),
              icon: Icons.wifi,
              title: 'High-Speed WiFi',
              subtitle: 'Stay connected everywhere',
            ),

            const SizedBox(height: 24),

            // Accessibility & Others
            const Text(
              'Accessibility & Others',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 10),

            _toggleRow(
              value: _nearElevator,
              onChanged: (v) => setState(() => _nearElevator = v),
              icon: Icons.elevator,
              title: 'Near Elevator',
              subtitle: '',
            ),
            _toggleRow(
              value: _stepFreeAccess,
              onChanged: (v) => setState(() => _stepFreeAccess = v),
              icon: Icons.accessibility_new,
              title: 'Step-free Access',
              subtitle: '',
            ),
            _toggleRow(
              value: _petFriendly,
              onChanged: (v) => setState(() => _petFriendly = v),
              icon: Icons.pets,
              title: 'Pet Friendly',
              subtitle: 'Bringing a furry friend along?',
            ),

            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFEEF9F6),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.teal.shade50),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: Color(0xFF0FA37A)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Looking for something specific?\nYou can request additional services directly from the hotel after booking.',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey.shade700,
                        height: 1.25,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _applyButton(),
    );
  }



  Widget _applyButton() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 18,
            color: Colors.black.withOpacity(0.06),
          )
        ],
      ),
      child: SizedBox(
        height: 52,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            // Close and go back to previous screen
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0FA37A),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            elevation: 0,
          ),
          child: const Text(
            'APPLY FILTERS',
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 13.5, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

