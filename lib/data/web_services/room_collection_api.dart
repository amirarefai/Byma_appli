import 'package:dio/dio.dart';

class RoomCollectionApi {
  final Dio dio;

  RoomCollectionApi(this.dio);

  Future<Response> getRoomsCollection(int collectionId) async {
    return await dio.get('collections/$collectionId/rooms');
  }
  
  Future<Response> removeRoomFromCollection(int collectionId, int roomId) async {
    return await dio.delete('collections/$collectionId/rooms/$roomId');
  }

  Future<Response> addRoomToCollection(int collectionId, int roomId) async {
    return await dio.post('collections/$collectionId/rooms', data: {'roomId': roomId});
  }
}