import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'filtered_results_updated_screen.dart'; // تأكد من صحة مسار الاستيراد هنا

class FiltersAdvancedScreen extends StatefulWidget {
  const FiltersAdvancedScreen({super.key});

  @override
  State<FiltersAdvancedScreen> createState() => _FiltersAdvancedScreenState();
}

class _FiltersAdvancedScreenState extends State<FiltersAdvancedScreen> {
  final TextEditingController _nameController = TextEditingController();
  String? _selectedGovernorate; 
  int _selectedRating = 0; 

  bool _privatePool = true;
  bool _balcony = false;
  bool _breakfastIncluded = false;
  bool _highSpeedWifi = true;

  final List<String> _syrianGovernorates = [
    'DAMASCUS', 'RIF_DIMASHQ', 'ALEPPO', 'HOMS', 'HAMA', 
    'LATAKIA', 'TARTOUS', 'IDLIB', 'DERAA', 'AS_SUWAYDA', 
    'QUNEITRA', 'DEIR_EZ_ZOR', 'AL_HASAKAH', 'AR_RAQQAH',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Widget _buildTextField({
    required BuildContext context,
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required IconData prefixIcon,
  }) {
    final theme = Theme.of(context);
    return TextField(
      controller: controller,
      style: TextStyle(color: theme.colorScheme.secondary, fontSize: 14, fontWeight: FontWeight.w700),
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: Icon(prefixIcon, color: theme.colorScheme.primary, size: 20),
        labelStyle: TextStyle(color: theme.colorScheme.tertiary, fontWeight: FontWeight.w600),
        hintStyle: TextStyle(color: theme.colorScheme.tertiary.withAlpha(150), fontSize: 13),
        filled: true,
        fillColor: theme.cardColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: theme.dividerColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: theme.colorScheme.primary, width: 1.5),
        ),
      ),
    );
  }

  Widget _buildGovernorateDropdown(BuildContext context) {
    final theme = Theme.of(context);
    return DropdownButtonFormField<String>(
      value: _selectedGovernorate,
      hint: Text(
        'CHOOSE_GOVERNORATE'.tr(),
        style: TextStyle(color: theme.colorScheme.tertiary.withAlpha(150), fontSize: 13, fontWeight: FontWeight.w600),
      ),
      style: TextStyle(color: theme.colorScheme.secondary, fontSize: 14, fontWeight: FontWeight.w700),
      dropdownColor: theme.cardColor,
      icon: Icon(Icons.arrow_drop_down_rounded, color: theme.colorScheme.tertiary, size: 28),
      decoration: InputDecoration(
        labelText: 'HOTEL_ADDRESS'.tr(),
        prefixIcon: Icon(Icons.location_on_outlined, color: theme.colorScheme.primary, size: 20),
        labelStyle: TextStyle(color: theme.colorScheme.tertiary, fontWeight: FontWeight.w600),
        filled: true,
        fillColor: theme.cardColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: theme.dividerColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: theme.colorScheme.primary, width: 1.5),
        ),
      ),
      items: _syrianGovernorates.map((String gov) {
        return DropdownMenuItem<String>(
          value: gov,
          child: Text(gov.tr()),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedGovernorate = newValue;
        });
      },
    );
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
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor, width: 1),
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
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: theme.colorScheme.secondary),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 11.5, color: theme.colorScheme.tertiary, height: 1.2),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: theme.colorScheme.primary,
            activeTrackColor: theme.colorScheme.primary.withAlpha(100),
            inactiveThumbColor: theme.colorScheme.tertiary,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(110),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: theme.dividerColor, width: 1.2),
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
                        color: theme.scaffoldBackgroundColor,
                        borderRadius: const BorderRadius.all(Radius.circular(18)),
                        border: Border.all(color: theme.dividerColor),
                      ),
                      child: Icon(Icons.arrow_back_ios_new, size: 18, color: theme.colorScheme.secondary),
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
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: theme.colorScheme.secondary),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'REFINE_YOUR_PERFECT_STAY'.tr(),
                          style: TextStyle(fontSize: 11, color: theme.colorScheme.tertiary, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _nameController.clear();
                        _selectedGovernorate = null;
                        _selectedRating = 0;
                        _privatePool = true;
                        _balcony = false;
                        _breakfastIncluded = false;
                        _highSpeedWifi = true;
                      });
                    },
                    child: Text(
                      'RESET'.tr(),
                      style: TextStyle(color: theme.colorScheme.primary, fontWeight: FontWeight.w800, fontSize: 13),
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
            const SizedBox(height: 10),
            _buildTextField(
              context: context,
              controller: _nameController,
              labelText: 'HOTEL_NAME'.tr(),
              hintText: 'ENTER_HOTEL_NAME'.tr(),
              prefixIcon: Icons.hotel_class_outlined,
            ),
            const SizedBox(height: 16),
            _buildGovernorateDropdown(context),
            const SizedBox(height: 24),
            Text(
              'RATING'.tr(),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: theme.colorScheme.secondary),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: theme.dividerColor),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    onPressed: () {
                      setState(() {
                        _selectedRating = index + 1;
                      });
                    },
                    icon: Icon(
                      index < _selectedRating ? Icons.star_rounded : Icons.star_outline_rounded,
                      color: index < _selectedRating 
                          ? (theme.colorScheme.primary == Colors.yellow ? Colors.yellow : Colors.amber) 
                          : theme.colorScheme.tertiary.withAlpha(100),
                      size: 36,
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'LUXURY_AMENITIES'.tr(),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: theme.colorScheme.secondary),
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
        color: theme.cardColor, 
        border: Border(top: BorderSide(color: theme.dividerColor)),
      ),
      child: SizedBox(
        height: 52,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            // الانتقال المباشر لشاشة نتائج الفلترة وتمرير البيانات المحددة لها
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => FilteredResultsUpdatedScreen(
                  location: _selectedGovernorate, // يمرر اسم المحافظة مثل 'DAMASCUS'
                  hotelName: _nameController.text.isEmpty ? null : _nameController.text,
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: theme.colorScheme.primary == Colors.yellow ? Colors.black : theme.colorScheme.secondary,
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