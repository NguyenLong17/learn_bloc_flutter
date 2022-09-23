import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_shop/list_product/list_product_cubit.dart';
import 'package:mini_shop/list_product/product_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    // TODO: implement initState
  }
  @override
  Widget build(BuildContext context) {
    final listProductCubit = BlocProvider.of<ListProductCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Giỏ hàng'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocBuilder<ListProductCubit, ProductState>(
        builder: (_, state) {
          int totalPrice = 0;
          for (ProductModel obj in listProductCubit.listProductSelected) {
            totalPrice += obj.price ?? 0;
          }
          return Container(
            color: Colors.yellow,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 32,
            ),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (_, index) {
                      ProductModel model =
                          listProductCubit.listProductSelected[index];
                      return _itemWidget(model, () {
                        listProductCubit.onRemoveItemSelected(model);
                      });
                    },
                    itemCount: listProductCubit.listProductSelected.length,
                  ),
                ),
                const Divider(color: Colors.black, height: 1),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Tổng tiền: $totalPrice',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _itemWidget(ProductModel model, Function onRemove) {
    return Row(
      children: [
        Expanded(child: Text('${model.name}')),
        InkWell(
          onTap: () {
            onRemove();
          },
          child: const Icon(Icons.remove_circle),
        )
      ],
    );
  }
}
