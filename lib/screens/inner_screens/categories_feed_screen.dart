import 'package:flutter/material.dart';
import 'package:flutter_shop_cpt21/models%20&%20providers/product.dart';
import 'package:flutter_shop_cpt21/widgets/feeds_product.dart';
import 'package:provider/provider.dart';

class CategoriesFeedScreen extends StatelessWidget {
  static const routeName = '/Categories-feeds-screen';

  const CategoriesFeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final catName = ModalRoute.of(context)!.settings.arguments as String;

    final productProvider = Provider.of<ProductProvider>(context);
    List<Product> productsList = productProvider.getByCatName(catName);

    return Scaffold(
      appBar: AppBar(
        title: Text(catName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: productsList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (ctx, i) {
            return ChangeNotifierProvider.value(
              value: productsList[i],
              child: FeedsProduct(),
            );
          },
        ),
      ),
    );
  }
}
