import 'package:byma_app/business_logic/room_category/cubit/room_category_cubit.dart';
import 'package:byma_app/business_logic/room_category/cubit/room_category_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:byma_app/data/models/room_filter_model.dart';
import 'package:byma_app/data/models/room_category_model.dart';

class RoomFilterScreen extends StatefulWidget {
  final RoomFilterModel? initialFilter;

  const RoomFilterScreen({super.key, this.initialFilter});

  @override
  State<RoomFilterScreen> createState() => _RoomFilterScreenState();
}

class _RoomFilterScreenState extends State<RoomFilterScreen> {
  // Matches FilterRoomDto expectations
  int? _floor;
  int? _bedNumber;
  RangeValues _priceRange = const RangeValues(0, 2000);
  String? _status;
  int? _selectedCategoryId;

  @override
  void initState() {
    super.initState();
    
    // Load initial values if passing an existing filter model
    if (widget.initialFilter != null) {
      _floor = widget.initialFilter!.floor;
      _bedNumber = widget.initialFilter!.bedNumber;
      _status = widget.initialFilter!.status;
      _selectedCategoryId = widget.initialFilter!.roomCategoryId;
      _priceRange = RangeValues(
        widget.initialFilter!.minPrice?.toDouble() ?? 0,
        widget.initialFilter!.maxPrice?.toDouble() ?? 2000,
      );
    }

    // Trigger category fetch if not already loaded
    final categoryCubit = context.read<RoomCategoryCubit>();
    if (categoryCubit.state.maybeMap(
      success: (_) => false,
      orElse: () => true,
    )) {
      categoryCubit.fetchAllRoomCategories();
    }
  }

  void _applyFilters() {
    final filter = RoomFilterModel(
      floor: _floor,
      bedNumber: _bedNumber,
      minPrice: _priceRange.start > 0 ? _priceRange.start.round() : null,
      maxPrice: _priceRange.end < 2000 ? _priceRange.end.round() : null,
      status: _status,
      roomCategoryId: _selectedCategoryId,
    );
    
    // Return the filter model to the parent screen to trigger HotelRoomsFilterCubit
    Navigator.pop(context, filter);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    final isHighContrast = MediaQuery.highContrastOf(context) || 
        (theme.colorScheme.primary == Colors.black && !isDark);

    final bg = isHighContrast 
        ? Colors.white 
        : (isDark ? const Color(0xFF121212) : const Color(0xFFF3F7F8));
        
    final cardColor = isHighContrast 
        ? Colors.white 
        : (isDark ? const Color(0xFF1E1E1E) : Colors.white);
        
    final cardBorder = isHighContrast 
        ? Colors.black 
        : (isDark ? const Color(0xFF2C2C2C) : const Color(0xFFE0E8E9));

    final mainTeal = isHighContrast 
        ? Colors.black 
        : (isDark ? const Color(0xFF14B8A6) : const Color(0xFF0E6F63));

    final textColor = isHighContrast 
        ? Colors.black 
        : (isDark ? Colors.white : Colors.black);

    final textMuted = isHighContrast 
        ? Colors.black.withOpacity(0.75) 
        : (isDark ? Colors.white60 : Colors.black54);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: cardColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: textColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'filter_rooms_title'.tr(), // Make sure to add this to translations
          style: TextStyle(fontWeight: FontWeight.w900, color: textColor),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(18, 16, 18, 24),
                children: [
                  // Text(
                  //   'customize_search_title'.tr(),
                  //   style: TextStyle(
                  //     fontSize: 28,
                  //     height: 1.1,
                  //     fontWeight: FontWeight.w900,
                  //     color: mainTeal,
                  //   ),
                  // ),
                  const SizedBox(height: 20),

                  // 1. ROOM CATEGORY DROPDOWN
                  _CategorySelectionCard(
                    selectedCategoryId: _selectedCategoryId,
                    onChanged: (cat) => setState(() => _selectedCategoryId = cat?.id),
                    cardColor: cardColor,
                    cardBorder: cardBorder,
                    mainTeal: mainTeal,
                    textColor: textColor,
                    isHighContrast: isHighContrast,
                  ),
                  const SizedBox(height: 12),

                  // 2. ROOM STATUS (AVAILABLE / BOOKED)
                  _StatusSelectionCard(
                    currentStatus: _status,
                    onStatusChanged: (status) => setState(() => _status = status),
                    cardColor: cardColor,
                    cardBorder: cardBorder,
                    mainTeal: mainTeal,
                    textColor: textColor,
                    textMuted: textMuted,
                    isHighContrast: isHighContrast,
                  ),
                  const SizedBox(height: 12),

                  // 3. PRICE RANGE
                  _PriceRangeCard(
                    priceRange: _priceRange,
                    onChanged: (range) => setState(() => _priceRange = range),
                    cardColor: cardColor,
                    cardBorder: cardBorder,
                    mainTeal: mainTeal,
                    textColor: textColor,
                    textMuted: textMuted,
                    isHighContrast: isHighContrast,
                  ),
                  const SizedBox(height: 12),

                  // 4. FLOOR AND BEDS
                  _RoomDetailsCard(
                    floor: _floor,
                    bedNumber: _bedNumber,
                    onFloorChanged: (f) => setState(() => _floor = f),
                    onBedsChanged: (b) => setState(() => _bedNumber = b),
                    cardColor: cardColor,
                    cardBorder: cardBorder,
                    mainTeal: mainTeal,
                    textColor: textColor,
                    textMuted: textMuted,
                    isHighContrast: isHighContrast,
                  ),
                ],
              ),
            ),
            
            // APPLY BUTTON
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: cardColor,
                border: Border(top: BorderSide(color: cardBorder, width: isHighContrast ? 2 : 1)),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainTeal,
                    foregroundColor: isHighContrast ? Colors.white : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: isHighContrast ? const BorderSide(color: Colors.black, width: 2) : BorderSide.none,
                    ),
                    elevation: 0,
                  ),
                  onPressed: _applyFilters,
                  child: Text(
                    'apply filters'.tr(),
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ---------------------- SUB-WIDGETS ----------------------

class _CategorySelectionCard extends StatelessWidget {
  final int? selectedCategoryId;
  final ValueChanged<RoomCategoryModel?> onChanged;
  final Color cardColor;
  final Color cardBorder;
  final Color mainTeal;
  final Color textColor;
  final bool isHighContrast;

  const _CategorySelectionCard({
    required this.selectedCategoryId,
    required this.onChanged,
    required this.cardColor,
    required this.cardBorder,
    required this.mainTeal,
    required this.textColor,
    required this.isHighContrast,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        border: Border.all(color: cardBorder, width: isHighContrast ? 2 : 1),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.category_outlined, color: mainTeal, size: 20),
              const SizedBox(width: 8),
              Text(
                'room category'.tr(),
                style: TextStyle(fontWeight: FontWeight.w900, color: textColor, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 12),
          BlocBuilder<RoomCategoryCubit, RoomCategoryState>(
            builder: (context, state) {
              return state.when(
                initial: () => const SizedBox(),
                loading: () => const Center(child: CircularProgressIndicator()),
                success: (categories) {
                  final selectedCategory = categories.where(
                    (category) => category.id == selectedCategoryId,
                  ).firstOrNull;

                  return DropdownButtonFormField<RoomCategoryModel>(
                    initialValue: selectedCategory,
                    hint: Text('select_category_hint'.tr()),
                    isExpanded: true,
                    dropdownColor: cardColor,
                    style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: cardBorder),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: mainTeal, width: 2),
                      ),
                    ),
                    items: [
                      DropdownMenuItem<RoomCategoryModel>(
                        value: null,
                        child: Text('all categories'.tr()),
                      ),
                      ...categories.map((cat) => DropdownMenuItem(
                        value: cat,
                        child: Text(cat.name),
                      ))
                    ],
                    onChanged: onChanged,
                  );
                },
                error: (msg) => Text(msg, style: const TextStyle(color: Colors.red)),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _StatusSelectionCard extends StatelessWidget {
  final String? currentStatus;
  final ValueChanged<String?> onStatusChanged;
  final Color cardColor;
  final Color cardBorder;
  final Color mainTeal;
  final Color textColor;
  final Color textMuted;
  final bool isHighContrast;

  const _StatusSelectionCard({
    required this.currentStatus,
    required this.onStatusChanged,
    required this.cardColor,
    required this.cardBorder,
    required this.mainTeal,
    required this.textColor,
    required this.textMuted,
    required this.isHighContrast,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        border: Border.all(color: cardBorder, width: isHighContrast ? 2 : 1),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'room status'.tr(),
            style: TextStyle(fontWeight: FontWeight.w900, color: textColor, fontSize: 12, letterSpacing: 0.6),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _FilterOption(
                  label: 'any status'.tr(),
                  selected: currentStatus == null,
                  onTap: () => onStatusChanged(null),
                  activeColor: mainTeal,
                  textColor: textColor,
                  cardColor: cardColor,
                  cardBorder: cardBorder,
                  isHighContrast: isHighContrast,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _FilterOption(
                  label: 'AVAILABLE', // Matching Enum Exact
                  selected: currentStatus == 'AVAILABLE',
                  onTap: () => onStatusChanged('AVAILABLE'),
                  activeColor: mainTeal,
                  textColor: textColor,
                  cardColor: cardColor,
                  cardBorder: cardBorder,
                  isHighContrast: isHighContrast,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _FilterOption(
                  label: 'BOOKED', // Matching Enum Exact
                  selected: currentStatus == 'BOOKED',
                  onTap: () => onStatusChanged('BOOKED'),
                  activeColor: mainTeal,
                  textColor: textColor,
                  cardColor: cardColor,
                  cardBorder: cardBorder,
                  isHighContrast: isHighContrast,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PriceRangeCard extends StatelessWidget {
  final RangeValues priceRange;
  final ValueChanged<RangeValues> onChanged;
  final Color cardColor;
  final Color cardBorder;
  final Color mainTeal;
  final Color textColor;
  final Color textMuted;
  final bool isHighContrast;

  const _PriceRangeCard({
    required this.priceRange,
    required this.onChanged,
    required this.cardColor,
    required this.cardBorder,
    required this.mainTeal,
    required this.textColor,
    required this.textMuted,
    required this.isHighContrast,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        border: Border.all(color: cardBorder, width: isHighContrast ? 2 : 1),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.attach_money, color: mainTeal, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'price range'.tr(),
                    style: TextStyle(fontWeight: FontWeight.w900, color: textColor, fontSize: 14),
                  ),
                ],
              ),
              Text(
                '\$${priceRange.start.toInt()} - \$${priceRange.end.toInt()}',
                style: TextStyle(fontWeight: FontWeight.bold, color: mainTeal),
              )
            ],
          ),
          const SizedBox(height: 8),
          RangeSlider(
            values: priceRange,
            min: 0,
            max: 2000, 
            divisions: 40,
            activeColor: mainTeal,
            inactiveColor: cardBorder,
            labels: RangeLabels(
              '\$${priceRange.start.toInt()}',
              '\$${priceRange.end.toInt()}',
            ),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class _RoomDetailsCard extends StatelessWidget {
  final int? floor;
  final int? bedNumber;
  final ValueChanged<int?> onFloorChanged;
  final ValueChanged<int?> onBedsChanged;
  final Color cardColor;
  final Color cardBorder;
  final Color mainTeal;
  final Color textColor;
  final Color textMuted;
  final bool isHighContrast;

  const _RoomDetailsCard({
    required this.floor,
    required this.bedNumber,
    required this.onFloorChanged,
    required this.onBedsChanged,
    required this.cardColor,
    required this.cardBorder,
    required this.mainTeal,
    required this.textColor,
    required this.textMuted,
    required this.isHighContrast,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        border: Border.all(color: cardBorder, width: isHighContrast ? 2 : 1),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          _CounterRow(
            label: 'floor number'.tr(),
            value: floor,
            hint: floor == null ? 'any floor'.tr() : 'exact floor'.tr(),
            textColor: textColor,
            textMuted: textMuted,
            mainTeal: mainTeal,
            cardColor: cardColor,
            isHighContrast: isHighContrast,
            allowNull: true,
            onChanged: (val) => onFloorChanged(val),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(height: 1, thickness: 1),
          ),
          _CounterRow(
            label: 'beds number'.tr(),
            value: bedNumber,
            hint: 'min 1 bed'.tr(),
            textColor: textColor,
            textMuted: textMuted,
            mainTeal: mainTeal,
            cardColor: cardColor,
            isHighContrast: isHighContrast,
            allowNull: true,
            min: 1,
            onChanged: onBedsChanged,
          ),
        ],
      ),
    );
  }
}

class _CounterRow extends StatelessWidget {
  final String label;
  final int? value;
  final String? hint;
  final Color textColor;
  final Color textMuted;
  final Color mainTeal;
  final Color cardColor;
  final bool isHighContrast;
  final bool allowNull;
  final int min;
  final ValueChanged<int?> onChanged;

  const _CounterRow({
    required this.label,
    required this.value,
    this.hint,
    required this.textColor,
    required this.textMuted,
    required this.mainTeal,
    required this.cardColor,
    required this.isHighContrast,
    this.allowNull = false,
    this.min = 0,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontWeight: FontWeight.w900, color: textColor, fontSize: 13.5),
              ),
              if (hint != null)
                Text(
                  hint!,
                  style: TextStyle(color: textMuted, fontSize: 11.5),
                ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        _PlusMinus(
          value: value,
          onIncrement: () => onChanged((value ?? (min - 1)) + 1),
          onDecrement: () {
            if (value == null) return;
            if (value! <= min) {
              onChanged(allowNull ? null : min);
            } else {
              onChanged(value! - 1);
            }
          },
          activeColor: mainTeal,
          cardColor: cardColor,
          textColor: textColor,
          isHighContrast: isHighContrast,
          allowNull: allowNull,
        ),
      ],
    );
  }
}

class _PlusMinus extends StatelessWidget {
  final int? value;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final Color activeColor;
  final Color cardColor;
  final Color textColor;
  final bool isHighContrast;
  final bool allowNull;

  const _PlusMinus({
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
    required this.activeColor,
    required this.cardColor,
    required this.textColor,
    required this.isHighContrast,
    this.allowNull = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isMinLimit = value == null || (!allowNull && value! <= 1);
    final disabledBg = isHighContrast ? Colors.white : (Theme.of(context).brightness == Brightness.dark ? const Color(0xFF2D3748) : const Color(0xFFE9EEF0));
    final disabledIcon = isHighContrast ? Colors.grey : const Color(0xFF99A8AE);

    return Row(
      children: [
        Container(
          height: 44,
          width: 44,
          decoration: BoxDecoration(
            color: isMinLimit ? disabledBg : (isHighContrast ? Colors.white : activeColor.withOpacity(0.1)),
            shape: BoxShape.circle,
            border: isHighContrast ? Border.all(color: Colors.black, width: 2) : null,
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: onDecrement,
            icon: Icon(Icons.remove, color: isMinLimit ? disabledIcon : (isHighContrast ? Colors.black : activeColor), size: 18),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 28,
          child: Center(
            child: Text(
              value == null ? '--' : value.toString().padLeft(2, '0'),
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: textColor),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          height: 44,
          width: 44,
          decoration: BoxDecoration(
            color: activeColor,
            shape: BoxShape.circle,
            border: isHighContrast ? Border.all(color: Colors.black, width: 2) : null,
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: onIncrement,
            icon: Icon(Icons.add, color: isHighContrast ? Colors.black : Colors.white, size: 18),
          ),
        ),
      ],
    );
  }
}

class _FilterOption extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color activeColor;
  final Color textColor;
  final Color cardBorder;
  final Color cardColor;
  final bool isHighContrast;

  const _FilterOption({
    required this.label,
    required this.selected,
    required this.onTap,
    required this.activeColor,
    required this.textColor,
    required this.cardBorder,
    required this.cardColor,
    required this.isHighContrast,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        width: double.infinity,
        decoration: BoxDecoration(
          color: selected ? activeColor : cardColor,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: selected ? (isHighContrast ? Colors.black : Colors.transparent) : cardBorder,
            width: isHighContrast ? 2 : 1,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: selected ? (isHighContrast ? Colors.black : Colors.white) : activeColor,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}