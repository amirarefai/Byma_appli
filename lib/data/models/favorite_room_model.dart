import 'room_model.dart'; 

class FavoriteRoomModel {
  final int id; // This is the ID of the favorite record itself (e.g., 5, 6)
  final RoomModel room; // This contains the actual nested room data

  FavoriteRoomModel({
    required this.id,
    required this.room,
  });

  factory FavoriteRoomModel.fromJson(Map<String, dynamic> json) {
    return FavoriteRoomModel(
      id: json['id'] as int,
      room: RoomModel.fromJson(json['room'] as Map<String, dynamic>),
    );
  }
}