import 'package:byma_app/data/models/recently_viewed_room_model.dart';
import 'package:byma_app/data/network/network_exceptions.dart';
import 'package:byma_app/data/web_services/recently_viewed_room_api.dart';

class RecentlyViewedRoomRepo {
  final RecentlyViewedRoomApi recentlyViewedRoomApi;

  RecentlyViewedRoomRepo(this.recentlyViewedRoomApi);

  Future<List<RecentlyViewedRoomModel>> fetchRecentlyViewedRooms() async {
    try {
      final response = await recentlyViewedRoomApi.getRecentlyViewedRooms();

      final List<dynamic> data = response.data;
      
      final List<RecentlyViewedRoomModel> recentlyViewedRooms = data
          .map((item) => RecentlyViewedRoomModel.fromJson(item as Map<String, dynamic>))
          .toList();

      return recentlyViewedRooms;
    } catch (error) {
      final networkException = NetworkExceptions.getDioException(error);
      final errorMessage = NetworkExceptions.getErrorMessage(networkException);
      throw errorMessage;
    }
  }

  Future<void> addRecentlyViewedRoom(int roomId) async {
    try {
      await recentlyViewedRoomApi.addRecentlyViewedRoom(roomId);
    } catch (error) {
      final networkException = NetworkExceptions.getDioException(error);
      final errorMessage = NetworkExceptions.getErrorMessage(networkException);
      throw errorMessage;
    }
  }
}