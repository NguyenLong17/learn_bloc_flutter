import 'dart:convert';

import 'package:mini_shop/list_product/product_model.dart';

class ListProductUtils {
  Map<String, dynamic> convertModelToJson(ProductModel productModel) {
    Map<String, dynamic> dataJson = Map<String, dynamic>();
    dataJson['name'] = productModel.name;
    dataJson['price'] = productModel.price;

    return dataJson;
  }

  String convertMapToString(Map<String, dynamic> inputData) {
    String result = jsonEncode(inputData);
    return result;
  }
}
