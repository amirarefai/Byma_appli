import 'package:byma_app/constance/strings.dart';

class BookingHistoryModel {
  final int id;
  final String startDate;
  final String endDate;
  final num totalPrice;
  final String status;
  final int hotelId;
  final String hotelName;
  final String cityName;
  final String countryName;
  final int roomId;
  final int? reviewId;
  final String roomNumber;
  final List<String> roomImagesUrls;

  BookingHistoryModel({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.totalPrice,
    required this.status,
    required this.hotelId,
    required this.hotelName,
    required this.cityName,
    required this.countryName,
    required this.roomId,
    this.reviewId,
    required this.roomNumber,
    required this.roomImagesUrls,
  });

  // Iterates through the raw photos list and formats the URLs correctly
  List<String> get imageUrls {
    if (roomImagesUrls.isEmpty) {
      return ['assets/images/room-placeholder.jpg']; // Fallback local image
    }

    return roomImagesUrls.map((photo) {
      final normalizedPhoto = photo.replaceAll('\\', '/');
      final cleanBaseUrl = baseUrl.endsWith('/')
          ? baseUrl.substring(0, baseUrl.length - 1)
          : baseUrl;

      if (!normalizedPhoto.startsWith('http')) {
        final relativePath = normalizedPhoto.startsWith('/')
            ? normalizedPhoto
            : '/$normalizedPhoto';
        return '$cleanBaseUrl$relativePath';
      }

      return normalizedPhoto
          .replaceFirst('http://127.0.0.1:3000', 'http://$localIp:3000')
          .replaceFirst('http://localhost:3000', 'http://$localIp:3000');
    }).toList();
  }

  factory BookingHistoryModel.fromJson(Map<String, dynamic> json) {
    final review = json['review'];
    final reviewId = json['reviewId'] ??
        (review is Map<String, dynamic> ? review['id'] : null);

    return BookingHistoryModel(
      id: json['id'] as int,
      startDate: json['startDate'] as String? ?? '',
      endDate: json['endDate'] as String? ?? '',
      totalPrice: (json['totalPrice'] ?? 0) as num,
      status: json['status'] as String? ?? 'pending',
      hotelId: json['hotelId'] as int,
      hotelName: json['hotelName'] as String? ?? 'Unknown Hotel',
      cityName: json['cityName'] as String? ?? '',
      countryName: json['countryName'] as String? ?? '',
      roomId: json['roomId'] as int,
      reviewId: reviewId is int ? reviewId : int.tryParse('$reviewId'),
      roomNumber: json['roomNumber']?.toString() ?? '',
      
      // Safely parses the raw photos array
      roomImagesUrls: (json['roomImagesUrls'] as List<dynamic>?)
              ?.map((photo) => photo.toString())
              .toList() ??
          [],
    );
  }
}