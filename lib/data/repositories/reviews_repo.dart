import 'package:byma_app/data/network/network_exceptions.dart';
import 'package:byma_app/data/web_services/reviews_api.dart';

class ReviewsRepo {
  final ReviewsApi reviewsApi;

  ReviewsRepo(this.reviewsApi);

  // إضافة تقييم جديد
  Future<void> createReview({
    required int rate,
    required int hotelId,
    String? comment,
  }) async {
    try {
      await reviewsApi.createReview(
        rate: rate,
        hotelId: hotelId,
        comment: comment,
      );
    } catch (error) {
      final networkException = NetworkExceptions.getDioException(error);
      final errorMessage = NetworkExceptions.getErrorMessage(networkException);
      throw errorMessage;
    }
  }

  // جلب كافة التقييمات
  Future<List<dynamic>> fetchAllReviews() async {
    try {
      final response = await reviewsApi.getAllReviews();
      return response.data as List<dynamic>;
    } catch (error) {
      final networkException = NetworkExceptions.getDioException(error);
      final errorMessage = NetworkExceptions.getErrorMessage(networkException);
      throw errorMessage;
    }
  }

  // حذف تقييم
  Future<void> removeReview(int reviewId) async {
    try {
      await reviewsApi.removeReview(reviewId);
    } catch (error) {
      final networkException = NetworkExceptions.getDioException(error);
      final errorMessage = NetworkExceptions.getErrorMessage(networkException);
      throw errorMessage;
    }
  }
}