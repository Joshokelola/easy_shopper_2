
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:fpdart/fpdart.dart';

import '../../model/t_product.dart';
import '../../../controller/error/failure.dart';

abstract interface class GetProductRepo {
  Future<Either<Failure, List<Items>>> getProducts({
    required String apiKey,
    required String appId,
    required String organisationId,
  });
}

class GetProductsRepoImpl implements GetProductRepo {
  @override
  Future<Either<Failure,  List<Items>>> getProducts(
      {required String apiKey,
      required String appId,
      required String organisationId}) async {
    Response response;
    final dio = Dio();
    try {
      response = await dio.get(
          'https://api.timbu.cloud/products?organization_id=$organisationId&reverse_sort=false&Appid=$appId&Apikey=$apiKey');

      var responseData = response.data['items'] as List<dynamic>;
      var items = responseData.map((e) {
        return Items(
          id: e['id'],
          name: e['name'],
          description: e['description'],
          uniqueId: e['unique_id'],
          isAvailable: e['isAvailable'],
          imageUrl: e['photos'][0]['url'],
          currentPrice: e['current_price'][0]['NGN'][0].truncate().toString(),
        );
      }).toList();
      // debugPrint(items.map((e) {
      //   return e.toString();
      // }).toList().toString());
      return right(items);
    } on DioException catch (e) {
      return left(Failure(e.message!));
    }
  }
}
