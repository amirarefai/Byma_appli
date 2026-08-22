import 'package:byma_app/data/network/network_exceptions.dart';
import 'package:byma_app/data/web_services/reviews_api.dart';
import 'package:byma_app/data/models/update_review_model.dart';

class ReviewsRepo {
  final ReviewsApi reviewsApi;

  ReviewsRepo(this.reviewsApi);

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

  Future<void> updateReview(
    int reviewId,
    UpdateReviewModel updateReviewModel,
  ) async {
    try {
      await reviewsApi.updateReview(reviewId, updateReviewModel);
    } catch (error) {
      final networkException = NetworkExceptions.getDioException(error);
      final errorMessage = NetworkExceptions.getErrorMessage(networkException);
      throw errorMessage;
    }
  }
}
