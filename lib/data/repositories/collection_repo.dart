import 'package:byma_app/data/models/collection_model.dart';
import 'package:byma_app/data/network/network_exceptions.dart';
import 'package:byma_app/data/web_services/collection_api.dart';

class CollectionRepo {
  final CollectionApi collectionApi;

  CollectionRepo(this.collectionApi);

  Future<List<CollectionModel>> fetchAllCollections() async {
    try {
      final response = await collectionApi.getAllCollections();

      final List<dynamic> data = response.data;

      final List<CollectionModel> collections = data
          .map((item) => CollectionModel.fromJson(item as Map<String, dynamic>))
          .toList();

      return collections;
    } catch (error) {
      final networkException = NetworkExceptions.getDioException(error);
      final errorMessage = NetworkExceptions.getErrorMessage(networkException);
      throw errorMessage;
    }
  }

   Future<void> removeCollection(int collectionId) async {
    try {
      await collectionApi.removeCollection(collectionId);
    } catch (error) {
      final networkException = NetworkExceptions.getDioException(error);
      final errorMessage = NetworkExceptions.getErrorMessage(networkException);
      throw errorMessage;
    }
  }

   Future<void> createCollection(String collectionName) async {
    try {
      await collectionApi.createCollection(collectionName);
    } catch (error) {
      final networkException = NetworkExceptions.getDioException(error);
      final errorMessage = NetworkExceptions.getErrorMessage(networkException);
      throw errorMessage;
    }
  }
}
