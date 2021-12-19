import 'package:flutter/material.dart';
import 'package:flutter_shop_cpt21/models%20&%20providers/cart.dart';
import 'package:flutter_shop_cpt21/models%20&%20providers/product.dart';
import 'package:flutter_shop_cpt21/models%20&%20providers/wishlist.dart';
import 'package:flutter_shop_cpt21/screens/inner_screens/product_details_screen.dart';
import 'package:provider/provider.dart';

class FeedsProductDialog extends StatelessWidget {
  final Product product;
  const FeedsProductDialog({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Consumer<WishlistProvider>(builder: (context, wp, _) {
              return CircleAvatar(
                backgroundColor: Colors.deepPurpleAccent,
                child: IconButton(
                  onPressed: () {
                    wp.addOrRemoveFromWishlist(
                      product.id,
                      product.title,
                      product.imageUrl,
                      product.price,
                    );
                  },
                  icon: wp.wishlistList.containsKey(product.id)
                      ? Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : Icon(
                          Icons.favorite,
                          color: Colors.white,
                        ),
                ),
              );
            }),
            Consumer<CartProvider>(builder: (context, cp, _) {
              return CircleAvatar(
                backgroundColor: Colors.deepPurpleAccent,
                child: IconButton(
                  onPressed: () {
                    cp.addToCart(
                      product.id,
                      product.title,
                      product.imageUrl,
                      product.price,
                    );
                  },
                  icon: cp.cartList.containsKey(product.id)
                      ? Icon(
                          Icons.shopping_cart,
                          color: Colors.red,
                        )
                      : Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                        ),
                ),
              );
            }),
            CircleAvatar(
              backgroundColor: Colors.deepPurpleAccent,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);

                  Navigator.of(context).pushNamed(
                    ProductDetailsScreen.routeName,
                    arguments: product.id,
                  );
                },
                icon: Icon(
                  Icons.remove_red_eye,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
