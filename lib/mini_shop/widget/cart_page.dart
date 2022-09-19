import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_shop/app.dart';
import 'package:mini_shop/mini_shop/bloc/cart_bloc.dart';
import 'package:mini_shop/mini_shop/bloc/product_bloc.dart';

class CartPage extends StatefulWidget {
  final List<Product> listProductSelected;

  const CartPage({
    super.key,
    required this.listProductSelected,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartCubit _cartCubit = CartCubit();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cartCubit.getDataCart(widget.listProductSelected);
    print('list product selected: ${widget.listProductSelected.length}');
    print('list cart ${_cartCubit.listProductCart.length}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Cart',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context, _cartCubit.listProductCart);
            },
            icon: const Icon(
              Icons.arrow_back_outlined,
            )),
      ),
      backgroundColor: Colors.yellow,
      body: BlocBuilder<CartCubit, CartState>(
        bloc: _cartCubit,
        builder: (context, state) {
          return buildBody();
        },
      ),
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        Expanded(
          flex: 6,
          child: ListView.separated(
              itemBuilder: (context, index) {
                final product = _cartCubit.listProductCart[index];
                return buildItem(product);
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(
                    height: 8,
                  ),
              itemCount: _cartCubit.listProductCart.length),
        ),
        const Divider(
          color: Colors.black,
        ),
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Text(
              'Total price: ${_cartCubit.totalPrice(_cartCubit.listProductCart)}',
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildItem(Product product) {
    return Container(
      padding: const EdgeInsets.all(32),
      alignment: Alignment.topLeft,
      child: Center(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add_task_outlined),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                product.name,
                style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                    fontSize: 20),
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                  onPressed: () {
                    _cartCubit.removeProduct(product);
                    print('xoa: ${product.name}');
                  },
                  icon: const Icon(Icons.remove_circle_outline_sharp)),
            ),
          ],
        ),
      ),
    );
  }
}
