import 'package:dio/dio.dart';

class RecentlyViewedRoomApi {
  final Dio dio;

  RecentlyViewedRoomApi(this.dio);

  Future<Response> getRecentlyViewedRooms() async {
    return await dio.get('recently-viewed/rooms'); 
  }

  Future<Response> addRecentlyViewedRoom(int roomId) async {
    return await dio.post(
      'recently-viewed/rooms', 
      data: {
        'roomId': roomId,
      },
    );
  }
}