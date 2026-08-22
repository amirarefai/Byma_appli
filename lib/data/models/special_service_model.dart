class SpecialServiceModel {
  final int id;
  final String name;

  SpecialServiceModel({
    required this.id,
    required this.name,
  });

  factory SpecialServiceModel.fromJson(Map<String, dynamic> json) {
    return SpecialServiceModel(
      id: json['id'] as int,
      name: json['name'] as String? ?? 'Unknown Service',
    );
  }
}
