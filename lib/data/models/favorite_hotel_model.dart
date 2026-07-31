import 'hotel_model.dart'; // Adjust this import path based on your folder structure

class FavoriteHotelModel {
  final int id; // This is the ID of the favorite record itself (e.g., 5, 6)
  final HotelModel hotel; // This contains the actual nested hotel data

  FavoriteHotelModel({
    required this.id,
    required this.hotel,
  });

  factory FavoriteHotelModel.fromJson(Map<String, dynamic> json) {
    return FavoriteHotelModel(
      id: json['id'] as int,
      hotel: HotelModel.fromJson(json['hotel'] as Map<String, dynamic>),
    );
  }
}