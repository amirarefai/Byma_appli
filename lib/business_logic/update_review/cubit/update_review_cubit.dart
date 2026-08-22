import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:byma_app/data/models/update_review_model.dart';
import 'package:byma_app/data/repositories/reviews_repo.dart';

part 'update_review_state.dart';
part 'update_review_cubit.freezed.dart';

class UpdateReviewCubit extends Cubit<UpdateReviewState> {
  final ReviewsRepo reviewsRepo;

  UpdateReviewCubit(this.reviewsRepo)
      : super(const UpdateReviewState.initial());

  Future<void> updateReview(
    int reviewId,
    UpdateReviewModel updateReviewModel,
  ) async {
    if (!updateReviewModel.hasChanges) {
      emit(const UpdateReviewState.error('No review changes provided.'));
      return;
    }

    emit(const UpdateReviewState.loading());

    try {
      await reviewsRepo.updateReview(reviewId, updateReviewModel);
      emit(const UpdateReviewState.success());
    } catch (errorMessage) {
      emit(UpdateReviewState.error(errorMessage.toString()));
    }
  }
}
