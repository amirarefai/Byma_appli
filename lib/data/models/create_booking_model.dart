class CreateBookingModel {
  final int roomId;
  final String startDate;
  final String endDate;
  final List<int> specialServiceIds;

  const CreateBookingModel({
    required this.roomId,
    required this.startDate,
    required this.endDate,
    required this.specialServiceIds,
  });

  Map<String, dynamic> toJson() => {
        'roomId': roomId,
        'startDate': startDate,
        'endDate': endDate,
        'specialServiceIds': specialServiceIds,
      };
}
