import 'room_model.dart'; 

class RoomCollectionModel {
  final int id; 
  final RoomModel room; 

  RoomCollectionModel({
    required this.id,
    required this.room,
  });

  factory RoomCollectionModel.fromJson(Map<String, dynamic> json) {
    return RoomCollectionModel(
      id: json['id'] as int,
      room: RoomModel.fromJson(json['room'] as Map<String, dynamic>),
    );
  }
}