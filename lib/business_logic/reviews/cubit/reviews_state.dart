import 'package:freezed_annotation/freezed_annotation.dart';

part 'reviews_state.freezed.dart';

@freezed
class ReviewsState with _$ReviewsState {
  const factory ReviewsState.initial() = _Initial;
  const factory ReviewsState.loading() = _Loading;
  const factory ReviewsState.success() = _Success;
  const factory ReviewsState.loaded(List<dynamic> reviews) = _Loaded;
  const factory ReviewsState.error(String message) = _Error;
}