import 'room_model.dart'; 

class RecentlyViewedRoomModel {
  final int id; 
  final RoomModel room; 

  RecentlyViewedRoomModel({
    required this.id,
    required this.room,
  });

  factory RecentlyViewedRoomModel.fromJson(Map<String, dynamic> json) {
    return RecentlyViewedRoomModel(
      id: json['id'] as int,
      room: RoomModel.fromJson(json['room'] as Map<String, dynamic>),
    );
  }
}