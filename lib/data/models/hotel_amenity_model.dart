import 'package:byma_app/data/models/amenity_model.dart';

class HotelAmenityModel {
  final int id;
  final AmenityModel amenity;

  HotelAmenityModel({
    required this.id,
    required this.amenity,
  });

  factory HotelAmenityModel.fromJson(Map<String, dynamic> json) {
    return HotelAmenityModel(
      id: json['id'] as int,
      amenity: json['amenity'] != null
          ? AmenityModel.fromJson(json['amenity'] as Map<String, dynamic>)
          : AmenityModel(id: 0, name: '', type: ''),
    );
  }
}