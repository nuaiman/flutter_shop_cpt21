import 'package:flutter/material.dart';
import 'package:flutter_shop_cpt21/widgets/empty_cart.dart';
import 'package:flutter_shop_cpt21/widgets/full_cart.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/Cart-screen';

  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List _products = [];
    return Scaffold(
      body: _products.isEmpty ? EmptyCart() : FullCart(),
    );
  }
}
