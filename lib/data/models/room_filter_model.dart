class RoomFilterModel {
  final int? floor;
  final int? bedNumber;
  final num? minPrice;
  final num? maxPrice;
  final String? status; 
  final int? roomCategoryId;

  RoomFilterModel({
    this.floor,
    this.bedNumber,
    this.minPrice,
    this.maxPrice,
    this.status,
    this.roomCategoryId,
  });

  // Best Practice: Use copyWith for progressive filter building in the UI
  RoomFilterModel copyWith({
    int? floor,
    int? bedNumber,
    num? minPrice,
    num? maxPrice,
    String? status,
    int? roomCategoryId,
  }) {
    return RoomFilterModel(
      floor: floor ?? this.floor,
      bedNumber: bedNumber ?? this.bedNumber,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      status: status ?? this.status,
      roomCategoryId: roomCategoryId ?? this.roomCategoryId,
    );
  }

  // Best Practice: Dart collection 'if' for cleaner map generation
  Map<String, dynamic> toJson() => {
    if (floor != null) 'floor': floor,
    if (bedNumber != null) 'bedNumber': bedNumber,
    if (minPrice != null) 'minPrice': minPrice,
    if (maxPrice != null) 'maxPrice': maxPrice,
    if (status != null && status!.isNotEmpty) 'status': status,
    if (roomCategoryId != null) 'roomCategoryId': roomCategoryId,
  };
}