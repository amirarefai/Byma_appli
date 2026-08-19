import 'package:byma_app/data/models/hotel_details_model.dart';
import 'package:byma_app/data/models/hotel_filter_model.dart';
import 'package:byma_app/data/models/hotel_model.dart';
import 'package:byma_app/data/network/network_exceptions.dart';
import 'package:byma_app/data/web_services/hotels_api.dart';

class HotelsRepo {
  final HotelsApi hotelsApi;

  HotelsRepo(this.hotelsApi);

  Future<List<HotelModel>> fetchAllHotels({HotelFilterModel? filter}) async {
    try {
      final response = await hotelsApi.getAllHotels(
        queryParameters: filter?.toJson(),
      );
      
      final List<dynamic> data = response.data;
      
      final List<HotelModel> hotels = data
          .map((item) => HotelModel.fromJson(item as Map<String, dynamic>))
          .toList();

      return hotels;
    } catch (error) {
      final networkException = NetworkExceptions.getDioException(error);
      final errorMessage = NetworkExceptions.getErrorMessage(networkException);
      throw errorMessage;
    }
  }

  Future<HotelDetailsModel> fetchHotelDetails(int hotelId) async {
    try {
      final response = await hotelsApi.getHotelDetails(hotelId);
      
      final Map<String, dynamic> data = response.data;
      
      return HotelDetailsModel.fromJson(data);
    } catch (error) {
      final networkException = NetworkExceptions.getDioException(error);
      final errorMessage = NetworkExceptions.getErrorMessage(networkException);
      throw errorMessage;
    }
  }

}