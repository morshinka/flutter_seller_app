import 'package:dartz/dartz.dart';
import 'package:flutter_seller_app/data/model/products_response_model.dart';

import 'package:http/http.dart' as http;

import '../../common/global_variables.dart';

import 'auth_local_datasource.dart';

class ProductRemoteDatasource {
  Future<Either<String, ProductResponseModel>> getPorducts() async {
    final userId = await AuthLocalDatasource().getUserId();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    final response = await http.get(
      Uri.parse('${GlobarVariables.baseUrl}/api/product?user_id=$userId'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return Right(ProductResponseModel.fromJson(response.body));
    } else {
      return const Left("Server Error");
    }
  }
}
