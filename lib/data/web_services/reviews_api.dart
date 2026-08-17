import 'package:dio/dio.dart';

class ReviewsApi {
  final Dio dio;

  ReviewsApi(this.dio);

  // إنشاء تقييم جديد (التعليق اختياري)
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
        'comment': comment,
      },
    );
  }

  // جلب كل التقييمات
  Future<Response> getAllReviews() async {
    return await dio.get('reviews');
  }

  // حذف تقييم
  Future<Response> removeReview(int reviewId) async {
    return await dio.delete('reviews/$reviewId');
  }
}