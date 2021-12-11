import 'package:flutter/material.dart';
import 'package:flutter_shop_cpt21/widgets/feeds_product.dart';

class FeedsScreen extends StatelessWidget {
  static const routeName = '/Feeds-screen';

  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            return const FeedsProduct();
          },
        ),
      ),
    );
  }
}
