import 'package:dio/dio.dart';

class CollectionApi {
  final Dio dio;

  CollectionApi(this.dio);

  Future<Response> getAllCollections() async {
    return await dio.get('collections');
  }

  Future<Response> removeCollection(int collectionId) async {
    return await dio.delete('collections/$collectionId');
  }
  
  Future<Response> createCollection(String collectionName) async {
    return await dio.post('collections', data: {'name': collectionName});
  }

}