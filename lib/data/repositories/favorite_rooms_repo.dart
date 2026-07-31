import 'package:byma_app/data/models/favorite_room_model.dart'; // تأكد من استيراد ملف الموديل الصحيح
import 'package:byma_app/data/network/network_exceptions.dart';
import 'package:byma_app/data/web_services/favorite_rooms_api.dart';

class FavoriteRoomsRepo {
  final FavoriteRoomsApi favoriteRoomsApi;

  FavoriteRoomsRepo(this.favoriteRoomsApi);

  Future<List<FavoriteRoomModel>> fetchFavoriteRooms() async {
    try {
      final response = await favoriteRoomsApi.getFavoriteRooms();

      final List<dynamic> data = response.data;

      final List<FavoriteRoomModel> favoriteRooms = data
          .map((item) => FavoriteRoomModel.fromJson(item as Map<String, dynamic>))
          .toList();

      return favoriteRooms;
    } catch (error) {
      final networkException = NetworkExceptions.getDioException(error);
      final errorMessage = NetworkExceptions.getErrorMessage(networkException);
      throw errorMessage;
    }
  }
}