import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

// 🌟 تأكد من استدعاء شاشات التفاصيل هنا بحسب مساراتها في مشروعك:
 import 'hotel_details_screen.dart';
// import 'room_detailes_screen.dart'; 

// كلاس البيانات الخاص بالعنصر المضاف داخل المجموعات
enum CollectionItemType { room, hotel }

class CollectionItem {
  final String id;
  final String nameEn;
  final String nameAr;
  final String imageUrl;
  final CollectionItemType type;

  CollectionItem({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.imageUrl,
    required this.type,
  });
}

// كلاس البيانات الخاص بالمجموعة نفسها
class CollectionModel {
  final String id;
  String name;
  final List<CollectionItem> items;

  CollectionModel({
    required this.id,
    required this.name,
    required this.items,
  });
}

// قائمة عالمية ثابتة لحفظ المجموعات في الذاكرة
final List<CollectionModel> globalCollections = [];

class Collection extends StatefulWidget {
  const Collection({super.key});

  @override
  State<Collection> createState() => _CollectionState();
}

class _CollectionState extends State<Collection> {
  
  void _showCreateCollectionDialog() {
    final theme = Theme.of(context);
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: theme.cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          context.tr('create_collection_title'),
          style: TextStyle(color: theme.colorScheme.secondary, fontWeight: FontWeight.bold),
        ),
        content: TextField(
          controller: controller,
          autofocus: true,
          style: TextStyle(color: theme.colorScheme.secondary),
          decoration: InputDecoration(
            hintText: context.tr('collection_hint'),
            hintStyle: TextStyle(color: theme.colorScheme.tertiary),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: theme.dividerColor)),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: theme.colorScheme.primary)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(context.tr('cancel_btn'), style: TextStyle(color: theme.colorScheme.tertiary)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                setState(() {
                  globalCollections.add(
                    CollectionModel(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      name: controller.text.trim(),
                      items: [],
                    ),
                  );
                });
                Navigator.pop(context);
              }
            },
            child: Text(context.tr('create_btn')),
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.primary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          context.tr('collections_appbar_title'),
          style: TextStyle(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w900,
            fontSize: 20,
          ),
        ),
      ),
      body: globalCollections.isEmpty
          ? Center(
              child: Text(
                context.tr('no_collections'),
                style: TextStyle(color: theme.colorScheme.tertiary, fontSize: 16),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 0.9,
              ),
              itemCount: globalCollections.length,
              itemBuilder: (context, index) {
                return _buildCollectionCard(globalCollections[index], theme);
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.colorScheme.primary,
        onPressed: _showCreateCollectionDialog,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildCollectionCard(CollectionModel collection, ThemeData theme) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CollectionDetailsScreen(collection: collection),
          ),
        ).then((_) => setState(() {})); 
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: theme.dividerColor, width: 1.2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: theme.dividerColor.withOpacity(0.5),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Icon(
                  Icons.folder_special_outlined,
                  size: 50,
                  color: theme.colorScheme.primary.withOpacity(0.7),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    collection.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${collection.items.length} ${context.tr('items_count_label')}',
                    style: TextStyle(
                      fontSize: 13,
                      color: theme.colorScheme.tertiary,
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

// شاشة تفاصيل المجموعة التي تعرض الغرف والفنادق بسكرول عرضي
class CollectionDetailsScreen extends StatelessWidget {
  final CollectionModel collection;

  const CollectionDetailsScreen({super.key, required this.collection});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isArabic = context.locale.languageCode == 'ar';

    final rooms = collection.items.where((item) => item.type == CollectionItemType.room).toList();
    final hotels = collection.items.where((item) => item.type == CollectionItemType.hotel).toList();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          collection.name,
          style: TextStyle(color: theme.colorScheme.secondary, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.primary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: collection.items.isEmpty
          ? Center(
              child: Text(
                context.tr('no_items_in_collection'), 
                style: TextStyle(color: theme.colorScheme.tertiary, fontSize: 16),
              ),
            )
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (rooms.isNotEmpty) ...[
                    _buildSectionHeader(context, theme, context.tr('rooms_section_title')), 
                    SizedBox(
                      height: 220,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: rooms.length,
                        itemBuilder: (context, index) {
                          final item = rooms[index];
                          return _buildHorizontalCard(context, item, theme, isArabic);
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],

                  if (hotels.isNotEmpty) ...[
                    _buildSectionHeader(context, theme, context.tr('hotels_section_title')), 
                    SizedBox(
                      height: 220,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: hotels.length,
                        itemBuilder: (context, index) {
                          final item = hotels[index];
                          return _buildHorizontalCard(context, item, theme, isArabic);
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ],
              ),
            ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, ThemeData theme, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Text(
        title,
        style: TextStyle(
          color: theme.colorScheme.secondary,
          fontSize: 18,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _buildHorizontalCard(BuildContext context, CollectionItem item, ThemeData theme, bool isArabic) {
    final displayName = isArabic ? item.nameAr : item.nameEn;

    return Container(
      width: 180,
      margin: const EdgeInsetsDirectional.only(end: 14),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor, width: 1),
      ),
      child: InkWell(
        // 🌟 تم تعديل الـ onTap هنا للانتقال للشاشات المخصصة بناءً على نوع الكرت
        onTap: () {
          if (item.type == CollectionItemType.hotel) {
            // الانتقال لشاشة تفاصيل الفندق (مرر متغيرات الـ Constructor التي تستخدمها شاشتك)
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (_) => HotelDetailsScreen(
            //       title: displayName,
            //       imageUrl: item.imageUrl,
            //     ),
            //   ),
            // );
          } else if (item.type == CollectionItemType.room) {
            // الانتقال لشاشة تفاصيل الغرفة (مرر متغيرات الـ Constructor المكتوبة داخل الكلاس الخاص بك)
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (_) => RoomDetailsScreen(
            //       title: displayName,
            //       imageUrl: item.imageUrl,
            //     ),
            //   ),
            // );
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: Image.network(
                    item.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: theme.dividerColor.withOpacity(0.4),
                      child: Icon(Icons.image_not_supported_outlined, color: theme.colorScheme.tertiary),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  displayName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: theme.colorScheme.secondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}