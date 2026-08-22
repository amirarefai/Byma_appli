import 'package:dio/dio.dart';
import 'package:byma_app/data/models/update_review_model.dart';

class ReviewsApi {
  final Dio dio;

  ReviewsApi(this.dio);

  Future<Response> createReview({
    required int rate,
    required int hotelId,
    String? comment,
  }) async {
    return await dio.post(
      'reviews',
      data: {
        'rate': rate,
        'hotelId': hotelId,
        if (comment != null && comment.trim().isNotEmpty)
          'comment': comment.trim(),
      },
    );
  }

  Future<Response> updateReview(
    int reviewId,
    UpdateReviewModel updateReviewModel,
  ) async {
    return await dio.patch(
      'reviews/$reviewId',
      data: updateReviewModel.toJson(),
    );
  }
}
