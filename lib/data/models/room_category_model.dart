class RoomCategoryModel {
  final int id;
  final String name;

  RoomCategoryModel({
    required this.id,
    required this.name,
  });

  factory RoomCategoryModel.fromJson(Map<String, dynamic> json) {
    return RoomCategoryModel(
      id: json['id'] as int,
      name: json['name'] as String? ?? 'Unknown Category',
    );
  }
}
