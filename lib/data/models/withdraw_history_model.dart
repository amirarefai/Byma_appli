import 'package:byma_app/constance/strings.dart';

class WithdrawHistoryModel {
  final num amount;
  final num receiptNumber;
   final DateTime createdAt;
  final String receiptImage;

  WithdrawHistoryModel({
    required this.amount,
    required this.receiptNumber,
    required this.createdAt,
    required this.receiptImage,
  });

  // Formats the receipt image URL correctly.
  String get imageUrl {
    if (receiptImage.isEmpty) {
      return 'assets/images/error.jpg';
    }

    String imageUrl = receiptImage;

    // 1. If the API sends a relative path (e.g., "/uploads/hotels/...")
    if (imageUrl.startsWith('/')) {
      // Remove the trailing slash from baseUrl (if it exists) to prevent double slashes like '...3000//uploads...'
      final cleanBaseUrl = baseUrl.endsWith('/')
          ? baseUrl.substring(0, baseUrl.length - 1)
          : baseUrl;

      imageUrl = '$cleanBaseUrl$imageUrl';
    }

    // 2. Fallback just in case the API ever sends a full localhost URL.
    return imageUrl
        .replaceFirst('http://127.0.0.1:3000', 'http://$localIp:3000')
        .replaceFirst('http://localhost:3000', 'http://$localIp:3000');
  }

  factory WithdrawHistoryModel.fromJson(Map<String, dynamic> json) {
    return WithdrawHistoryModel(
      
      amount: (json['amount'] ?? 0) as num,
      receiptNumber: (json['receiptNumber'] ?? 0 ) as num,
      createdAt: DateTime.parse(json['createdAt'] as String),
      receiptImage: json['receiptImage'] as String? ?? '',
    );
          
  }
}