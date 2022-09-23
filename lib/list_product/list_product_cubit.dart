import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_shop/list_product/list_product_utils.dart';
import 'package:mini_shop/list_product/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListProductCubit extends Cubit<ProductState> {
  ListProductCubit() : super(ProductInitState());

  List<ProductModel> listProduct = [];
  List<ProductModel> listProductSelected = [];
  SharedPreferences? sharedPreferences;

  void addItemToCart(ProductModel model) {
    if (!listProductSelected.contains(model)) {
      listProductSelected.add(model);
      print('${model.name}');
      saveDataToLocal();
      emit(ProductGetSuccessState());
    }
  }

  void onRemoveItemSelected(ProductModel model) {
    listProductSelected.remove(model);
    saveDataToLocal();
    emit(ProductGetSuccessState());
  }

  void updateDataSelectedNew(List<ProductModel> newSelected) {
    listProductSelected = newSelected;
    saveDataToLocal();
    emit(ProductGetSuccessState());
  }

  Future convertListStringToListModel() async {
    emit(ProductGettingState());

    await Future.delayed(const Duration(seconds: 2));

    for (int i = 0; i < itemNames.length; i++) {
      String item = itemNames[i];
      ProductModel model = ProductModel();

      model.name = item;
      model.price = 12;
      Random random = Random();
      model.color = Color.fromRGBO(
        random.nextInt(255),
        random.nextInt(255),
        random.nextInt(255),
        1,
      );

      listProduct.add(model);
    }
    saveDataToLocal();
    emit(ProductGetSuccessState());
  }

  Future saveDataToLocal() async {
    emit(ProductGettingState());
    sharedPreferences ??= await SharedPreferences.getInstance();
    List<String> listDataString = [];
    for (ProductModel productModel in listProductSelected) {
      Map<String, dynamic> dataJson =
          ListProductUtils().convertModelToJson(productModel);

      String dataString = ListProductUtils().convertMapToString(dataJson);

      listDataString.add(dataString);
    }
    print('Du lieu luu: ${listDataString.length}');
    await sharedPreferences!.setStringList('saveDataToLocal', listDataString);
    emit(ProductGetSuccessState());
  }

  Future getDataFromLocal() async {
    emit(ProductGettingState());
    // await Future.delayed(const Duration(seconds: 2));
    sharedPreferences ??= await SharedPreferences.getInstance();

    List<String>? listStringLocal =
        sharedPreferences!.getStringList('saveDataToLocal');
    if (listStringLocal != null && listStringLocal.isNotEmpty) {
      for (String obj in listStringLocal) {
        Map<String, dynamic> dataJson = jsonDecode(obj);

        ProductModel productModel = ProductModel();
        productModel.name = dataJson['name'];
        productModel.price = dataJson['price'];

        listProductSelected.add(productModel);
      }
      print('Data lay ra: ${listStringLocal.length}');
    }
    emit(ProductGetSuccessState());
  }

  List<String> itemNames = [
    'Gà KFC',
    'Trà sữa',
    'Vịt quay bắc kinh',
    'Sữa chua hạ long',
    'Gà ủ muối',
    'Bia Tiger',
    'Spaghetti',
    'Pizza',
    'Bánh mì hội an',
    'Phở thìn',
    'Chân gà',
    'Coffee',
    'Trà',
    'Xôi',
    'Cơm',
  ];
}

class ProductState {}

class ProductInitState extends ProductState {}

class ProductGettingState extends ProductState {}

class ProductGetSuccessState extends ProductState {}
