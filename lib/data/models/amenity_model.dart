class AmenityModel {
  final int id;
  final String name;
  final String type;

  AmenityModel({
    required this.id,
    required this.name,
    required this.type,
  });

  factory AmenityModel.fromJson(Map<String, dynamic> json) {
    return AmenityModel(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      type: json['type'] as String? ?? '',
    );
  }
}