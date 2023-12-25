import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:flutter_seller_app/data/model/add_product_response_model.dart';
import 'package:flutter_seller_app/data/model/image_response_model.dart';
import 'package:flutter_seller_app/data/model/products_response_model.dart';
import 'package:flutter_seller_app/data/model/request/product_request_model.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../common/global_variables.dart';

import 'auth_local_datasource.dart';

class ProductRemoteDatasource {
  Future<Either<String, ProductResponseModel>> getPorducts() async {
    final userId = await AuthLocalDatasource().getUserId();
    final token = await AuthLocalDatasource().getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
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

  Future<Either<String, ImageResponseModel>> addImage(XFile image) async {
    final token = await AuthLocalDatasource().getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var request = http.MultipartRequest(
        'POST', Uri.parse('${GlobarVariables.baseUrl}/api/image/upload'));
    final fileName = image.name;
    final bytes = await image.readAsBytes();
    final multipartFile =
        http.MultipartFile.fromBytes('image', bytes, filename: fileName);

    request.files.add(multipartFile);
    request.headers.addAll(headers);
    final http.StreamedResponse streamedResponse = await request.send();
    final int statusCode = streamedResponse.statusCode;

    final Uint8List responseList = await streamedResponse.stream.toBytes();
    final String responseData = String.fromCharCodes(responseList);

    if (statusCode == 200) {
      return Right(ImageResponseModel.fromJson(responseData));
    } else {
      return const Left('Server Error');
    }
  }

  Future<Either<String, AddProductResponseModel>> addProduct(
      ProductRequestModel request) async {
    final token = await AuthLocalDatasource().getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await http.post(
      Uri.parse('${GlobarVariables.baseUrl}/api/product'),
      headers: headers,
      body: request.toJson(),
    );

    if (response.statusCode == 201) {
      return Right(AddProductResponseModel.fromJson(response.body));
    } else {
      return left("Server Error");
    }
  }
}
