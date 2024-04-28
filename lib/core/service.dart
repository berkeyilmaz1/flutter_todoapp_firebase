import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:logger/web.dart';
import 'package:todoappvb/core/model/Product.dart';

class ApiService {
  late String _baseUrl;

  static final ApiService _instance = ApiService._privateConstructor();
  ApiService._privateConstructor() {
    _baseUrl = "https://todoappvb-default-rtdb.firebaseio.com/";
  }

  static ApiService getInstance() {
    return _instance;
  }

  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse("$_baseUrl/products.json"));

    final jsonResponse = json.decode(response.body);

    switch (response.statusCode) {
      case HttpStatus.ok:
        final productList = ProductList.fromJsonList(jsonResponse);
        return productList.products;
      case HttpStatus.unauthorized:
        Logger().e(jsonResponse);
        break;
    }
    Logger().e(jsonResponse);

    return Future.error(jsonResponse);
  }

  Future<void> addProducts(Product product) async {
    final jsonBody = json.encode(product.toJson());

    final response =
        await http.post(Uri.parse("$_baseUrl/products.json"), body: jsonBody);

    final jsonResponse = json.decode(response.body);

    switch (response.statusCode) {
      case HttpStatus.ok:
        return Future.value(true);
      case HttpStatus.unauthorized:
        Logger().e(jsonResponse);
        break;
    }
    Logger().e(jsonResponse);

    return Future.error(jsonResponse);
  }

  Future<void> removeProducts(String key) async {
    final response =
        await http.delete(Uri.parse("$_baseUrl/products/$key.json"));

    final jsonResponse = json.decode(response.body);

    switch (response.statusCode) {
      case HttpStatus.ok:
        return Future.value(true);
      case HttpStatus.unauthorized:
        Logger().e(jsonResponse);
        break;
    }
    Logger().e(jsonResponse);

    return Future.error(jsonResponse);
  }
}
