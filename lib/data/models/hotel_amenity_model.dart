import 'package:byma_app/data/models/amenity_model.dart';

class HotelAmenityModel {
  final int id;
  final AmenityModel amenity;

  HotelAmenityModel({
    required this.id,
    required this.amenity,
  });

  factory HotelAmenityModel.fromJson(Map<String, dynamic> json) {
    final nestedAmenity = json['amenity'];

    return HotelAmenityModel(
      id: json['id'] as int? ?? 0,
      amenity: nestedAmenity is Map<String, dynamic>
          ? AmenityModel.fromJson(nestedAmenity)
          : AmenityModel(
              id: json['id'] as int? ?? 0,
              name: json['name'] as String? ?? '',
              type: json['type'] as String? ?? '',
            ),
    );
  }
}