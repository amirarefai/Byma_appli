import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class FiltersAdvancedScreen extends StatefulWidget {
  const FiltersAdvancedScreen({super.key});

  @override
  State<FiltersAdvancedScreen> createState() => _FiltersAdvancedScreenState();
}

class _FiltersAdvancedScreenState extends State<FiltersAdvancedScreen> {
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

  // دالة مساعدة لجلب الألوان بناءً على حالة السطوع العالي أو الثيم الحالي
  Color _getAdaptiveColor(BuildContext context, {required Color light, required Color dark, required Color highContrast}) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isHighContrast = theme.colorScheme.primary == Colors.black || theme.colorScheme.primary == Colors.white; 

    if (isHighContrast) return highContrast;
    return isDark ? dark : light;
  }

  Widget _switchRow({
    required BuildContext context,
    required bool value,
    required ValueChanged<bool> onChanged,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: _getAdaptiveColor(context, 
          light: Colors.grey.shade100, 
          dark: Colors.grey.shade900, 
          highContrast: Colors.black
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outline.withAlpha(50),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: theme.colorScheme.primary.withAlpha(30),
            child: Icon(icon, size: 18, color: theme.colorScheme.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w800, 
                    fontSize: 14,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 11.5,
                    color: theme.colorScheme.onSurface.withAlpha(150),
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: theme.colorScheme.primary,
          ),
        ],
      ),
    );
  }

  Widget _toggleRow({
    required BuildContext context,
    required bool value,
    required ValueChanged<bool> onChanged,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: _getAdaptiveColor(context, 
          light: Colors.grey.shade100, 
          dark: Colors.grey.shade900, 
          highContrast: Colors.black
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outline.withAlpha(50),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: theme.colorScheme.primary),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w900, 
                    fontSize: 14,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                if (subtitle.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 11.5,
                      color: theme.colorScheme.onSurface.withAlpha(150),
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
            activeColor: theme.colorScheme.primary,
          ),
        ],
      ),
    );
  }

  Widget _circlePref({
    required BuildContext context,
    required bool selected,
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    
    final selectedBg = theme.colorScheme.primary;
    final unselectedBg = _getAdaptiveColor(context, 
      light: const Color(0xFFECEFF2), 
      dark: Colors.grey.shade800, 
      highContrast: Colors.black
    );

    final selectedContentColor = theme.colorScheme.onPrimary;
    final unselectedContentColor = theme.colorScheme.onSurface;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: 74,
        height: 74,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: selected ? selectedBg : unselectedBg,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: selected ? theme.colorScheme.primary : theme.colorScheme.outline.withAlpha(80),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((selected ? 0.08 * 255 : 0.04 * 255).round()),
              blurRadius: selected ? 14 : 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: selected ? selectedContentColor : unselectedContentColor),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: selected ? selectedContentColor : unselectedContentColor,
                fontWeight: FontWeight.w900,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _guestCard({
    required BuildContext context,
    required String title,
    required int value,
    required VoidCallback onMinus,
    required VoidCallback onPlus,
  }) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: _getAdaptiveColor(context, 
          light: Colors.grey.shade100, 
          dark: Colors.grey.shade900, 
          highContrast: Colors.black
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: theme.colorScheme.outline.withAlpha(50),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'STAY_WITH_US'.tr(),
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w800,
                    color: theme.colorScheme.onSurface.withAlpha(120),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: theme.colorScheme.onSurface),
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
                color: theme.colorScheme.outline.withAlpha(40),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.remove, color: theme.colorScheme.onSurface.withAlpha(180)),
            ),
          ),
          const SizedBox(width: 6),
          Text(
            '$value',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: theme.colorScheme.onSurface),
          ),
          const SizedBox(width: 6),
          IconButton(
            onPressed: onPlus,
            icon: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.add, color: theme.colorScheme.onPrimary),
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
      backgroundColor: theme.colorScheme.surface,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(110),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: _getAdaptiveColor(context, light: Colors.white, dark: Colors.grey.shade900, highContrast: Colors.black),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: theme.colorScheme.outline.withAlpha(60), width: 1.2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha((0.06 * 255).round()),
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
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: const BorderRadius.all(Radius.circular(18)),
                        border: Border.all(color: theme.colorScheme.outline.withAlpha(40)),
                      ),
                      child: Icon(Icons.arrow_back_ios_new, size: 18, color: theme.colorScheme.onSurface),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'ADVANCED_FILTERS'.tr(),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: theme.colorScheme.onSurface,
                            letterSpacing: -0.2,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'REFINE_YOUR_PERFECT_STAY'.tr(),
                          style: TextStyle(
                            fontSize: 11,
                            color: theme.colorScheme.onSurface.withAlpha(140),
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
                        _roomPrefs = '';
                        _bedType = 'King';
                        _floorPref = 'Mid';
                        _privatePool = true;
                        _balcony = false;
                        _breakfastIncluded = false;
                        _highSpeedWifi = true;
                        _nearElevator = true;
                        _stepFreeAccess = true;
                        _petFriendly = false;
                      });
                    },
                    child: Text(
                      'RESET'.tr(),
                      style: TextStyle(
                        color: theme.colorScheme.primary,
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
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            const SizedBox(height: 6),

            // Price Range
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _getAdaptiveColor(context, light: Colors.white, dark: Colors.grey.shade900, highContrast: Colors.black),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: theme.colorScheme.outline.withAlpha(60), width: 1.2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha((0.04 * 255).round()),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PRICE_RANGE'.tr(),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: theme.colorScheme.onSurface),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'MINIMUM'.tr(),
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w900,
                              color: theme.colorScheme.onSurface.withAlpha(140),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _formatPrice(_priceRange.start),
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'MAXIMUM'.tr(),
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w900,
                              color: theme.colorScheme.onSurface.withAlpha(140),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _formatPrice(_priceRange.end),
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                              color: theme.colorScheme.primary,
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
                    activeColor: theme.colorScheme.primary,
                    inactiveColor: theme.colorScheme.outline.withAlpha(60),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Guest selection
            Text(
              'GUEST_SELECTION'.tr(),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: theme.colorScheme.onSurface),
            ),
            const SizedBox(height: 10),

            _guestCard(
              context: context,
              title: 'ADULTS'.tr(),
              value: _adults,
              onMinus: () => setState(() => _adults = (_adults - 1).clamp(0, 99)),
              onPlus: () => setState(() => _adults = (_adults + 1).clamp(0, 99)),
            ),
            const SizedBox(height: 12),
            _guestCard(
              context: context,
              title: 'CHILDREN'.tr(),
              value: _children,
              onMinus: () => setState(() => _children = (_children - 1).clamp(0, 99)),
              onPlus: () => setState(() => _children = (_children + 1).clamp(0, 99)),
            ),

            const SizedBox(height: 24),

            // Room Preferences
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _getAdaptiveColor(context, light: Colors.white, dark: Colors.grey.shade900, highContrast: Colors.black),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: theme.colorScheme.outline.withAlpha(60), width: 1.2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha((0.04 * 255).round()),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ROOM_PREFERENCES'.tr(),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: theme.colorScheme.onSurface),
                  ),
                  const SizedBox(height: 12),

                  Align(
                    alignment: AlignmentDirectional.centerStart, // يدعم RTL تلقائياً للعربية
                    child: Text(
                      'VIEW_TYPE'.tr(),
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: theme.colorScheme.onSurface.withAlpha(140)),
                    ),
                  ),
                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _circlePref(
                        context: context,
                        selected: _roomPrefs == 'Sea',
                        label: 'SEA'.tr(),
                        icon: Icons.waves,
                        onTap: () => setState(() => _roomPrefs = _roomPrefs == 'Sea' ? '' : 'Sea'),
                      ),
                      _circlePref(
                        context: context,
                        selected: _roomPrefs == 'Garden',
                        label: 'GARDEN'.tr(),
                        icon: Icons.eco_outlined,
                        onTap: () => setState(() => _roomPrefs = _roomPrefs == 'Garden' ? '' : 'Garden'),
                      ),
                      _circlePref(
                        context: context,
                        selected: _roomPrefs == 'City',
                        label: 'CITY'.tr(),
                        icon: Icons.location_city_outlined,
                        onTap: () => setState(() => _roomPrefs = _roomPrefs == 'City' ? '' : 'City'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      'BED_TYPE'.tr(),
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: theme.colorScheme.onSurface.withAlpha(140)),
                    ),
                  ),
                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _circlePref(
                        context: context,
                        selected: _bedType == 'King',
                        label: 'KING'.tr(),
                        icon: Icons.hotel,
                        onTap: () => setState(() => _bedType = 'King'),
                      ),
                      _circlePref(
                        context: context,
                        selected: _bedType == 'Twin',
                        label: 'TWIN'.tr(),
                        icon: Icons.king_bed_outlined,
                        onTap: () => setState(() => _bedType = 'Twin'),
                      ),
                      _circlePref(
                        context: context,
                        selected: _bedType == 'Queen',
                        label: 'QUEEN'.tr(),
                        icon: Icons.bedroom_parent_outlined,
                        onTap: () => setState(() => _bedType = 'Queen'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      'FLOOR_PREFERENCE'.tr(),
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: theme.colorScheme.onSurface.withAlpha(140)),
                    ),
                  ),
                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _circlePref(
                        context: context,
                        selected: _floorPref == 'Ground',
                        label: 'GROUND'.tr(),
                        icon: Icons.terrain,
                        onTap: () => setState(() => _floorPref = 'Ground'),
                      ),
                      _circlePref(
                        context: context,
                        selected: _floorPref == 'Mid',
                        label: 'MID'.tr(),
                        icon: Icons.height,
                        onTap: () => setState(() => _floorPref = 'Mid'),
                      ),
                      _circlePref(
                        context: context,
                        selected: _floorPref == 'High',
                        label: 'HIGH'.tr(),
                        icon: Icons.stairs_outlined,
                        onTap: () => setState(() => _floorPref = 'High'),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Luxury Amenities
            Text(
              'LUXURY_AMENITIES'.tr(),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: theme.colorScheme.onSurface),
            ),
            const SizedBox(height: 10),

            _switchRow(
              context: context,
              value: _privatePool,
              onChanged: (v) => setState(() => _privatePool = v),
              icon: Icons.pool,
              title: 'PRIVATE_POOL'.tr(),
              subtitle: 'PRIVATE_POOL_SUB'.tr(),
            ),
            const SizedBox(height: 12),
            _switchRow(
              context: context,
              value: _balcony,
              onChanged: (v) => setState(() => _balcony = v),
              icon: Icons.wb_sunny_outlined,
              title: 'BALCONY'.tr(),
              subtitle: 'BALCONY_SUB'.tr(),
            ),
            const SizedBox(height: 12),
            _switchRow(
              context: context,
              value: _breakfastIncluded,
              onChanged: (v) => setState(() => _breakfastIncluded = v),
              icon: Icons.free_breakfast,
              title: 'BREAKFAST_INCLUDED'.tr(),
              subtitle: 'BREAKFAST_INCLUDED_SUB'.tr(),
            ),
            const SizedBox(height: 12),
            _switchRow(
              context: context,
              value: _highSpeedWifi,
              onChanged: (v) => setState(() => _highSpeedWifi = v),
              icon: Icons.wifi,
              title: 'HIGH_SPEED_WIFI'.tr(),
              subtitle: 'HIGH_SPEED_WIFI_SUB'.tr(),
            ),

            const SizedBox(height: 24),

            // Accessibility & Others
            Text(
              'ACCESSIBILITY_AND_OTHERS'.tr(),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: theme.colorScheme.onSurface),
            ),
            const SizedBox(height: 10),

            _toggleRow(
              context: context,
              value: _nearElevator,
              onChanged: (v) => setState(() => _nearElevator = v),
              icon: Icons.elevator,
              title: 'NEAR_ELEVATOR'.tr(),
              subtitle: '',
            ),
            _toggleRow(
              context: context,
              value: _stepFreeAccess,
              onChanged: (v) => setState(() => _stepFreeAccess = v),
              icon: Icons.accessibility_new,
              title: 'STEP_FREE_ACCESS'.tr(),
              subtitle: '',
            ),
            _toggleRow(
              context: context,
              value: _petFriendly,
              onChanged: (v) => setState(() => _petFriendly = v),
              icon: Icons.pets,
              title: 'PET_FRIENDLY'.tr(),
              subtitle: 'PET_FRIENDLY_SUB'.tr(),
            ),

            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withAlpha(20),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: theme.colorScheme.primary.withAlpha(60)),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: theme.colorScheme.primary),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'SPECIFIC_REQUEST_INFO'.tr(),
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.onSurface.withAlpha(200),
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
      bottomNavigationBar: _applyButton(context),
    );
  }

  Widget _applyButton(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
      decoration: BoxDecoration(
        color: _getAdaptiveColor(context, light: Colors.white, dark: const Color(0xFF0B1F1C), highContrast: Colors.black), boxShadow: [
          BoxShadow(
            blurRadius: 18,
            color: Colors.black.withAlpha((0.06 * 255).round()),
          )
        ],
        border: Border.all(color: theme.colorScheme.outline.withAlpha(30)),
      ),
      child: SizedBox(
        height: 52,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context, {
                'priceRange': _priceRange,
                'adults': _adults,
                'children': _children,
                'roomPrefs': _roomPrefs,
                'bedType': _bedType,
                'floorPref': _floorPref,
                'privatePool': _privatePool,
                'balcony': _balcony,
                'breakfastIncluded': _breakfastIncluded,
                'highSpeedWifi': _highSpeedWifi,
                'nearElevator': _nearElevator,
                'stepFreeAccess': _stepFreeAccess,
                'petFriendly': _petFriendly,
              });
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: theme.colorScheme.onPrimary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            elevation: 0,
          ),
          child: Text(
            'APPLY_FILTERS'.tr(),
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 13.5),
          ),
        ),
      ),
    );
  }
}