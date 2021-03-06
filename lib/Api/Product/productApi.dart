import 'dart:convert';
import 'package:ecommerceapi/Api/Product/ProductIDModel.dart';
import 'package:ecommerceapi/Api/Product/productModel.dart';
import 'package:ecommerceapi/Api/api_client.dart';
import 'package:http/http.dart';

class ProductApi {
  ApiClient apiClient = ApiClient();

  Future<List<ProductModel>> getProduct() async {
    String productPath = '/products';
    Response response = await apiClient.invokeAPI(productPath, 'GET', null);
    return ProductModel.listFromJson(jsonDecode(response.body));
  }

  Future<List<ProductIdModel>> getProductID(String id) async {
    String productPath = '/products/';
    Response response =
        await apiClient.invokeAPI(productPath + id, 'GET', null);
    return ProductIdModel.listFromJson(jsonDecode(response.body));
  }
}
