
import 'package:byma_app/data/models/hotel_collection_model.dart';
import 'package:byma_app/data/network/network_exceptions.dart';
import 'package:byma_app/data/web_services/hotel_collection_api.dart';

class HotelCollectionRepo {
  final HotelCollectionApi hotelCollectionApi;

  HotelCollectionRepo(this.hotelCollectionApi);

  Future<List<HotelCollectionModel>> fetchHotelCollection(int collectionId) async {
    try {
      final response = await hotelCollectionApi.getHotelsCollection(collectionId);

      final List<dynamic> data = response.data;
      
      final List<HotelCollectionModel> hotelCollection = data
          .map((item) => HotelCollectionModel.fromJson(item as Map<String, dynamic>))
          .toList();

      return hotelCollection;
    } catch (error) {
      final networkException = NetworkExceptions.getDioException(error);
      final errorMessage = NetworkExceptions.getErrorMessage(networkException);
      throw errorMessage;
    }
  }

  Future<void> removeHotelFromCollection(int collectionId, int hotelId) async {
    try {
      await hotelCollectionApi.removeHotelFromCollection(collectionId, hotelId);
    } catch (error) {
      final networkException = NetworkExceptions.getDioException(error);
      final errorMessage = NetworkExceptions.getErrorMessage(networkException);
      throw errorMessage;
    }
  }

  Future<void> addHotelToCollection(int collectionId, int hotelId) async {
    try {
      await hotelCollectionApi.addHotelToCollection(collectionId, hotelId);
    } catch (error) {
      final networkException = NetworkExceptions.getDioException(error);
      final errorMessage = NetworkExceptions.getErrorMessage(networkException);
      throw errorMessage;
    }
  }
}