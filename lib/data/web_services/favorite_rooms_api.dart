import 'package:dio/dio.dart';

class FavoriteRoomsApi {
  final Dio dio;

  FavoriteRoomsApi(this.dio);

  Future<Response> getFavoriteRooms() async {
    return await dio.get('favorites/rooms');
  }

  Future<Response> addFavoriteRooms(int roomId) async {
    return await dio.post(
      'favorites/rooms',
      data: {
        'roomId': roomId,
      },
    );
  }

  Future<Response> removeFavoriteRooms(int favoriteRoomId) async {
    return await dio.delete('favorites/rooms/$favoriteRoomId');
  }
}