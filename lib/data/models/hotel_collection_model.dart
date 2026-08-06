import 'hotel_model.dart'; 

class HotelCollectionModel {
  final int id; 
  final HotelModel hotel; 

  HotelCollectionModel({
    required this.id,
    required this.hotel,
  });

  factory HotelCollectionModel.fromJson(Map<String, dynamic> json) {
    return HotelCollectionModel(
      id: json['id'] as int,
      hotel: HotelModel.fromJson(json['hotel'] as Map<String, dynamic>),
    );
  }
}