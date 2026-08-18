import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:byma_app/business_logic/reviews/cubit/reviews_state.dart';
import 'package:byma_app/data/repositories/reviews_repo.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  final ReviewsRepo reviewsRepo;

  ReviewsCubit(this.reviewsRepo) : super(const ReviewsState.initial());

  // إرسال تقييم جديد
  Future<void> createReview({
    required int rate,
    required int hotelId,
    String? comment,
  }) async {
    emit(const ReviewsState.loading());
    try {
      await reviewsRepo.createReview(
        rate: rate,
        hotelId: hotelId,
        comment: comment,
      );
      emit(const ReviewsState.success());
    } catch (errorMessage) {
      emit(ReviewsState.error(errorMessage.toString()));
    }
  }

  // جلب التقييمات
  Future<void> fetchAllReviews() async {
    emit(const ReviewsState.loading());
    try {
      final reviews = await reviewsRepo.fetchAllReviews();
      emit(ReviewsState.loaded(reviews));
    } catch (errorMessage) {
      emit(ReviewsState.error(errorMessage.toString()));
    }
  }
}