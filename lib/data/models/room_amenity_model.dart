import 'package:byma_app/data/models/amenity_model.dart';

class RoomAmenityModel {
  final int id;
  final AmenityModel amenity;

  RoomAmenityModel({
    required this.id,
    required this.amenity,
  });

  factory RoomAmenityModel.fromJson(Map<String, dynamic> json) {
    return RoomAmenityModel(
      id: json['id'] as int,
      amenity: json['amenity'] != null
          ? AmenityModel.fromJson(json['amenity'] as Map<String, dynamic>)
          : AmenityModel(id: 0, name: '', type: ''),
    );
  }
}