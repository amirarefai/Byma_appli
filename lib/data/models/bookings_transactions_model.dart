class BookingsTransactionsModel {
  
final num amount;
final DateTime createdAt;
final String type;
final String hotelName;
final String roomNumber;

  BookingsTransactionsModel({
    required this.amount,
    required this.createdAt,
    required this.type,
    required this.hotelName,
    required this.roomNumber,
  });

  factory BookingsTransactionsModel.fromJson(Map<String, dynamic> json) {
    return BookingsTransactionsModel(
      amount: (json['amount'] ?? 0) as num,
      createdAt: DateTime.parse(json['createdAt'] as String),
      type: json['type'] as String? ?? '',
      hotelName: json['hotelName'] as String? ?? '',
      roomNumber: json['roomNumber'] as String? ?? '',
    );
  }

}