class UpdateBookingModel {
  final String startDate;
  final String endDate;

  const UpdateBookingModel({
    required this.startDate,
    required this.endDate,
  });

  Map<String, dynamic> toJson() => {
        'startDate': startDate,
        'endDate': endDate,
      };
}
