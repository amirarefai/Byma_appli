class HotelFilterModel {
  final String? city;
  final String? search;
  final num? minPrice;
  final num? maxPrice;

  HotelFilterModel({
    this.city,
    this.search,
    this.minPrice,
    this.maxPrice,
  });

  HotelFilterModel copyWith({
    String? city,
    String? search,
    num? minPrice,
    num? maxPrice,
  }) {
    return HotelFilterModel(
      city: city ?? this.city,
      search: search ?? this.search,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    
    // Only add keys to the map if they have valid data
    if (city != null && city!.trim().isNotEmpty) {
      map['city'] = city;
    }
    if (search != null && search!.trim().isNotEmpty) {
      map['search'] = search;
    }
    if (minPrice != null) {
      map['minPrice'] = minPrice;
    }
    if (maxPrice != null) {
      map['maxPrice'] = maxPrice;
    }

    return map;
  }
}