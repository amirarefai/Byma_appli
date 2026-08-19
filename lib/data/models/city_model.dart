import 'package:byma_app/data/models/country_model.dart'; // Adjust path as needed

class CityModel {
  final int id;
  final String name;
  final CountryModel country;

  CityModel({
    required this.id,
    required this.name,
    required this.country,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'] as int,
      name: json['name'] as String? ?? 'Unknown City',
      // Safely parse the nested country object
      country: CountryModel.fromJson(json['country'] as Map<String, dynamic>),
    );
  }
}