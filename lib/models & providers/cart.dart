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
  Map<String, Cart> get cartList => _cartList;

  double get totalAmount {
    double total = 0.0;
    _cartList.forEach((key, value) {
      total += value.quantity * value.price;
    });
    return total;
  }

  void addToCart(String cId, String title, String imageUrl, double price) {
    if (_cartList.containsKey(cId)) {
      _cartList.update(
          cId,
          (value) => Cart(
                cartId: value.cartId,
                title: value.title,
                imageUrl: value.imageUrl,
                price: value.price,
                quantity: value.quantity + 1,
              ));
    } else {
      _cartList.putIfAbsent(
        cId,
        () => Cart(
            cartId: DateTime.now().toIso8601String(),
            title: title,
            imageUrl: imageUrl,
            price: price,
            quantity: 1),
      );
    }
    notifyListeners();
  }
}
