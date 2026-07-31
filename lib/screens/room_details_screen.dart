import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'payment_screen.dart';
import 'conversation_screen.dart'; 

import 'collection.dart'; // 🌟 استدعاء ملف المجموعات لربط البيانات بشكل121e متطابق

class RoomDetailsScreen extends StatelessWidget {
  final String roomTitle;
  final String pricePerNight;

  const RoomDetailsScreen({
    super.key,
    required this.roomTitle,
    required this.pricePerNight, required String id,
  }); 

  // 🌟 دالة إظهار القائمة المنبثقة التفاعلية المحدثة والمطابقة تماماً لشاشة الفندق لإنشاء واختيار المجموعات
  void _showAddToCollectionSheet(BuildContext context) {
    final theme = Theme.of(context);
    final TextEditingController newCollectionController = TextEditingController();

    showModalBottomSheet(
      context: context,
      backgroundColor: theme.cardColor,
      isScrollControlled: true, // تفعيل الارتفاع الديناميكي لتجنب تغطية الكيبورد للعناصر
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              // دفع العناصر لأعلى بحسب ارتفاع الكيبورد المفتوح
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

                  // 🌟 قسم إنشاء مجموعة جديدة وإضافة الغرفة الحالية إليها مباشرة 🌟
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
                              
                              // ربط وإضافة الغرفة الحالية تلقائياً بداخلها (تم تحديد النوع كـ room)
                              newCol.items.add(CollectionItem(
                                id: roomTitle,
                                nameEn: roomTitle,
                                nameAr: roomTitle,
                                imageUrl: '', // يمكنك تمرير رابط الصورة هنا إذا كان متاحاً
                                type: CollectionItemType.room,
                              ));

                              // إضافة الكولكشن الجديد للقائمة العامة المشتركة
                              globalCollections.add(newCol);
                              
                              newCollectionController.clear();
                              FocusScope.of(context).unfocus(); // إغلاق لوحة المفاتيح
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('تم إنشاء مجموعة "$name" وحفظ الغرفة فيها')),
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
                          final isAdded = collection.items.any((item) => item.id == roomTitle);

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
                                    id: roomTitle,
                                    nameEn: roomTitle,
                                    nameAr: roomTitle,
                                    imageUrl: '',
                                    type: CollectionItemType.room,
                                  ));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('${context.tr('added_to')} ${collection.name}')),
                                  );
                                } else {
                                  collection.items.removeWhere((item) => item.id == roomTitle);
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
    final isDarkMode = theme.brightness == Brightness.dark;
    final isHighContrast = theme.colorScheme.primary == Colors.yellow;

    final Color dynamicTeal = isHighContrast 
        ? Colors.yellow 
        : (isDarkMode ? const Color(0xFF0FA37A) : const Color(0xFF0E6F63));
        
    final Color dynamicTeal2 = isHighContrast 
        ? Colors.yellowAccent 
        : const Color(0xFF0FA37A);

    final Color textColor = isHighContrast 
        ? Colors.white 
        : (isDarkMode ? Colors.white : Colors.black87);

    final Color subTextColor = isHighContrast 
        ? Colors.white70 
        : (isDarkMode ? Colors.white60 : Colors.black54);

    final Color scaffoldBg = theme.scaffoldBackgroundColor;
    final Color cardBg = theme.cardColor;
    final Color borderAndDivider = theme.dividerColor;

    // إعداد كائن البيانات الخاص بالمفضلة التقليدية (لزر القلب)
    // final currentRoomItem = FavoriteItem(
    //   id: roomTitle,
    //   title: roomTitle,
    //   subtitle: 'room_details_title'.tr(),
    //   rating: '4.9',
    //   fromText: '',
    //   price: '\$${pricePerNight.replaceAll(RegExp(r'[^0-9.]'), '')}/${'per_night_short'.tr()}',
    //   ctaText: '',
    //   imageAsset: '',
    //   compactBadge: null,
    // );

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: theme.colorScheme.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'room_details_title'.tr(),
          style: TextStyle(fontWeight: FontWeight.w900, color: theme.colorScheme.primary),
        ),
        centerTitle: false,
        actions: [
          // 1. 🌟 زر الـ (+) المحدث ليقوم بفتح القائمة المنبثقة التفاعلية وحفظ الغرفة الحالية في المجموعات
          IconButton(
            onPressed: () => _showAddToCollectionSheet(context),
            icon: Icon(
              Icons.add_rounded,
              size: 24,
              color: theme.iconTheme.color?.withOpacity(0.8),
            ),
          ),
          // 2. زر المفضلة الديناميكي التقليدي
          // AnimatedBuilder(
          //   animation: FavoritesScope.of(context),
          //   builder: (context, _) {
          //     final store = FavoritesScope.of(context);
          //     final isFav = store.isFavorite(roomTitle);
          //     return IconButton(
          //       onPressed: () => store.toggleFavorite(currentRoomItem),
          //       icon: Icon(
          //         isFav ? Icons.favorite_rounded : Icons.favorite_border,
          //         color: isFav ? (isHighContrast ? Colors.yellow : dynamicTeal) : theme.colorScheme.primary,
          //       ),
          //     );
          //   },
          // ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 10, 18, 24),
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: AspectRatio(
                aspectRatio: 16 / 10,
                child: Stack(
                  children: [
                    Container(
                      color: isDarkMode ? Colors.white10 : Colors.black12,
                      child: Center(
                        child: Icon(Icons.hotel, size: 72, color: subTextColor.withOpacity(0.3)),
                      ),
                    ),
                    Positioned(
                      left: 10,
                      top: 90,
                      child: const _CircleArrow(icon: Icons.chevron_left),
                    ),
                    Positioned(
                      right: 10,
                      top: 90,
                      child: const _CircleArrow(icon: Icons.chevron_right),
                    ),
                    Positioned(
                      right: 14,
                      bottom: 14,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(999),
                          border: isHighContrast ? Border.all(color: Colors.white) : null,
                        ),
                        child: Text(
                          'photos_count'.tr(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    color: isHighContrast 
                        ? Colors.black 
                        : (isDarkMode ? const Color(0xFF0FA37A).withOpacity(0.15) : const Color(0xFF2FE3CF).withOpacity(0.18)),
                    border: Border.all(color: dynamicTeal.withOpacity(0.5), width: 1),
                  ),
                  child: Text(
                    'premium_experience_tag'.tr(),
                    style: TextStyle(
                      color: dynamicTeal,
                      fontWeight: FontWeight.w900,
                      fontSize: 11,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              roomTitle,
              style: TextStyle(
                fontSize: 28,
                height: 1.08,
                fontWeight: FontWeight.w900,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  pricePerNight,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 28,
                    color: dynamicTeal2,
                  ),
                ),
                const Spacer(),
                Text(
                  'per_night_label'.tr(),
                  style: TextStyle(color: subTextColor, fontWeight: FontWeight.w800, fontSize: 11),
                )
              ],
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: borderAndDivider, width: 1.2),
              ),
              child: Row(
                children: [
                  _InfoChip(icon: Icons.person, text: 'guests_count_chip'.tr(), iconColor: dynamicTeal),
                  const SizedBox(width: 10),
                  _InfoChip(icon: Icons.square_foot, text: 'room_size_chip'.tr(), iconColor: dynamicTeal),
                  const SizedBox(width: 10),
                  _InfoChip(icon: Icons.king_bed, text: 'bed_type_chip'.tr(), iconColor: dynamicTeal),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: borderAndDivider, width: 1.2),
              ),
              child: Text(
                'room_description_text'.tr(),
                style: TextStyle(
                  color: textColor.withOpacity(0.9),
                  height: 1.55,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _SectionHeader(title: 'services_features_title'.tr(), teal: dynamicTeal),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _ServiceTile(
                    icon: Icons.bathtub_outlined,
                    title: 'service_balcony_title'.tr(),
                    subtitle: 'service_balcony_sub'.tr(),
                    tealColor: dynamicTeal2,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _ServiceTile(
                    icon: Icons.wifi,
                    title: 'service_smart_title'.tr(),
                    subtitle: 'service_smart_sub'.tr(),
                    tealColor: dynamicTeal2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _SectionHeader(title: 'special_requests_title'.tr(), teal: dynamicTeal),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: dynamicTeal2.withOpacity(0.5), width: 1.2),
                color: isHighContrast ? Colors.black : dynamicTeal2.withOpacity(0.06),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: dynamicTeal,
                        radius: 24,
                        child: Icon(Icons.info, color: isHighContrast ? Colors.black : Colors.white),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          'special_requests_info'.tr(),
                          style: TextStyle(
                            color: textColor.withOpacity(0.9),
                            height: 1.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 52,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ConversationScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: dynamicTeal,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                        side: isHighContrast ? const BorderSide(color: Colors.white, width: 1.5) : null,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'contact_support_btn'.tr(),
                            style: TextStyle(
                              fontWeight: FontWeight.w900, 
                              fontSize: 14, 
                              color: isHighContrast ? Colors.black : Colors.white,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Icon(
                            Icons.chat_bubble_outline_rounded, 
                            color: isHighContrast ? Colors.black : Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 26),
            SizedBox(
              height: 54,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FinalizeReservationScreen(
                        roomTitle: roomTitle,
                        pricePerNight: pricePerNight,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isHighContrast 
                      ? Colors.yellow 
                      : (isDarkMode ? const Color(0xFF2E97C9) : Colors.lightBlueAccent.withOpacity(0.75)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                  side: isHighContrast ? const BorderSide(color: Colors.white, width: 1.5) : null,
                ),
                child: Text(
                  'reserve_room_btn'.tr(),
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                    color: isHighContrast ? Colors.black : Colors.white,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CircleArrow extends StatelessWidget {
  final IconData icon;
  const _CircleArrow({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.25),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.white),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  
  const _InfoChip({
    required this.icon, 
    required this.text,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.white10 : Colors.black12,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16, color: iconColor),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: theme.colorScheme.primary,
                  fontSize: 12.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final Color teal;

  const _SectionHeader({
    required this.title,
    required this.teal,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 16,
            color: teal,
          ),
        ),
        const Spacer(),
        Container(
          width: 54,
          height: 10,
          decoration: BoxDecoration(
            color: teal.withOpacity(0.14),
            borderRadius: BorderRadius.circular(999),
          ),
        )
      ],
    );
  }
}

class _ServiceTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color tealColor;

  const _ServiceTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.tealColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: tealColor.withOpacity(0.22),
          width: 1.2,
        ),
        color: theme.cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: tealColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              color: tealColor,
              size: 22,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 14.5,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: theme.colorScheme.secondary,
              height: 1.35,
              fontWeight: FontWeight.w600,
              fontSize: 12.5,
            ),
          ),
        ],
      ),
    );
  }
}