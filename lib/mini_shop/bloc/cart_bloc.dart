
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_shop/mini_shop/bloc/product_bloc.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitState());
  List<Product> listProductCart = [];

  void getDataCart(List<Product> listProduct) {
    for (final index in listProduct) {
      listProductCart.add(index);
    }
    emit(CartState());
  }

  void removeProduct(Product product) {
    for (final index in listProductCart) {
      if (index.id == product.id) {
        listProductCart.remove(product);
        index.icon = false;
      }
    }
    emit(CartState());
  }

  int totalPrice(List<Product> listProduct) {
    int totalPrice = 0;
    for (final index in listProduct) {
      totalPrice = totalPrice + index.price;
    }
    return totalPrice;
  }
}

class CartState {}

class CartInitState extends CartState {}
