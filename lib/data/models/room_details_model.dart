import 'package:byma_app/constance/strings.dart';
import 'package:byma_app/data/models/room_amenity_model.dart';
import 'package:byma_app/data/models/room_category_model.dart';

class RoomDetailsModel {
  final int id;
  final String roomNumber;
  final int floor;
  final int bedNumber;
  final num price;
  final String status;
  final RoomCategoryModel roomCategory;
  final List<RoomAmenityModel> roomAmenities;
  final List<String> photos;

  RoomDetailsModel({
    required this.id,
    required this.roomNumber,
    required this.floor,
    required this.bedNumber,
    required this.price,
    required this.status,
    required this.roomCategory,
    required this.roomAmenities,
    required this.photos,
  });

  // Iterates through the raw photos list and formats the URLs correctly
  List<String> get imageUrls {
    if (photos.isEmpty) {
      return [
        'assets/images/room-placeholder.jpg'
      ];
    }

    return photos.map((photo) {
      // Normalize backslashes ( \ ) to forward slashes ( / ) for valid URLs
      String normalizedPhoto = photo.replaceAll('\\', '/');

      // 1. If the API sends a relative path (e.g., "/uploads/rooms/...")
      if (normalizedPhoto.startsWith('/')) {
        final cleanBaseUrl = baseUrl.endsWith('/')
            ? baseUrl.substring(0, baseUrl.length - 1)
            : baseUrl;

        return '$cleanBaseUrl$normalizedPhoto';
      }

      // 2. Fallback for localhost URLs
      return normalizedPhoto
          .replaceFirst('http://127.0.0.1:3000', 'http://$localIp:3000')
          .replaceFirst('http://localhost:3000', 'http://$localIp:3000');
    }).toList();
  }

  factory RoomDetailsModel.fromJson(Map<String, dynamic> json) {
    return RoomDetailsModel(
      id: json['id'] as int,
      roomNumber: json['roomNumber'] as String? ?? '1',
      floor: (json['floor'] as num?)?.toInt() ?? 1,
      bedNumber: (json['bedNumber'] as num?)?.toInt() ?? 1,
      price: (json['price'] ?? 0) as num,
      status: json['status'] as String? ?? 'Available',
      
      // Parsed room category model
      roomCategory: json['roomCategory'] != null
          ? RoomCategoryModel.fromJson(json['roomCategory'] as Map<String, dynamic>)
          : RoomCategoryModel(id: 0, name: 'Unknown Category'),

      // Nested list of room amenities
      roomAmenities: (json['roomAmenities'] as List<dynamic>?)
              ?.map((item) =>
                  RoomAmenityModel.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],

      // Raw photo relative paths
      photos: (json['photos'] as List<dynamic>?)
              ?.map((photo) => photo.toString())
              .toList() ??
          [],
    );
  }
}