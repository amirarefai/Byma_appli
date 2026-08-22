class UpdateReviewModel {
  final int? rate;
  final String? comment;

  const UpdateReviewModel({
    this.rate,
    this.comment,
  });

  bool get hasChanges => rate != null || comment != null;

  Map<String, dynamic> toJson() => {
        if (rate != null) 'rate': rate,
        if (comment != null) 'comment': comment!.trim(),
      };
}
