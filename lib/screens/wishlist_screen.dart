import 'package:flutter/material.dart';
import 'package:flutter_shop_cpt21/widgets/empty_wishlist.dart';
import 'package:flutter_shop_cpt21/widgets/full_wishlist.dart';

class WishlistScreen extends StatelessWidget {
  static const routeName = '/wishlist-screen';

  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List _products = [];
    return !_products.isEmpty
        ? const Scaffold(
            body: EmptyWishlist(),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('Wishlist'),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
            body: Container(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (ctx, i) {
                  return FullWishlist();
                },
              ),
            ),
          );
  }
}
