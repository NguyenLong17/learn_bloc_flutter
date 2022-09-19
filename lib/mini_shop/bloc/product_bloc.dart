import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitState());

  List<Product> listProduct = [];
  List<Product> listProductCart = [];

  // bool iconSelected = false;
  Product? productSelected;

  void createData() {
    for (Map<String, dynamic> obj in productData) {
      final model = Product(
          id: obj['Id'],
          name: obj['Name'],
          price: obj['Price'],
          icon: obj['Icon']);
      listProduct.add(model);
    }
    emit(ProductState());
  }

  void addItemToCart(Product product) {
    if (product.icon == false) {
      listProductCart.add(product);
    }
    product.icon = true;
    emit(ProductState());
  }

  void reloadData(List<Product> listNew) {
    listProductCart = List.from(listNew);
    emit(ProductState());
  }
}

class ProductInitState extends ProductState {}

class ProductState {}

const productData = [
  {
    'Id': 1,
    'Name': 'Gà KFC',
    'Price': 10,
    'Icon': false,
  },
  {
    'Id': 2,
    'Name': 'Trà sữa',
    'Price': 20,
    'Icon': false,
  },
  {
    'Id': 3,
    'Name': 'Vịt quay bắc kinh',
    'Price': 42,
    'Icon': false,
  },
  {
    'Id': 4,
    'Name': 'Sữa chua hạ long',
    'Price': 42,
    'Icon': false,
  },
  {
    'Id': 5,
    'Name': 'Gà ủ muối',
    'Price': 42,
    'Icon': false,
  },
  {
    'Id': 6,
    'Name': 'Bia Tiger',
    'Price': 42,
    'Icon': false,
  },
  {
    'Id': 7,
    'Name': 'Spaghetti',
    'Price': 42,
    'Icon': false,
  },
  {
    'Id': 8,
    'Name': 'Pizza',
    'Price': 42,
    'Icon': false,
  },
  {
    'Id': 9,
    'Name': 'Bánh mì hội an',
    'Price': 42,
    'Icon': false,
  },
  {
    'Id': 10,
    'Name': 'Phở thìn',
    'Price': 42,
    'Icon': false,
  },
  {
    'Id': 11,
    'Name': 'Chân gà',
    'Price': 42,
    'Icon': false,
  },
  {
    'Id': 12,
    'Name': 'Coffee',
    'Price': 42,
    'Icon': false,
  },
  {
    'Id': 13,
    'Name': 'Trà',
    'Price': 42,
    'Icon': false,
  },
  {
    'Id': 14,
    'Name': 'Xôi',
    'Price': 42,
    'Icon': false,
  },
  {
    'Id': 15,
    'Name': 'Cơm',
    'Price': 42,
    'Icon': false,
  },
];

class Product {
  int id;
  String name;
  Color color;
  bool icon;

  int price;

  Product(
      {required this.id,
      required this.name,
      required this.price,
      required this.icon})
      : color = Colors.primaries[Random().nextInt(Colors.primaries.length)];
}
