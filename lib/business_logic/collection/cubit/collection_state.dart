import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:byma_app/data/models/collection_model.dart';

part 'collection_state.freezed.dart';

@freezed
sealed class CollectionState with _$CollectionState {
  const factory CollectionState.initial() = _Initial;
  const factory CollectionState.loading() = _Loading;
  const factory CollectionState.success(List<CollectionModel> collection) = _Success;
  const factory CollectionState.error(String message) = _Error;
}