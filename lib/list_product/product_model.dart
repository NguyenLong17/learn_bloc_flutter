import 'dart:convert';

import 'package:flutter/material.dart';

class ProductModel {
  String? name;
  Color? color;
  int? price;

  ProductModel({
    this.name,
    this.color,
    this.price,
  });

  Map<String, dynamic> convertModelToJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['price'] = price;
    return data;
  }

  ProductModel.fromStringLocal(String data) {
    Map<String, dynamic> dataJson = jsonDecode(data);
    name = dataJson['name'];
    price = dataJson['price'];
  }

  @override
  bool operator == (Object object) {
    return (object is ProductModel) &&
    object.name == name &&
    object.price == price;
  }


}
