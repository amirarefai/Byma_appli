import 'package:dio/dio.dart';

class RoomDetailsApi {
  final Dio dio;

  RoomDetailsApi(this.dio);

  Future<Response> getRoomDetails(int roomId) async {
    return await dio.get('rooms/$roomId');
  }
}