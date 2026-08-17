
import 'package:byma_app/data/models/room_collection_model.dart';
import 'package:byma_app/data/network/network_exceptions.dart';
import 'package:byma_app/data/web_services/room_collection_api.dart';

class RoomCollectionRepo {
  final RoomCollectionApi roomCollectionApi;

  RoomCollectionRepo(this.roomCollectionApi);

  Future<List<RoomCollectionModel>> fetchRoomCollection(int collectionId) async {
    try {
      final response = await roomCollectionApi.getRoomsCollection(collectionId);

      final List<dynamic> data = response.data;
      
      final List<RoomCollectionModel> roomCollection = data
          .map((item) => RoomCollectionModel.fromJson(item as Map<String, dynamic>))
          .toList();

      return roomCollection;
    } catch (error) {
      final networkException = NetworkExceptions.getDioException(error);
      final errorMessage = NetworkExceptions.getErrorMessage(networkException);
      throw errorMessage;
    }
  }
  
  Future<void> removeRoomFromCollection(int collectionId, int roomId) async {
    try {
      await roomCollectionApi.removeRoomFromCollection(collectionId, roomId);
    } catch (error) {
      final networkException = NetworkExceptions.getDioException(error);
      final errorMessage = NetworkExceptions.getErrorMessage(networkException);
      throw errorMessage;
    }
  }

  Future<void> addRoomToCollection(int collectionId, int roomId) async {
    try {
      await roomCollectionApi.addRoomToCollection(collectionId, roomId);
    } catch (error) {
      final networkException = NetworkExceptions.getDioException(error);
      final errorMessage = NetworkExceptions.getErrorMessage(networkException);
      throw errorMessage;
    }
  }
}