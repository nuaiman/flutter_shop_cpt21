import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Order with ChangeNotifier {
  final String orderId;
  final String userId;
  final String productId;
  final String title;
  final String price;
  final String imageUrl;
  final String quantity;
  final Timestamp orderDate;

  Order({
    required this.orderId,
    required this.userId,
    required this.productId,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.orderDate,
    required this.quantity,
  });
}

class OrderProvider with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get getOrders => _orders;

  Future<void> fetchOrders() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;
    var _uid = user!.uid;

    await FirebaseFirestore.instance
        .collection('orders')
        .where('userId', isEqualTo: _uid)
        .get()
        .then((QuerySnapshot productSnapshot) {
      _orders.clear();
      productSnapshot.docs.forEach((element) {
        _orders.insert(
          0,
          Order(
            orderId: element.get('orderId'),
            userId: element.get('userId'),
            productId: element.get('productId'),
            title: element.get('title'),
            price: element.get('price').toString(),
            imageUrl: element.get('imageUrl'),
            orderDate: element.get('orderDate'),
            quantity: element.get('quantity').toString(),
          ),
        );
      });
    });
  }

  // Order getById(String prodId) {
  //   // return _orders.firstWhere((element) => element.id == prodId);
  // }
}
