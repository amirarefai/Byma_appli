class ReviewModel {
  final int id;
  final num rate;
  final String? comment;
  final DateTime createdAt;

  ReviewModel({
    required this.id,
    required this.rate,
    this.comment,
    required this.createdAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] as int,
      
      rate: (json['rate'] ?? 0) as num,
      
      // Kept nullable since the JSON shows it can be null
      comment: json['comment'] as String?,
      
      // Safely parse the ISO 8601 date string into a DateTime object
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String) ?? DateTime.now()
          : DateTime.now(),
    );
  }
}