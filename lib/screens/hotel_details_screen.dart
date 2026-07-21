import 'package:byma_app/screens/room_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../business_logic/hotel_details_cubit/hotel_details_cubit.dart';
import '../business_logic/hotel_details_cubit/hotel_details_state.dart';
import '../state/favorites_scope.dart';
import '../state/favorites_store.dart';
import 'reserve_your_stay_screen.dart'; 
import 'conversation_screen.dart';     
import 'recently_viewed.dart';        
import 'collection.dart';             

class HotelDetailsScreen extends StatelessWidget {
  final String id; 
  final String title;     
  final String imageUrl;  

  const HotelDetailsScreen({
    super.key,
    required this.id,
    this.title = '',      
    this.imageUrl = '',   
  });

  void _showAddToCollectionSheet(BuildContext context, String hotelTitle, String hotelImageUrl) {
    final theme = Theme.of(context);
    final TextEditingController newCollectionController = TextEditingController();

    showModalBottomSheet(
      context: context,
      backgroundColor: theme.cardColor,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.tr('save_to_collection_sheet_title'),
                    style: TextStyle(
                      color: theme.colorScheme.secondary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),

                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: newCollectionController,
                          decoration: InputDecoration(
                            hintText: 'اسم المجموعة الجديدة...',
                            hintStyle: TextStyle(color: theme.colorScheme.tertiary.withOpacity(0.6), fontSize: 14),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: theme.colorScheme.tertiary.withOpacity(0.3)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: theme.colorScheme.tertiary.withOpacity(0.3)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.primaryColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                        ),
                        onPressed: () {
                          final name = newCollectionController.text.trim();
                          if (name.isNotEmpty) {
                            setModalState(() {
                              final newCol = CollectionModel(
                                id: DateTime.now().millisecondsSinceEpoch.toString(),
                                name: name,
                                items: List<CollectionItem>.from([]),
                              );
                              
                              newCol.items.add(CollectionItem(
                                id: hotelTitle,
                                nameEn: hotelTitle,
                                nameAr: hotelTitle,
                                imageUrl: hotelImageUrl,
                                type: CollectionItemType.hotel,
                              ));

                              globalCollections.add(newCol);
                              newCollectionController.clear();
                              FocusScope.of(context).unfocus();
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('تم إنشاء مجموعة "$name" وحفظ الفندق فيها')),
                            );
                          }
                        },
                        child: const Icon(Icons.add, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 10),

                  if (globalCollections.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: Text(
                          context.tr('no_collections'),
                          style: TextStyle(color: theme.colorScheme.tertiary),
                        ),
                      ),
                    )
                  else
                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: globalCollections.length,
                        itemBuilder: (context, index) {
                          final collection = globalCollections[index];
                          final isAdded = collection.items.any((item) => item.id == hotelTitle);

                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(
                              isAdded ? Icons.folder_special : Icons.folder_special_outlined,
                              color: theme.colorScheme.primary,
                            ),
                            title: Text(
                              collection.name,
                              style: TextStyle(color: theme.colorScheme.secondary, fontWeight: FontWeight.w600),
                            ),
                            trailing: Icon(
                              isAdded ? Icons.check_circle : Icons.add_circle_outline,
                              color: isAdded ? Colors.green : theme.colorScheme.tertiary,
                            ),
                            onTap: () {
                              setModalState(() {
                                if (!isAdded) {
                                  collection.items.add(CollectionItem(
                                    id: hotelTitle,
                                    nameEn: hotelTitle,
                                    nameAr: hotelTitle,
                                    imageUrl: hotelImageUrl,
                                    type: CollectionItemType.hotel,
                                  ));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('${context.tr('added_to')} ${collection.name}')),
                                  );
                                } else {
                                  collection.items.removeWhere((item) => item.id == hotelTitle);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('${context.tr('removed_from')} ${collection.name}')),
                                  );
                                }
                              });
                            },
                          );
                        },
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isHighContrast = theme.colorScheme.primary == Colors.yellow;
    
    final primaryTeal = theme.colorScheme.primary;
    final secondaryTeal = theme.colorScheme.secondary;
    final cardBgColor = theme.cardColor;

    return BlocBuilder<HotelDetailsCubit, HotelDetailsState>(
      builder: (context, state) {
        if (state is HotelDetailsLoading) {
          return Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            body: const Center(child: CircularProgressIndicator(color: Colors.teal)),
          );
        }

        if (state is HotelDetailsError) {
          return Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            appBar: AppBar(
              elevation: 0, 
              backgroundColor: Colors.transparent, 
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_new, color: theme.iconTheme.color, size: 20), 
                onPressed: () => Navigator.pop(context)
              )
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, color: Colors.red, size: 60),
                    const SizedBox(height: 16),
                    Text(state.message, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, color: Colors.red)),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context.read<HotelDetailsCubit>().getHotelDetails(id),
                      child: const Text('إعادة المحاولة'),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        if (state is HotelDetailsLoaded) {
          final hotel = state.hotel;
          final mainImage = hotel.imageUrls.isNotEmpty ? hotel.imageUrls.first : imageUrl;

          return Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            appBar: AppBar(
              backgroundColor: theme.appBarTheme.backgroundColor ?? theme.scaffoldBackgroundColor,
              elevation: 0,
              automaticallyImplyLeading: false,
              leading: Padding(
                padding: const EdgeInsets.only(left: 6),
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios_new, color: theme.iconTheme.color, size: 20),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              title: Text(
                context.tr('hotelDetails'),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: 16.5,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () => _showAddToCollectionSheet(context, hotel.title, mainImage),
                  icon: Icon(
                    Icons.add_rounded,
                    size: 24,
                    color: theme.iconTheme.color?.withOpacity(0.8),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 14),
                  child: AnimatedBuilder(
                    animation: FavoritesScope.of(context),
                    builder: (context, _) {
                      final store = FavoritesScope.of(context);
                      final isFav = store.isFavorite(hotel.title);
                      return IconButton(
                        onPressed: () {
                          store.toggleFavorite(
                            FavoriteItem(
                              id: hotel.title,
                              title: hotel.title,
                              subtitle: 'hotel_label'.tr(),
                              rating: hotel.rating,
                              fromText: 'from'.tr(),
                              price: '\$220',
                              ctaText: 'view_deal'.tr(),
                              imageAsset: mainImage,
                              compactBadge: null,
                            ),
                          );
                        },
                        icon: Icon(
                          isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                          size: 22,
                          color: isFav ? secondaryTeal : theme.iconTheme.color?.withOpacity(0.6),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            body: SafeArea(
              child: Stack(
                children: [
                  ListView(
                    padding: const EdgeInsets.fromLTRB(16, 10, 16, 120),
                    children: [
                      _HeroImage(secondaryTeal: secondaryTeal, imageUrls: hotel.imageUrls),
                      const SizedBox(height: 16),
                      _RatingsRow(secondaryTeal: secondaryTeal, title: hotel.title, rating: hotel.rating, location: hotel.location),
                      const SizedBox(height: 20),

                      _UnderlineTitle(titleKey: 'premiumAmenities', color: secondaryTeal),
                      const SizedBox(height: 12),
                      
                      // 🌟 إرجاع الميزات الثابتة كما كانت لتجنب خطأ الـ null map
                      _AmenitiesGrid(
                        teal: primaryTeal,
                        items: const [
                          _Amen(icon: Icons.wifi, labelKey: 'ultraFastWifi'),
                          _Amen(icon: Icons.waves_outlined, labelKey: 'swimmingPool'),
                          _Amen(icon: Icons.restaurant_outlined, labelKey: 'topChef'),
                          _Amen(icon: Icons.ac_unit_outlined, labelKey: 'airConditioning'),
                        ],
                      ),
                      const SizedBox(height: 24),

                      _UnderlineTitle(titleKey: 'locationTitle', color: secondaryTeal),
                      const SizedBox(height: 12),
                      _LocationCard(secondaryTeal: secondaryTeal),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            backgroundColor: theme.canvasColor,
                            foregroundColor: secondaryTeal,
                            side: BorderSide(color: secondaryTeal.withOpacity(0.25)),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.open_in_new_rounded, size: 18),
                              const SizedBox(width: 10),
                              Text(
                                context.tr('openInMaps'),
                                style: theme.textTheme.labelLarge?.copyWith(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 12,
                                  letterSpacing: 0.6,
                                  color: secondaryTeal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      _UnderlineTitle(titleKey: 'Rooms', color: secondaryTeal),
                      const SizedBox(height: 14),
                      
                      // 🌟 جلب الغرف بشكل ديناميكي آمن مع إضافة حماية ?? []
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: (hotel.rooms ?? []).length,
                        itemBuilder: (context, index) {
                          final room = hotel.rooms[index];
                          return _RoomCard(
                            roomTitle: room.title ?? '',
                            pricePerNight: '\$${room.price ?? 0}',
                            roomImage: room.imageUrl ?? '',
                            secondaryTeal: secondaryTeal,
                            hotelName: hotel.title,
                          );
                        },
                      ),
                    ],
                  ),

                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                          decoration: BoxDecoration(
                            color: cardBgColor,
                            borderRadius: BorderRadius.circular(40),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 16,
                                offset: const Offset(0, 6),
                              ),
                            ],
                            border: isHighContrast ? Border.all(color: Colors.white, width: 1.5) : null,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 54,
                                height: 54,
                                decoration: BoxDecoration(
                                  color: isHighContrast ? Colors.yellow : const Color(0xFF006653),
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) => const ConversationScreen()),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.chat_bubble_outline_rounded,
                                    color: isHighContrast ? Colors.black : Colors.white,
                                    size: 21,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 14),
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
                                      backgroundColor: isHighContrast ? Colors.black : const Color(0xFF63D3FF),
                                      foregroundColor: isHighContrast ? Colors.yellow : const Color(0xFF231F20),
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      side: isHighContrast ? const BorderSide(color: Colors.yellow, width: 1.5) : null,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.tune_rounded, size: 20),
                                        const SizedBox(width: 8),
                                        Text(
                                          context.tr('filter_options'),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 14,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                      ],
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
                ],
              ),
            ),
          );
        }

        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          body: const Center(child: Text('جاري تهيئة البيانات...')),
        );
      },
    );
  }
}

class _RoomCard extends StatelessWidget {
  final String roomTitle;
  final String pricePerNight;
  final String roomImage;
  final Color secondaryTeal;
  final String hotelName;

  const _RoomCard({
    required this.roomTitle,
    required this.pricePerNight,
    required this.roomImage,
    required this.secondaryTeal,
    required this.hotelName,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double parsedPrice = double.tryParse(pricePerNight.replaceAll(RegExp(r'[^\d.]'), '')) ?? 0.0;
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: theme.dividerColor.withOpacity(0.4)),
      ),
      color: theme.cardColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () {
          addRecentlyViewedItem(RecentlyViewedItem(
            id: 'room:$roomTitle',
            nameEn: roomTitle,
            nameAr: roomTitle,
            locationEn: hotelName,
            locationAr: hotelName,
            imageUrl: roomImage,
            price: parsedPrice,
            type: RecentlyItemType.room,
          ));

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => RoomDetailsScreen(
                roomTitle: roomTitle,
                pricePerNight: pricePerNight, id: '',
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  roomImage,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 100,
                    height: 100,
                    color: theme.disabledColor.withOpacity(0.1),
                    child: const Icon(Icons.king_bed_outlined),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      roomTitle,
                      style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          textBaseline: TextBaseline.alphabetic,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: [
                            Text(pricePerNight, style: TextStyle(fontWeight: FontWeight.w900, color: secondaryTeal, fontSize: 17)),
                            Text(' /${context.tr('night')}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios_rounded, size: 14, color: secondaryTeal),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroImage extends StatefulWidget {
  final List<String> imageUrls;
  final Color secondaryTeal;

  const _HeroImage({required this.imageUrls, required this.secondaryTeal});

  @override
  State<_HeroImage> createState() => _HeroImageState();
}

class _HeroImageState extends State<_HeroImage> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    if (widget.imageUrls.isEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(26),
        child: Container(
          height: 235,
          color: theme.disabledColor.withOpacity(0.1),
          child: const Center(child: Icon(Icons.image_not_supported_outlined, size: 40)),
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(26),
      child: Container(
        height: 235,
        decoration: BoxDecoration(border: Border.all(color: theme.dividerColor, width: 0.8)),
        child: Stack(
          children: [
            Positioned.fill(
              child: PageView.builder(
                itemCount: widget.imageUrls.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Image.network(
                    widget.imageUrls[index],
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Center(child: Icon(Icons.image_not_supported_outlined, size: 40)),
                  );
                },
              ),
            ),
            Positioned(
              left: 16,
              bottom: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.4), borderRadius: BorderRadius.circular(999)),
                child: Text(
                  '${_currentPage + 1} / ${widget.imageUrls.length}',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RatingsRow extends StatelessWidget {
  final Color secondaryTeal;
  final String title;
  final String rating;
  final String location;

  const _RatingsRow({
    required this.secondaryTeal,
    required this.title,
    required this.rating,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, letterSpacing: -0.5)),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.star, size: 18, color: secondaryTeal),
            const SizedBox(width: 6),
            Text(rating, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15)),
            const SizedBox(width: 12),
            Icon(Icons.location_on_outlined, size: 18, color: secondaryTeal),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                location,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12.5, height: 1.05),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _UnderlineTitle extends StatelessWidget {
  final String titleKey;
  final Color color;
  const _UnderlineTitle({required this.titleKey, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.remove_circle_outline, color: color, size: 18),
            const SizedBox(width: 10),
            Text(context.tr(titleKey), style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
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
    final theme = Theme.of(context);
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 2.2,
      ),
      itemBuilder: (context, i) {
        final item = items[i];
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(color: theme.cardColor, borderRadius: BorderRadius.circular(18), border: Border.all(color: theme.dividerColor)),
          child: Row(
            children: [
              Icon(item.icon, size: 22, color: teal),
              const SizedBox(width: 10),
              Expanded(child: Text(context.tr(item.labelKey).toUpperCase(), style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 10, letterSpacing: 0.3))),
            ],
          ),
        );
      },
    );
  }
}

class _Amen {
  final IconData icon;
  final String labelKey;
  const _Amen({required this.icon, required this.labelKey});
}

class _LocationCard extends StatelessWidget {
  final Color secondaryTeal;
  const _LocationCard({required this.secondaryTeal});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 140,
      decoration: BoxDecoration(color: theme.cardColor, borderRadius: BorderRadius.circular(22), border: Border.all(color: theme.dividerColor)),
      child: Center(
        child: Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(color: secondaryTeal, shape: BoxShape.circle, boxShadow: [BoxShadow(color: secondaryTeal.withOpacity(0.35), blurRadius: 14, offset: const Offset(0, 8))]),
          child: const Icon(Icons.location_on, color: Colors.white, size: 22),
        ),
      ),
    );
  }
}