import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_shop/app.dart';
import 'package:mini_shop/mini_shop/bloc/product_bloc.dart';
import 'package:mini_shop/mini_shop/widget/cart_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProductCubit _productCubit = ProductCubit();

  // Product? itemSelected;
  // bool icon = false;

  @override
  void initState() {
    _productCubit.createData();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context: context,
        title: 'Mini Shop',
        backgroudColor: Colors.blue,
        actions: [
          Center(
            child: BlocBuilder<ProductCubit, ProductState>(
              bloc: _productCubit,
              builder: (context, state) {
                return Stack(
                  alignment: Alignment.topRight,
                  children: [
                    IconButton(
                      onPressed: () async {
                        var data = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CartPage(
                                listProductSelected:
                                    _productCubit.listProductCart),
                          ),
                        );

                        _productCubit.reloadData(data);
                        print('Data nhan duoc: ${_productCubit.listProductCart.length}');
                      },
                      icon: const Icon(Icons.shopping_cart),
                    ),
                    Text(
                      '${_productCubit.listProductCart.length}',
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w900,
                      ),
                    )
                  ],
                );
              },
            ),
          ),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: BlocBuilder<ProductCubit, ProductState>(
          bloc: _productCubit,
          builder: (context, state) {
            return buildBody();
          },
        ),
      ),
    );
  }

  Widget buildBody() {
    return ListView.separated(
        itemBuilder: (context, index) {
          final product = _productCubit.listProduct[index];
          _productCubit.productSelected = product;
          return buildItem(product);
        },
        separatorBuilder: (BuildContext context, int index) => const SizedBox(
              height: 8,
            ),
        itemCount: _productCubit.listProduct.length);
  }

  Widget buildItem(Product product) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            color: product.color,
          ),
          const SizedBox(
            width: 16,
          ),
          Text(product.name),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      _productCubit.addItemToCart(product);
                    },
                    child: product.icon
                        ? const Icon(Icons.add_task)
                        : const Text('Thêm')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
