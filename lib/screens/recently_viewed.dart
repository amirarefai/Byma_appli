// import 'package:flutter/material.dart';
// import 'package:easy_localization/easy_localization.dart';

// // 1. كلاس البيانات الخاص بالعنصر
// enum RecentlyItemType { room, hotel }

// class RecentlyViewedItem {
//   final String id;
//   final String nameEn;
//   final String nameAr;
//   final String locationEn;
//   final String locationAr;
//   final String imageUrl;
//   final double price;
//   final RecentlyItemType type;

//   RecentlyViewedItem({
//     required this.id,
//     required this.nameEn,
//     required this.nameAr,
//     required this.locationEn,
//     required this.locationAr,
//     required this.imageUrl,
//     required this.price,
//     required this.type,
//   });
// }

// // 2. قائمة عالمية ثابتة لحفظ آخر 10 عناصر تم النقر عليها (مؤقتاً في الذاكرة)
// final List<RecentlyViewedItem> globalRecentlyViewedList = [];

// // دالة لاستدعائها عند الضغط على أي فندق أو غرفة لإضافته للقائمة
// void addRecentlyViewedItem(RecentlyViewedItem item) {
//   globalRecentlyViewedList.removeWhere((element) => element.id == item.id);
//   globalRecentlyViewedList.insert(0, item);
//   if (globalRecentlyViewedList.length > 10) {
//     globalRecentlyViewedList.removeLast();
//   }
// }

// // 3. واجهة الشاشة
// class RecentlyViewed extends StatelessWidget {
//   const RecentlyViewed({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isAr = context.locale.languageCode == 'ar';

//     // تصفية القائمة إلى غرف وفنادق
//     final roomsList = globalRecentlyViewedList.where((i) => i.type == RecentlyItemType.room).toList();
//     final hotelsList = globalRecentlyViewedList.where((i) => i.type == RecentlyItemType.hotel).toList();

//     return Scaffold(
//       backgroundColor: theme.scaffoldBackgroundColor,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         centerTitle: false,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: theme.colorScheme.primary),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         title: Text(
//           context.tr('recently_viewed_title'),
//           style: TextStyle(
//             color: theme.colorScheme.primary,
//             fontWeight: FontWeight.w900,
//             fontSize: 20,
//           ),
//         ),
//       ),
//       body: (roomsList.isEmpty && hotelsList.isEmpty)
//           ? Center(
//               child: Text(
//                 context.tr('no_recently_viewed'),
//                 style: TextStyle(color: theme.colorScheme.tertiary, fontSize: 16),
//               ),
//             )
//           : SingleChildScrollView(
//               padding: const EdgeInsets.symmetric(vertical: 16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // قسم الغرف (سكرول عرضي)
//                   if (roomsList.isNotEmpty) ...[
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 20),
//                       child: Text(
//                         context.tr('rooms_section_title'),
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: theme.colorScheme.secondary,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     SizedBox(
//                       height: 250,
//                       child: ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         padding: const EdgeInsets.symmetric(horizontal: 16),
//                         itemCount: roomsList.length,
//                         itemBuilder: (context, index) {
//                           return _buildItemCard(roomsList[index], theme, isAr, context);
//                         },
//                       ),
//                     ),
//                     const SizedBox(height: 24),
//                   ],

//                   // قسم الفنادق (سكرول عرضي)
//                   if (hotelsList.isNotEmpty) ...[
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 20),
//                       child: Text(
//                         context.tr('hotels_section_title'),
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: theme.colorScheme.secondary,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     SizedBox(
//                       height: 250,
//                       child: ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         padding: const EdgeInsets.symmetric(horizontal: 16),
//                         itemCount: hotelsList.length,
//                         itemBuilder: (context, index) {
//                           return _buildItemCard(hotelsList[index], theme, isAr, context);
//                         },
//                       ),
//                     ),
//                   ],
//                 ],
//               ),
//             ),
//     );
//   }

//   Widget _buildItemCard(RecentlyViewedItem item, ThemeData theme, bool isAr, BuildContext context) {
//     return Container(
//       width: 200,
//       margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
//       decoration: BoxDecoration(
//         color: theme.cardColor,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: theme.dividerColor, width: 1.2),
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               child: Container(
//                 width: double.infinity,
//                 color: theme.dividerColor,
//                 child: Image.network(
//                   item.imageUrl,
//                   fit: BoxFit.cover,
//                   errorBuilder: (context, error, stackTrace) =>
//                       Icon(Icons.image, color: theme.colorScheme.tertiary),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(12),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     isAr ? item.nameAr : item.nameEn,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 15,
//                       color: theme.colorScheme.secondary,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Row(
//                     children: [
//                       Icon(Icons.location_on_outlined, size: 14, color: theme.colorScheme.tertiary),
//                       const SizedBox(width: 4),
//                       Expanded(
//                         child: Text(
//                           isAr ? item.locationAr : item.locationEn,
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(fontSize: 12, color: theme.colorScheme.tertiary),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     '\$${item.price.toStringAsFixed(0)} / ${context.tr('night_label')}',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 14,
//                       color: theme.colorScheme.primary,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

// 1. كلاس البيانات الخاص بالعنصر
enum RecentlyItemType { room, hotel }

class RecentlyViewedItem {
  final String id;
  final String nameEn;
  final String nameAr;
  final String locationEn;
  final String locationAr;
  final String imageUrl;
  final double price;
  final RecentlyItemType type;

  RecentlyViewedItem({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.locationEn,
    required this.locationAr,
    required this.imageUrl,
    required this.price,
    required this.type,
  });
}

// 2. قائمة عالمية ثابتة لحفظ آخر 10 عناصر تم النقر عليها (مؤقتاً في الذاكرة)
final List<RecentlyViewedItem> globalRecentlyViewedList = [];

// دالة لاستدعائها عند الضغط على أي فندق أو غرفة لإضافته للقائمة
void addRecentlyViewedItem(RecentlyViewedItem item) {
  globalRecentlyViewedList.removeWhere((element) => element.id == item.id);
  globalRecentlyViewedList.insert(0, item);
  if (globalRecentlyViewedList.length > 10) {
    globalRecentlyViewedList.removeLast();
  }
}

// 3. واجهة الشاشة
class RecentlyViewed extends StatelessWidget {
  const RecentlyViewed({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isAr = context.locale.languageCode == 'ar';

    // تصفية القائمة إلى غرف وفنادق
    final roomsList = globalRecentlyViewedList.where((i) => i.type == RecentlyItemType.room).toList();
    final hotelsList = globalRecentlyViewedList.where((i) => i.type == RecentlyItemType.hotel).toList();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.primary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          context.tr('recently_viewed_title'),
          style: TextStyle(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w900,
            fontSize: 20,
          ),
        ),
      ),
      body: (roomsList.isEmpty && hotelsList.isEmpty)
          ? Center(
              child: Text(
                context.tr('no_recently_viewed'),
                style: TextStyle(color: theme.colorScheme.tertiary, fontSize: 16),
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // قسم الغرف (سكرول عرضي)
                  if (roomsList.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        context.tr('rooms_section_title'),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.secondary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 250,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: roomsList.length,
                        itemBuilder: (context, index) {
                          return _buildItemCard(roomsList[index], theme, isAr, context);
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // قسم الفنادق (سكرول عرضي)
                  if (hotelsList.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        context.tr('hotels_section_title'),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.secondary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 250,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: hotelsList.length,
                        itemBuilder: (context, index) {
                          return _buildItemCard(hotelsList[index], theme, isAr, context);
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ),
    );
  }

  Widget _buildItemCard(RecentlyViewedItem item, ThemeData theme, bool isAr, BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor, width: 1.2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                color: theme.dividerColor,
                child: Image.network(
                  item.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.image, color: theme.colorScheme.tertiary),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isAr ? item.nameAr : item.nameEn,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, size: 14, color: theme.colorScheme.tertiary),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          isAr ? item.locationAr : item.locationEn,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12, color: theme.colorScheme.tertiary),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${item.price.toStringAsFixed(0)} / ${context.tr('night_label')}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}