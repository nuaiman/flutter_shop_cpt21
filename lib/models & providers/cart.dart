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

  void addToCart(String pId, String title, String imageUrl, double price) {
    if (_cartList.containsKey(pId)) {
      _cartList.update(
          pId,
          (value) => Cart(
                cartId: value.cartId,
                title: value.title,
                imageUrl: value.imageUrl,
                price: value.price,
                quantity: value.quantity + 1,
              ));
    } else {
      _cartList.putIfAbsent(
        pId,
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

  void decrementCartProductQuantity(
      String pId, String title, String imageUrl, double price) {
    if (_cartList.containsKey(pId)) {
      _cartList.update(
          pId,
          (value) => Cart(
                cartId: value.cartId,
                title: value.title,
                imageUrl: value.imageUrl,
                price: value.price,
                quantity: value.quantity - 1,
              ));
    }
    notifyListeners();
  }

  void removeItem(String pId) {
    _cartList.remove(pId);
    notifyListeners();
  }

  void clearCart() {
    _cartList.clear();
    notifyListeners();
  }
}
