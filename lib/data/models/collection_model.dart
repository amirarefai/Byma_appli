class CollectionModel {
  final int id;
  final String name;

  CollectionModel({
    required this.id,
    required this.name,
  });

  factory CollectionModel.fromJson(Map<String, dynamic> json) {
    return CollectionModel(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
    );
  }
}