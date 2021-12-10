import 'package:flutter/material.dart';
import 'package:flutter_shop_cpt21/widgets/empty_cart.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/Cart-screen';

  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Screen'),
      ),
      body: SafeArea(
        child: EmptyCart(),
      ),
    );
  }
}
