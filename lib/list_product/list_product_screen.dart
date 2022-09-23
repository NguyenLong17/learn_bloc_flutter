import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_shop/cart/cart_screen.dart';
import 'package:mini_shop/list_product/list_product_cubit.dart';
import 'package:mini_shop/list_product/product_model.dart';

class ListProductScreen extends StatefulWidget {
  const ListProductScreen({Key? key}) : super(key: key);

  @override
  State<ListProductScreen> createState() => _ListProductScreenState();
}

class _ListProductScreenState extends State<ListProductScreen> {
  bool _runFirstTime = true;

  void myInitState(ListProductCubit listProductCubit) async {
   await listProductCubit.convertListStringToListModel();
   await listProductCubit.getDataFromLocal();
  }

  @override
  Widget build(BuildContext context) {
    final listProductCubit = BlocProvider.of<ListProductCubit>(context);

    if (_runFirstTime) {
      _runFirstTime = false;
      myInitState(listProductCubit);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách sản phẩm'),
        actions: [
          InkWell(
            onTap: () async {
              final data = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );

              if (data != null) {
                listProductCubit.updateDataSelectedNew(data);
              }
            },
            child: BlocBuilder<ListProductCubit, ProductState>(
              builder: (_, state) {
                return Stack(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Icon(Icons.shopping_cart),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: const BoxDecoration(
                            color: Colors.red, shape: BoxShape.circle),
                        child: Center(
                          child: Text(
                              '${listProductCubit.listProductSelected.length}'),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ],
      ),
      body: BlocBuilder<ListProductCubit, ProductState>(
        // buildWhen: (context, ProductState state) {
        //   if (state is ProductGetSuccessState && listProductCubit.listProductSelected.isNotEmpty) {
        //     return
        //   }
        // },
        builder: (_, ProductState state) {
          if (state is ProductGettingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ProductGetSuccessState &&
              listProductCubit.listProduct.isNotEmpty) {
            List<ProductModel> listProducts = listProductCubit.listProduct;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  final product = listProducts[index];
                  return ItemProductWidget(
                    productModel: product,
                    onAddItem: (ProductModel model) {
                      listProductCubit.addItemToCart(model);
                    },
                    isSelected: listProductCubit.listProductSelected
                        .contains(listProducts[index]),
                  );
                },
                itemCount: listProducts.length,
                separatorBuilder: (_, index) {
                  return const SizedBox(height: 12);
                },
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}

class ItemProductWidget extends StatelessWidget {
  final ProductModel productModel;
  final Function(ProductModel productModel) onAddItem;
  final bool isSelected;

  const ItemProductWidget({
    Key? key,
    required this.productModel,
    required this.onAddItem,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          color: productModel.color ?? Colors.grey,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text('${productModel.name}'),
        ),
        isSelected
            ? const Icon(Icons.check)
            : InkWell(
                child: const Text(
                  'Thêm',
                ),
                onTap: () {
                  onAddItem(productModel);
                },
              ),
        const SizedBox(
          width: 32,
        ),
      ],
    );
  }
}
