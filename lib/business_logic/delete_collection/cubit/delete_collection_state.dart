import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_collection_state.freezed.dart';

@freezed
sealed class DeleteCollectionState with _$DeleteCollectionState {
  const factory DeleteCollectionState.initial() = _Initial;
  const factory DeleteCollectionState.loading() = _Loading;
  const factory DeleteCollectionState.success() = _Success;
  const factory DeleteCollectionState.error(String message) = _Error;
}