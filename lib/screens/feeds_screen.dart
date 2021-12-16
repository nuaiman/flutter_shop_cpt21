import 'package:flutter/material.dart';
import 'package:flutter_shop_cpt21/models%20&%20providers/product.dart';
import 'package:flutter_shop_cpt21/widgets/feeds_product.dart';
import 'package:provider/provider.dart';

class FeedsScreen extends StatelessWidget {
  static const routeName = '/Feeds-screen';

  FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    List<Product> productsList = productProvider.products();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Feeds Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: 20,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (ctx, i) {
            return FeedsProduct(
              id: productsList[i].id,
              description: productsList[i].description,
              imageUrl: productsList[i].imageUrl,
              isFavorite: productsList[i].isFavorite,
              price: productsList[i].price,
              quantity: productsList[i].quantity,
            );
          },
        ),
      ),
    );
  }
}
