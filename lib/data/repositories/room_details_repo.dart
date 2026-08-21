import 'package:byma_app/data/models/room_category_model.dart';
import 'package:byma_app/data/models/room_details_model.dart';
import 'package:byma_app/data/network/network_exceptions.dart';
import 'package:byma_app/data/web_services/room_details_api.dart';

class RoomDetailsRepo {
  final RoomDetailsApi roomDetailsApi;

  RoomDetailsRepo(this.roomDetailsApi);

  Future<RoomDetailsModel> fetchRoomDetails(int roomId) async {
    try {
      final response = await roomDetailsApi.getRoomDetails(roomId);
      
      final Map<String, dynamic> data = response.data;
      
      return RoomDetailsModel.fromJson(data);
    } catch (error) {
      final networkException = NetworkExceptions.getDioException(error);
      final errorMessage = NetworkExceptions.getErrorMessage(networkException);
      throw errorMessage;
    }
  }

  Future<List<RoomCategoryModel>> fetchAllRoomCategories() async {
    try {
      final response = await roomDetailsApi.getAllRoomCategories();

      final List<dynamic> data = response.data;

      final List<RoomCategoryModel> roomCategories = data
          .map((item) => RoomCategoryModel.fromJson(item as Map<String, dynamic>))
          .toList();

      return roomCategories;
    } catch (error) {
      final networkException = NetworkExceptions.getDioException(error);
      final errorMessage = NetworkExceptions.getErrorMessage(networkException);
      throw errorMessage;
    }
  }

}