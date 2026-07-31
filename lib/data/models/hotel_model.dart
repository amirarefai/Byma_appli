import 'package:byma_app/constance/strings.dart';

class HotelModel {
  final int id;
  final String name;
  final num rating;
  final String address;
  final String status;
  final List<String> photos;

  HotelModel({
    required this.id,
    required this.name,
    required this.rating,
    required this.address,
    required this.status,
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
      // 1. If the API sends a relative path (e.g., "/uploads/hotels/...")
      if (photo.startsWith('/')) {
        // Remove the trailing slash from baseUrl (if it exists) to prevent double slashes like '...3000//uploads...'
        final cleanBaseUrl = baseUrl.endsWith('/') 
            ? baseUrl.substring(0, baseUrl.length - 1) 
            : baseUrl;
            
        return '$cleanBaseUrl$photo';
      }

      // 2. Fallback just in case the API ever sends a full localhost URL
      return photo.replaceFirst('http://127.0.0.1:3000', 'http://$localIp:3000')
                  .replaceFirst('http://localhost:3000', 'http://$localIp:3000');
    }).toList();
  }

  factory HotelModel.fromJson(Map<String, dynamic> json) {
    return HotelModel(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      
      rating: (json['rating'] ?? 0) as num,
      
      address: json['address'] as String? ?? 'Unknown Location',
      status: json['status'] as String? ?? 'pending',
      
      // Safely parses the raw photos array
      photos: (json['photos'] as List<dynamic>?)
              ?.map((photo) => photo.toString())
              .toList() ??
          [],
    );
  }
}