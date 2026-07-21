class HotelModel {
  final String id;
  final String title; 
  final String location; 
  final String rating;
  final List<String> imageUrls;

  HotelModel({
    required this.id,
    required this.title,
    required this.location,
    required this.rating,
    required this.imageUrls,
  });

  factory HotelModel.fromJson(Map<String, dynamic> json) {
    // الرابط الأساسي للسيرفر لإضافته قبل مسارات الصور الناقصة
    const String baseUrl = 'https://maybe-puzzling-citation.ngrok-free.dev';

    // قراءة قائمة الصور الخام (photos) وتحويلها مع إضافة رابط الـ domain
    List<String> formattedImages = [];
    if (json['photos'] != null) {
      formattedImages = List<String>.from(json['photos']).map((photoPath) {
        // إذا كان المسار يبدأ بـ / نضيف الـ domain مباشرة
        if (photoPath.startsWith('/')) {
          return '$baseUrl$photoPath';
        }
        return '$baseUrl/$photoPath';
      }).toList();
    }

    return HotelModel(
      id: json['id']?.toString() ?? '',
      
      // 🌟 التعديل: يقرأ الاسم من حقل 'name' القادم من السيرفر
      title: json['name'] ?? '', 
      
      // يقرأ العنوان من حقل 'address'
      location: json['address'] ?? '', 
      
      rating: json['rating']?.toString() ?? '0.0',
      
      // 🌟 الصور الجاهزة بالروابط الكاملة
      imageUrls: formattedImages,
    );
  }

  get amenities => null;

  get rooms => null;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': title,
      'address': location,
      'rating': rating,
      'photos': imageUrls,
    };
  }
}