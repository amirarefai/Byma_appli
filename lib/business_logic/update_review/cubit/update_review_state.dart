part of 'update_review_cubit.dart';

@freezed
class UpdateReviewState with _$UpdateReviewState {
  const factory UpdateReviewState.initial() = _Initial;
  const factory UpdateReviewState.loading() = _Loading;
  const factory UpdateReviewState.success() = _Success;
  const factory UpdateReviewState.error(String message) = _Error;
}
