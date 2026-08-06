import 'package:byma_app/data/models/recently_viewed_hotel_model.dart';
import 'package:byma_app/data/network/network_exceptions.dart';
import 'package:byma_app/data/web_services/recently_viewed_hotel_api.dart';

class RecentlyViewedHotelRepo {
  final RecentlyViewedHotelApi recentlyViewedHotelApi;

  RecentlyViewedHotelRepo(this.recentlyViewedHotelApi);

  Future<List<RecentlyViewedHotelModel>> fetchRecentlyViewedHotels() async {
    try {
      final response = await recentlyViewedHotelApi.getRecentlyViewedHotels();

      final List<dynamic> data = response.data;
      
      final List<RecentlyViewedHotelModel> recentlyViewedHotels = data
          .map((item) => RecentlyViewedHotelModel.fromJson(item as Map<String, dynamic>))
          .toList();

      return recentlyViewedHotels;
    } catch (error) {
      final networkException = NetworkExceptions.getDioException(error);
      final errorMessage = NetworkExceptions.getErrorMessage(networkException);
      throw errorMessage;
    }
  }

  Future<void> addRecentlyViewedHotel(int hotelId) async {
    try {
      await recentlyViewedHotelApi.addRecentlyViewedHotel(hotelId);
    } catch (error) {
      final networkException = NetworkExceptions.getDioException(error);
      final errorMessage = NetworkExceptions.getErrorMessage(networkException);
      throw errorMessage;
    }
  }
}