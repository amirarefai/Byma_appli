import 'package:byma_app/business_logic/cities/cubit/cities_cubit.dart';
import 'package:byma_app/business_logic/cities/cubit/cities_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Added Bloc import

// Adjust these imports based on your project structure
import 'package:byma_app/data/models/city_model.dart';
import 'package:byma_app/data/models/hotel_filter_model.dart';

class HotelFilterScreen extends StatefulWidget {
  final HotelFilterModel? initialFilter;

  // Removed availableCities from constructor
  const HotelFilterScreen({
    super.key,
    this.initialFilter,
  });

  @override
  State<HotelFilterScreen> createState() => _HotelFilterScreenState();
}

class _HotelFilterScreenState extends State<HotelFilterScreen> {
  final TextEditingController _minPriceController = TextEditingController();
  final TextEditingController _maxPriceController = TextEditingController();
  CityModel? _selectedCity;

  @override
  void initState() {
    super.initState();
    _initializePriceFilters();
    
    // Trigger the API call when the screen opens
    context.read<CitiesCubit>().fetchAllCities();
  }

  // Only initialize prices here. City initialization is handled by BlocListener
  void _initializePriceFilters() {
    if (widget.initialFilter != null) {
      if (widget.initialFilter!.minPrice != null) {
        _minPriceController.text = widget.initialFilter!.minPrice.toString();
      }
      if (widget.initialFilter!.maxPrice != null) {
        _maxPriceController.text = widget.initialFilter!.maxPrice.toString();
      }
    }
  }

  @override
  void dispose() {
    _minPriceController.dispose();
    _maxPriceController.dispose();
    super.dispose();
  }

  void _resetFilters() {
    setState(() {
      _selectedCity = null;
      _minPriceController.clear();
      _maxPriceController.clear();
    });
  }

  void _applyFilters() {
    FocusScope.of(context).unfocus();

    final num? minPrice = num.tryParse(_minPriceController.text);
    final num? maxPrice = num.tryParse(_maxPriceController.text);

    final filterModel = HotelFilterModel(
      city: _selectedCity?.name,
      minPrice: minPrice,
      maxPrice: maxPrice,
    );

    Navigator.pop(context, filterModel);
  }

  // Active dropdown when API succeeds
  Widget _buildActiveCityDropdown(BuildContext context, List<CityModel> cities) {
    final theme = Theme.of(context);
    return DropdownButtonFormField<CityModel>(
      value: _selectedCity,
      hint: Text(
        'CHOOSE_CITY'.tr(),
        style: TextStyle(
            color: theme.colorScheme.tertiary.withAlpha(150),
            fontSize: 13,
            fontWeight: FontWeight.w600),
      ),
      style: TextStyle(
          color: theme.colorScheme.secondary,
          fontSize: 14,
          fontWeight: FontWeight.w700),
      dropdownColor: theme.cardColor,
      icon: Icon(Icons.arrow_drop_down_rounded,
          color: theme.colorScheme.tertiary, size: 28),
      decoration: InputDecoration(
        labelText: 'DESTINATION'.tr(),
        prefixIcon: Icon(Icons.location_city_outlined,
            color: theme.colorScheme.primary, size: 20),
        labelStyle: TextStyle(
            color: theme.colorScheme.tertiary, fontWeight: FontWeight.w600),
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
      items: cities.map((CityModel city) {
        return DropdownMenuItem<CityModel>(
          value: city,
          child: Text('${city.name} - ${city.country.name}'),
        );
      }).toList(),
      onChanged: (CityModel? newValue) {
        setState(() {
          _selectedCity = newValue;
        });
      },
    );
  }

  // Disabled dropdown shown during Loading or Error states
  Widget _buildStateDropdown(BuildContext context, String hintText, {bool isError = false}) {
    final theme = Theme.of(context);
    return DropdownButtonFormField<CityModel>(
      isExpanded: true,
      value: null,
      items: const [],
      onChanged: null, // Disables the dropdown
      hint: Row(
        children: [
          if (!isError) ...[
             SizedBox(
              width: 14, 
              height: 14, 
              child: CircularProgressIndicator(strokeWidth: 2, color: theme.colorScheme.primary)
            ),
            const SizedBox(width: 10),
          ],
          Expanded(
            child: Text(
              hintText,
              style: TextStyle(
                  color: isError ? Colors.red : theme.colorScheme.tertiary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      decoration: InputDecoration(
        labelText: 'DESTINATION'.tr(),
        prefixIcon: Icon(Icons.location_city_outlined,
            color: theme.colorScheme.primary.withAlpha(100), size: 20),
        labelStyle: TextStyle(
            color: theme.colorScheme.tertiary, fontWeight: FontWeight.w600),
        filled: true,
        fillColor: theme.cardColor,
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: theme.dividerColor),
        ),
      ),
    );
  }

  Widget _buildPriceField({
    required BuildContext context,
    required TextEditingController controller,
    required String labelText,
    required String hintText,
  }) {
    final theme = Theme.of(context);
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
      ],
      style: TextStyle(
          color: theme.colorScheme.secondary,
          fontSize: 14,
          fontWeight: FontWeight.w700),
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: Icon(Icons.attach_money_rounded,
            color: theme.colorScheme.primary, size: 20),
        labelStyle: TextStyle(
            color: theme.colorScheme.tertiary, fontWeight: FontWeight.w600),
        hintStyle: TextStyle(
            color: theme.colorScheme.tertiary.withAlpha(150), fontSize: 13),
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(110),
        child: SafeArea(
          // ... (Keep your existing AppBar code exactly as it is)
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(18)),
                        border: Border.all(color: theme.dividerColor),
                      ),
                      child: Icon(Icons.arrow_back_ios_new,
                          size: 18, color: theme.colorScheme.secondary),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'HOTEL_FILTERS'.tr(),
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: theme.colorScheme.secondary),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'REFINE_YOUR_PERFECT_STAY'.tr(),
                          style: TextStyle(
                              fontSize: 11,
                              color: theme.colorScheme.tertiary,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: _resetFilters,
                    child: Text(
                      'RESET'.tr(),
                      style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w800,
                          fontSize: 13),
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
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          children: [
            
            // --- BLOC CONSUMER ADDED HERE ---
            BlocConsumer<CitiesCubit, CitiesState>(
              listener: (context, state) {
                // Listen for success to pre-select the initial city
                state.whenOrNull(
                  success: (cities) {
                    if (widget.initialFilter?.city != null && _selectedCity == null) {
                      try {
                        setState(() {
                          _selectedCity = cities.firstWhere(
                            (city) => city.name == widget.initialFilter!.city,
                          );
                        });
                      } catch (_) {
                        // City not found, leave as null
                      }
                    }
                  },
                );
              },
              builder: (context, state) {
                // Freezed .when() guarantees all states are handled in the UI
                return state.when(
                  initial: () => _buildStateDropdown(context, 'Loading cities...'),
                  loading: () => _buildStateDropdown(context, 'Loading cities...'),
                  success: (cities) => _buildActiveCityDropdown(context, cities),
                  error: (message) => _buildStateDropdown(context, message, isError: true),
                );
              },
            ),
            // --------------------------------

            const SizedBox(height: 24),
            Text(
              'PRICE_RANGE'.tr(),
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: theme.colorScheme.secondary),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildPriceField(
                    context: context,
                    controller: _minPriceController,
                    labelText: 'MIN_PRICE'.tr(),
                    hintText: '0',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildPriceField(
                    context: context,
                    controller: _maxPriceController,
                    labelText: 'MAX_PRICE'.tr(),
                    hintText: '1000+',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        // ... (Keep your existing bottomNavigationBar code exactly as it is)
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
        decoration: BoxDecoration(
          color: theme.cardColor,
          border: Border(top: BorderSide(color: theme.dividerColor)),
        ),
        child: SafeArea(
          child: SizedBox(
            height: 52,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _applyFilters,
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.primary == Colors.yellow
                    ? Colors.black
                    : theme.colorScheme.secondary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                elevation: 0,
              ),
              child: Text(
                'APPLY_FILTERS'.tr(),
                style: const TextStyle(
                    fontWeight: FontWeight.w900, fontSize: 13.5),
              ),
            ),
          ),
        ),
      ),
    );
  }
}