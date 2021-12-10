import 'package:flutter/material.dart';
import 'package:flutter_shop_cpt21/widgets/empty_cart.dart';
import 'package:flutter_shop_cpt21/widgets/full_cart.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/Cart-screen';

  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List _products = [];
    return !_products.isEmpty
        ? Scaffold(
            body: EmptyCart(),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('Cart'),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
            body: Container(
              margin: EdgeInsets.only(bottom: 60),
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (ctx, i) {
                  return FullCart();
                },
              ),
            ),
            bottomSheet: _bottomCheckoutSectiomn(),
          );
  }
}

Widget _bottomCheckoutSectiomn() {
  return SizedBox(
    width: double.infinity,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              'Total: \$ 450.00',
              style: TextStyle(
                fontSize: 18,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text(
              '   C H E C K O U T   ',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
