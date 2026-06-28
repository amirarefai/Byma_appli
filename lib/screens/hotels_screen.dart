import 'package:byma_app/screens/curated_stays_screen.dart';
import 'package:flutter/material.dart'; 

import 'package:intl/intl.dart'; 
import 'package:easy_localization/easy_localization.dart';

import '../state/favorites_scope.dart'; 
import '../state/favorites_store.dart'; 
import '../widgets/byma_bottom_nav.dart'; 
import 'bookings_screen.dart'; 
import 'main_layout_screen.dart'; 
import 'messages_final_navigation.dart'; 
import 'settings_refined_screen.dart'; 
import 'filtered_results_updated_screen.dart'; 

class HotelsScreen extends StatefulWidget { 
  const HotelsScreen({super.key}); 

  @override 
  State<HotelsScreen> createState() => _HotelsScreenState(); 
} 

class _HotelsScreenState extends State<HotelsScreen> { 
  int selectedCategoryIndex = 0; 
  BymaBottomNavTab _currentNavTab = BymaBottomNavTab.home; 

  String? selectedLocation; 
  DateTimeRange? selectedDateRange; 

  // قائمة مفاتيح المدن السورية لربطها بالترجمة
  final List<String> syrianCities = [ 
    'damascus', 'rif_dimashq', 'aleppo', 'lattakia', 'tartous', 
    'homs', 'hama', 'daraa', 'as_suwayda', 'idlib', 
    'raqqa', 'deir_ez_zor', 'al_hasakah', 'quneitra'
  ]; 

  void _showLocationPicker(BuildContext context) { 
    showDialog( 
      context: context, 
      builder: (BuildContext context) { 
        final theme = Theme.of(context);
        return AlertDialog( 
          backgroundColor: theme.cardColor,
          title: Text( 
            'select_location'.tr(), 
            style: TextStyle(
              fontWeight: FontWeight.bold, 
              fontSize: 18,
              color: theme.colorScheme.secondary,
            ), 
          ), 
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), 
          content: SizedBox( 
            width: double.maxFinite, 
            child: ListView.separated( 
              shrinkWrap: true, 
              itemCount: syrianCities.length, 
              separatorBuilder: (_, _) => Divider(color: theme.dividerColor), 
              itemBuilder: (context, index) { 
                final cityKey = syrianCities[index];
                final isSelected = selectedLocation == cityKey;
                return ListTile( 
                  leading: Icon(Icons.location_on_outlined, color: theme.colorScheme.tertiary), 
                  title: Text( 
                    cityKey.tr(), 
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.secondary,
                    ), 
                  ), 
                  trailing: isSelected 
                      ? Icon(Icons.check_circle, color: theme.colorScheme.primary) 
                      : null, 
                  onTap: () { 
                    setState(() { 
                      selectedLocation = cityKey; 
                    }); 
                    Navigator.pop(context); 
                  }, 
                ); 
              }, 
            ), 
          ), 
        ); 
      }, 
    ); 
  } 

  Future<void> _showDatePicker(BuildContext context) async { 
    final theme = Theme.of(context);
    final DateTimeRange? picked = await showDateRangePicker( 
      context: context, 
      firstDate: DateTime.now(), 
      lastDate: DateTime.now().add(const Duration(days: 365)), 
      currentDate: DateTime.now(), 
      builder: (context, child) { 
        return Theme( 
          data: theme.copyWith( 
            colorScheme: theme.colorScheme.copyWith( 
              primary: theme.colorScheme.primary, 
              onPrimary: Colors.white, 
              surface: theme.cardColor, 
              onSurface: theme.colorScheme.secondary, 
            ), 
            dialogTheme: DialogThemeData( 
              backgroundColor: theme.cardColor, 
            ), 
          ), 
          child: child!, 
        ); 
      }, 
    ); 

    if (picked != null) { 
      setState(() { 
        selectedDateRange = picked; 
      }); 
    } 
  } 

  String get _dateRangeString { 
    if (selectedDateRange == null) { 
      return 'add_dates'.tr(); 
    } 
    final localeStr = context.locale.languageCode;
    final start = DateFormat('MMM dd', localeStr).format(selectedDateRange!.start); 
    final end = DateFormat('MMM dd', localeStr).format(selectedDateRange!.end); 
    return '$start - $end'; 
  } 

  @override 
  Widget build(BuildContext context) { 
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary; 
    final darkTextColor = theme.colorScheme.secondary; 
    final secondaryTextColor = theme.colorScheme.tertiary; 
    final backgroundColor = theme.scaffoldBackgroundColor; 

    final categories = [ 
      {'icon': Icons.king_bed_outlined, 'label': 'hotels_cat'.tr()}, 
      {'icon': Icons.directions_car_outlined, 'label': 'cars_cat'.tr()}, 
      {'icon': Icons.restaurant_outlined, 'label': 'eats_cat'.tr()}, 
    ]; 

    final hotels = [ 
      { 
        'image': 'assets/hotel_1.jpg', 
        'title': 'hotel_1_title'.tr(), 
        'subtitle': 'hotel_1_sub'.tr(), 
        'rating': '4.8', 
        'price': '2400', 
        'unit': 'night'.tr(), 
      }, 
      { 
        'image': 'assets/hotel_2.jpg', 
        'title': 'hotel_2_title'.tr(), 
        'subtitle': 'hotel_2_sub'.tr(), 
        'rating': '4.9', 
        'price': '2450', 
        'unit': 'night'.tr(), 
      }, 
      { 
        'image': 'assets/hotel_3.jpg', 
        'title': 'hotel_3_title'.tr(), 
        'subtitle': 'hotel_3_sub'.tr(), 
        'rating': '4.7', 
        'price': '1900', 
        'unit': 'night'.tr(), 
      }, 
      { 
        'image': 'assets/hotel_4.jpg', 
        'title': 'hotel_4_title'.tr(), 
        'subtitle': 'hotel_4_sub'.tr(), 
        'rating': '5.0', 
        'price': '1800', 
        'unit': 'day'.tr(), 
      }, 
    ]; 

    return Scaffold( 
      backgroundColor: backgroundColor, 
      body: SafeArea( 
        top: false, 
        child: CustomScrollView( 
          physics: const BouncingScrollPhysics(), 
          slivers: [ 
            SliverAppBar( 
              floating: true, 
              pinned: false, 
              automaticallyImplyLeading: false, 
              backgroundColor: backgroundColor, 
              elevation: 0, 
              centerTitle: false, 
              titleSpacing: 0, 
              toolbarHeight: 92, 
              title: Padding( 
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0), 
                child: Container( 
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10), 
                  decoration: BoxDecoration( 
                    color: theme.cardColor, 
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
                      Text( 
                        'BYMA', 
                        style: TextStyle( 
                          color: primaryColor, 
                          fontWeight: FontWeight.w900, 
                          fontSize: 24, 
                          letterSpacing: 1.1, 
                        ), 
                      ), 
                      const Spacer(), 
                      Container( 
                        height: 40, 
                        width: 40, 
                        decoration: BoxDecoration( 
                          color: primaryColor.withValues(alpha: 0.08), 
                          shape: BoxShape.circle, 
                        ), 
                        child: Icon( 
                          Icons.notifications_none_outlined, 
                          color: darkTextColor, 
                          size: 20, 
                        ), 
                      ), 
                    ], 
                  ), 
                ), 
              ), 
            ), 

            SliverToBoxAdapter( 
              child: Padding( 
                padding: const EdgeInsets.symmetric(horizontal: 20.0), 
                child: Column( 
                  crossAxisAlignment: CrossAxisAlignment.start, 
                  children: [ 
                    const SizedBox(height: 10), 
                    Container( 
                      padding: const EdgeInsets.all(18), 
                      decoration: BoxDecoration( 
                        color: theme.cardColor, 
                        borderRadius: BorderRadius.circular(28), 
                        boxShadow: [ 
                          BoxShadow( 
                            color: Colors.black.withValues(alpha: 0.04), 
                            blurRadius: 24, 
                            offset: const Offset(0, 12), 
                          ) 
                        ], 
                      ), 
                      child: Column( 
                        children: [ 
                          Row( 
                            children: [ 
                              Expanded( 
                                child: InkWell( 
                                  onTap: () => _showLocationPicker(context), 
                                  borderRadius: BorderRadius.circular(12), 
                                  child: _buildSearchSection( 
                                    icon: Icons.location_on_rounded, 
                                    title: 'location_label'.tr(), 
                                    subtitle: selectedLocation != null ? selectedLocation!.tr() : 'location_placeholder'.tr(),  
                                    primaryColor: primaryColor, 
                                    secondaryTextColor: secondaryTextColor,
                                    darkTextColor: darkTextColor,
                                  ), 
                                ), 
                              ), 
                              Container( 
                                height: 35, 
                                width: 1, 
                                color: theme.dividerColor, 
                              ), 
                              Expanded( 
                                child: InkWell( 
                                  onTap: () => _showDatePicker(context), 
                                  borderRadius: BorderRadius.circular(12), 
                                  child: _buildSearchSection( 
                                    icon: Icons.calendar_month_rounded, 
                                    title: 'stay_label'.tr(), 
                                    subtitle: _dateRangeString,  
                                    primaryColor: primaryColor, 
                                    secondaryTextColor: secondaryTextColor,
                                    darkTextColor: darkTextColor,
                                  ), 
                                ), 
                              ), 
                            ], 
                          ), 
                          const SizedBox(height: 16), 
                          InkWell( 
                            onTap: () { 
                              if (selectedLocation == null) { 
                                ScaffoldMessenger.of(context).showSnackBar( 
                                  SnackBar( 
                                    content: Text('error_select_location'.tr()), 
                                    backgroundColor: Colors.amber[700], 
                                    behavior: SnackBarBehavior.floating, 
                                  ), 
                                ); 
                                return; 
                              } 

                              if (selectedDateRange == null) { 
                                ScaffoldMessenger.of(context).showSnackBar( 
                                  SnackBar( 
                                    content: Text('error_select_dates'.tr()), 
                                    backgroundColor: Colors.amber[700], 
                                    behavior: SnackBarBehavior.floating, 
                                  ), 
                                ); 
                                return; 
                              } 

                              Navigator.push( 
                                context, 
                                MaterialPageRoute( 
                                  builder: (context) => CuratedStaysScreen( 
                                    location: selectedLocation!.tr(), 
                                    dateRange: selectedDateRange, 
                                  ), 
                                ), 
                              ); 
                            }, 
                            borderRadius: BorderRadius.circular(18), 
                            child: Container( 
                              height: 54, 
                              width: double.infinity, 
                              decoration: BoxDecoration( 
                                color: primaryColor, 
                                borderRadius: BorderRadius.circular(18), 
                              ), 
                              child: const Center( 
                                child: Icon(Icons.search, color: Colors.white, size: 26), 
                              ), 
                            ), 
                          ), 
                        ], 
                      ), 
                    ), 
                    const SizedBox(height: 32), 

                    SizedBox( 
                      height: 100, 
                      child: Row( 
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                        children: List.generate(categories.length, (index) { 
                          final category = categories[index]; 
                          final bool isSelected = index == selectedCategoryIndex; 

                          return GestureDetector( 
                            onTap: () { 
                              setState(() { 
                                selectedCategoryIndex = index; 
                              }); 
                            }, 
                            child: Column( 
                              children: [ 
                                AnimatedContainer( 
                                  duration: const Duration(milliseconds: 250), 
                                  height: 64, 
                                  width: 64, 
                                  decoration: BoxDecoration( 
                                    shape: BoxShape.circle, 
                                    color: isSelected 
                                        ? primaryColor 
                                        : primaryColor.withValues(alpha: 0.08), 
                                    boxShadow: isSelected 
                                        ? [ 
                                            BoxShadow( 
                                              color: primaryColor.withValues(alpha: 0.25), 
                                              blurRadius: 14, 
                                              offset: const Offset(0, 8), 
                                            ) 
                                          ] 
                                        : null, 
                                  ), 
                                  child: Icon( 
                                    category['icon'] as IconData, 
                                    color: isSelected ? Colors.white : primaryColor, 
                                    size: 24, 
                                  ), 
                                ), 
                                const SizedBox(height: 8), 
                                Text( 
                                  category['label'] as String, 
                                  style: TextStyle( 
                                    fontSize: 11, 
                                    fontWeight: FontWeight.w800, 
                                    color: isSelected ? primaryColor : secondaryTextColor, 
                                    letterSpacing: 0.6, 
                                  ), 
                                ), 
                              ], 
                            ), 
                          ); 
                        }), 
                      ), 
                    ), 
                    const SizedBox(height: 15), 
                  ], 
                ), 
              ), 
            ), 

            SliverPadding( 
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10), 
sliver: SliverList(
  delegate: SliverChildBuilderDelegate(
    (context, index) {
      final hotel = hotels[index];
                    return Padding( 
                      padding: const EdgeInsets.only(bottom: 24), 
                      child: _buildVerticalHotelCard( 
                        imagePath: hotel['image']!, 
                        title: hotel['title']!, 
                        subtitle: hotel['subtitle']!, 
                        price: hotel['price']!, 
                        unit: hotel['unit']!, 
                        rating: hotel['rating']!, 
                        primaryColor: primaryColor, 
                        titleColor: darkTextColor, 
                        subColor: secondaryTextColor, 
                        cardColor: theme.cardColor,
                      ), 
                    ); 
                  }, 
                  childCount: hotels.length, 
                ), 
              ), 
            ), 
          ], 
        ), 
      ), 
      bottomNavigationBar: BymaBottomNav( 
        activeTab: _currentNavTab, 
        onTabSelected: (tab) { 
          if (tab == BymaBottomNavTab.home) { 
            Navigator.pushReplacement( 
              context, 
              MaterialPageRoute(builder: (_) => const MainLayoutScreen()), 
            ); 
            return; 
          } 

          if (tab == BymaBottomNavTab.bookings) { 
            Navigator.pushReplacement( 
              context, 
              MaterialPageRoute(builder: (_) => const BookingsScreen()), 
            ); 
            return; 
          } 

          if (tab == BymaBottomNavTab.chat) { 
            Navigator.pushReplacement( 
              context, 
              MaterialPageRoute(builder: (_) => const BymaChatScreen()), 
            ); 
            return; 
          } 

          if (tab == BymaBottomNavTab.profile) { 
            Navigator.pushReplacement( 
              context, 
              MaterialPageRoute(builder: (_) => const SettingsRefinedScreen()), 
            ); 
            return; 
          } 

          setState(() { 
            _currentNavTab = tab; 
          }); 
        }, 
      ), 
    ); 
  } 

  Widget _buildSearchSection({ 
    required IconData icon, 
    required String title, 
    required String subtitle, 
    required Color primaryColor, 
    required Color secondaryTextColor,
    required Color darkTextColor,
  }) { 
    return Padding( 
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0), 
      child: Row( 
        children: [ 
          Icon(icon, color: primaryColor, size: 22), 
          const SizedBox(width: 10), 
          Expanded( 
            child: Column( 
              crossAxisAlignment: CrossAxisAlignment.start, 
              mainAxisAlignment: MainAxisAlignment.center, 
              children: [ 
                Text( 
                  title, 
                  style: TextStyle( 
                    fontSize: 10, 
                    fontWeight: FontWeight.w900, 
                    color: secondaryTextColor, 
                    letterSpacing: 0.5, 
                  ), 
                ), 
                const SizedBox(height: 2), 
                Text( 
                  subtitle, 
                  style: TextStyle( 
                    fontSize: 14, 
                    fontWeight: FontWeight.w700, 
                    color: darkTextColor, 
                  ), 
                  maxLines: 1, 
                  overflow: TextOverflow.ellipsis, 
                ), 
              ], 
            ), 
          ), 
        ], 
      ), 
    ); 
  } 

  Widget _buildVerticalHotelCard({ 
    required String imagePath, 
    required String title, 
    required String subtitle, 
    required String price, 
    required String unit, 
    required String rating, 
    required Color primaryColor, 
    required Color titleColor, 
    required Color subColor, 
    required Color cardColor,
  }) { 
    final currency = 'currency'.tr();
    return Column( 
      crossAxisAlignment: CrossAxisAlignment.start, 
      children: [ 
        Container( 
          decoration: BoxDecoration( 
            borderRadius: BorderRadius.circular(26),  
            boxShadow: [ 
              BoxShadow( 
                color: Colors.black.withValues(alpha: 0.05),  
                blurRadius: 16, 
                offset: const Offset(0, 8),  
              ), 
            ], 
          ), 
          child: ClipRRect( 
            borderRadius: BorderRadius.circular(26), 
            child: Stack( 
              children: [ 
                SizedBox( 
                  height: 210, 
                  width: double.infinity, 
                  child: Image.asset( 
                    imagePath, 
                    fit: BoxFit.cover, 
                    errorBuilder: (context, error, stackTrace) { 
                      return Container( 
                        height: 210, 
                        width: double.infinity, 
                        color: cardColor, 
                        child: const Center( 
                          child: Icon( 
                            Icons.image_not_supported_outlined, 
                            size: 56, 
                            color: Colors.grey, 
                          ), 
                        ), 
                      ); 
                    }, 
                  ), 
                ), 
                Positioned( 
                  right: context.locale.languageCode == 'ar' ? null : 15, 
                  left: context.locale.languageCode == 'ar' ? 15 : null, 
                  top: 15, 
                  child: AnimatedBuilder( 
                    animation: FavoritesScope.of(context), 
                    builder: (context, _) { 
                      final isFav = FavoritesScope.of(context).isFavorite(title); 
                      return InkWell( 
                        borderRadius: BorderRadius.circular(999), 
                        onTap: () { 
                          FavoritesScope.of(context).toggleFavorite( 
                            FavoriteItem( 
                              id: title, 
                              title: title, 
                              subtitle: subtitle, 
                              rating: rating, 
                              fromText: '', 
                              price: '$currency$price', 
                              ctaText: '', 
                              imageAsset: '', 
                              compactBadge: null, 
                            ), 
                          ); 
                        }, 
                        child: Container( 
                          padding: const EdgeInsets.all(8), 
                          decoration: BoxDecoration( 
                            color: Colors.white.withValues(alpha: 0.75), 
                            shape: BoxShape.circle, 
                          ), 
                          child: Icon( 
                            isFav ? Icons.favorite_rounded : Icons.favorite_border, 
                            color: isFav ? const Color(0xFF0FA37A) : const Color(0xFF0F4A42), 
                            size: 20, 
                          ), 
                        ), 
                      ); 
                    }, 
                  ), 
                ), 
              ], 
            ), 
          ), 
        ), 
        const SizedBox(height: 16),  
        Row( 
          mainAxisAlignment: MainAxisAlignment.spaceBetween, 
          children: [ 
            Expanded( 
              child: Text( 
                title, 
                maxLines: 1, 
                overflow: TextOverflow.ellipsis, 
                style: TextStyle( 
                  fontSize: 19, 
                  fontWeight: FontWeight.w900, 
                  color: titleColor, 
                  letterSpacing: -0.2, 
                ), 
              ), 
            ), 
            Row( 
              children: [ 
                const Icon(Icons.star, color: Color(0xFFFFB300), size: 18), 
                const SizedBox(width: 4), 
                Text( 
                  rating, 
                  style: TextStyle( 
                    fontSize: 14, 
                    fontWeight: FontWeight.w800, 
                    color: titleColor, 
                  ), 
                ), 
              ], 
            ) 
          ], 
        ), 
        const SizedBox(height: 4), 
        Text( 
          subtitle, 
          style: TextStyle( 
            fontSize: 13, 
            color: subColor, 
            fontWeight: FontWeight.w600, 
          ), 
        ), 
        const SizedBox(height: 6), 
        RichText( 
          text: TextSpan( 
            children: [ 
              TextSpan( 
                text: '$currency$price', 
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: primaryColor), 
              ), 
              TextSpan( 
                text: ' $unit', 
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: subColor), 
              ), 
            ], 
          ), 
        ), 
      ], 
    ); 
  } 
}