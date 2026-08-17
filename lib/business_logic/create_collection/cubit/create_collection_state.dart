import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_collection_state.freezed.dart';

@freezed
sealed class CreateCollectionState with _$CreateCollectionState {
  const factory CreateCollectionState.initial() = _Initial;
  const factory CreateCollectionState.loading() = _Loading;
  const factory CreateCollectionState.success() = _Success;
  const factory CreateCollectionState.error(String message) = _Error;
}