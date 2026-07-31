
import 'package:byma_app/data/models/favorite_hotel_model.dart';
import 'package:byma_app/data/network/network_exceptions.dart';
import 'package:byma_app/data/web_services/favorite_hotels_api.dart';

class FavoriteHotelsRepo {
  final FavoriteHotelsApi favoriteHotelsApi;

  FavoriteHotelsRepo(this.favoriteHotelsApi);

  Future<List<FavoriteHotelModel>> fetchFavoriteHotels() async {
    try {
      final response = await favoriteHotelsApi.getFavoriteHotels();

      final List<dynamic> data = response.data;
      
      // Extract the nested 'hotel' object from each favorite item
      final List<FavoriteHotelModel> favoriteHotels = data
          .map((item) => FavoriteHotelModel.fromJson(item as Map<String, dynamic>))
          .toList();

      return favoriteHotels;
    } catch (error) {
      // 1. Convert raw error to the sealed class NetworkExceptions model
      final networkException = NetworkExceptions.getDioException(error);
      
      // 2. Extract the localized/readable string
      final errorMessage = NetworkExceptions.getErrorMessage(networkException);

      // 3. Throw the clean string to be caught by the Cubit
      throw errorMessage;
    }
  }

  Future<void> addFavoriteHotel(int hotelId) async {
    try {
      await favoriteHotelsApi.addFavoriteHotel(hotelId);
    } catch (error) {
      final networkException = NetworkExceptions.getDioException(error);
      final errorMessage = NetworkExceptions.getErrorMessage(networkException);
      throw errorMessage;
    }
  }

  Future<void> removeFavoriteHotel(int favoriteHotelId) async {
    try {
      await favoriteHotelsApi.removeFavoriteHotel(favoriteHotelId);
    } catch (error) {
      final networkException = NetworkExceptions.getDioException(error);
      final errorMessage = NetworkExceptions.getErrorMessage(networkException);
      throw errorMessage;
    }
  }
}