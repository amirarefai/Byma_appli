import 'package:byma_app/constance/strings.dart';
import 'package:byma_app/data/models/hotel_amenity_model.dart';
import 'package:byma_app/data/models/review_model.dart';
import 'package:byma_app/data/models/room_model.dart';

class HotelDetailsModel {
  final int id;
  final String name;
  final String phone;
  final double lng;
  final double lat;
  final String checkIn;
  final String checkOut;
  final String? thingsToKnow;
  final List<HotelAmenityModel> hotelAmenities;
  final List<RoomModel> rooms;
  final List<ReviewModel> reviews;
  final String address;
  final num rating;
  final List<String> photos;

  HotelDetailsModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.lng,
    required this.lat,
    required this.checkIn,
    required this.checkOut,
    this.thingsToKnow,
    required this.hotelAmenities,
    required this.rooms,
    required this.reviews,
    required this.address,
    required this.rating,
    required this.photos,
  });

  // Iterates through the raw photos list and formats the URLs correctly
  List<String> get imageUrls {
    if (photos.isEmpty) {
      return [
        'assets/images/hotel-placeholder.jpg'
      ];
    }

    return photos.map((photo) {
      // Normalize backslashes ( \ ) to forward slashes ( / ) for valid URLs
      String normalizedPhoto = photo.replaceAll('\\', '/');

      // 1. If the API sends a relative path (e.g., "/uploads/hotels/...")
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

  factory HotelDetailsModel.fromJson(Map<String, dynamic> json) {
    return HotelDetailsModel(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      
      // Safely converts integers or doubles from JSON to double
      lng: (json['lng'] as num?)?.toDouble() ?? 0.0,
      lat: (json['lat'] as num?)?.toDouble() ?? 0.0,
      
      checkIn: json['checkIn'] as String? ?? '12:00:00',
      checkOut: json['checkOut'] as String? ?? '12:00:00',
      thingsToKnow: json['thingsToKnow'] as String?,
      
      // Nested list of amenities
      hotelAmenities: (json['hotelAmenities'] as List<dynamic>?)
              ?.map((item) =>
                  HotelAmenityModel.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
          
      // Nested list of rooms
      rooms: (json['rooms'] as List<dynamic>?)
              ?.map((item) => RoomModel.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
          
      // Nested list of reviews
      reviews: (json['reviews'] as List<dynamic>?)
              ?.map((item) => ReviewModel.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
          
      address: json['address'] as String? ?? 'Unknown Location',
      rating: (json['rating'] ?? 0) as num,
      
      // Raw photo relative paths
      photos: (json['photos'] as List<dynamic>?)
              ?.map((photo) => photo.toString())
              .toList() ??
          [],
    );
  }
}