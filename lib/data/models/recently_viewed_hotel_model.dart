import 'hotel_model.dart'; 

class RecentlyViewedHotelModel {
  final int id; // This is the ID of the recently viewed record itself (e.g., 5, 6)
  final HotelModel hotel; // This contains the actual nested hotel data

  RecentlyViewedHotelModel({
    required this.id,
    required this.hotel,
  });

  factory RecentlyViewedHotelModel.fromJson(Map<String, dynamic> json) {
    return RecentlyViewedHotelModel(
      id: json['id'] as int,
      hotel: HotelModel.fromJson(json['hotel'] as Map<String, dynamic>),
    );
  }
}