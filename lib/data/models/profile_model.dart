import 'package:byma_app/constance/strings.dart';

class ProfileModel {
  final String firstName;
  final String lastName;
  final String phone;
  final String idImageUrl;
  final String profileImageUrl;
  final num balance;
  final num points;

  ProfileModel({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.idImageUrl,
    required this.profileImageUrl,
    required this.balance,
    required this.points,
  });

  // Getters that return the fully formatted URLs using the helper below
  String get formattedProfileImageUrl => _formatImageUrl(
        profileImageUrl,
        'assets/images/profile-placeholder.jpg', // Fallback asset
      );

  String get formattedIdImageUrl => _formatImageUrl(
        idImageUrl,
        'assets/images/id-placeholder.jpg', // Fallback asset
      );

  // Helper method applying the same logic used in HotelModel
  String _formatImageUrl(String rawUrl, String placeholderPath) {
    if (rawUrl.isEmpty) {
      return placeholderPath;
    }

    String url = rawUrl;

    // 1. If the API sends a relative path (e.g., "/uploads/profiles/...")
    if (url.startsWith('/')) {
      // Remove the trailing slash from baseUrl (if it exists)
      final cleanBaseUrl = baseUrl.endsWith('/')
          ? baseUrl.substring(0, baseUrl.length - 1)
          : baseUrl;

      return '$cleanBaseUrl$url';
    }

    // 2. Fallback just in case the API ever sends a full localhost URL
    return url
        .replaceFirst('http://127.0.0.1:3000', 'http://$localIp:3000')
        .replaceFirst('http://localhost:3000', 'http://$localIp:3000');
  }

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      idImageUrl: json['idImageUrl'] as String? ?? '',
      profileImageUrl: json['profileImageUrl'] as String? ?? '',
      balance: (json['balance'] ?? 0) as num,
      points: (json['points'] ?? 0) as num,
    );
  }
}