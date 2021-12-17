import 'package:flutter/material.dart';

class Cart with ChangeNotifier {
  final String cartId;
  final String title;
  final String imageUrl;
  final double price;
  final int quantity;

  Cart({
    required this.cartId,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });
}

class CartProvider with ChangeNotifier {
  Map<String, Cart> _cartList = {};
  Map<String, Cart> get carList => _cartList;

  double get totalAmount {
    double total = 0.0;
    _cartList.forEach((key, value) {
      total += value.quantity * value.price;
    });
    return total;
  }
}
