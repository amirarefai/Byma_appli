import 'package:byma_app/constance/strings.dart';
import 'package:byma_app/data/models/room_category_model.dart';
class RoomModel {
  final int id;
  final num price;
  final RoomCategoryModel category;
  final List<String> photos;

  RoomModel({
    required this.id,
    required this.price,
    required this.category,
    required this.photos,
  });

  // Iterates through the raw photos list and formats the URLs correctly
  List<String> get imageUrls {
    if (photos.isEmpty) {
      return [
        'assets/images/room-placeholder.jpg' // Updated placeholder name for rooms
      ];
    }

    return photos.map((photo) {
      // Normalize backslashes ( \ ) to forward slashes ( / ) for valid web URLs
      String normalizedPhoto = photo.replaceAll('\\', '/');

      // 1. If the API sends a relative path (e.g., "/uploads/rooms/...")
      if (normalizedPhoto.startsWith('/')) {
        // Remove the trailing slash from baseUrl (if it exists) to prevent double slashes
        final cleanBaseUrl = baseUrl.endsWith('/')
            ? baseUrl.substring(0, baseUrl.length - 1)
            : baseUrl;

        return '$cleanBaseUrl$normalizedPhoto';
      }

      // 2. Fallback just in case the API ever sends a full localhost URL
      return normalizedPhoto
          .replaceFirst('http://127.0.0.1:3000', 'http://$localIp:3000')
          .replaceFirst('http://localhost:3000', 'http://$localIp:3000');
    }).toList();
  }

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      id: json['id'] as int,
      
      price: (json['price'] ?? 0) as num,
      
      // Parse the nested roomCategory safely
      category: json['roomCategory'] != null
          ? RoomCategoryModel.fromJson(json['roomCategory'] as Map<String, dynamic>)
          : RoomCategoryModel(id: 0, name: 'Unknown Category'),
          
      // Safely parses the raw photos array
      photos: (json['photos'] as List<dynamic>?)
              ?.map((photo) => photo.toString())
              .toList() ??
          [],
    );
  }
}