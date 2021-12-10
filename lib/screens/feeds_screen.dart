import 'package:flutter/material.dart';
import 'package:flutter_shop_cpt21/widgets/feeds_product.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
        child: StaggeredGridView.countBuilder(
          itemCount: 30,
          crossAxisCount: 4,
          itemBuilder: (BuildContext context, int i) => FeedsProduct(),
          staggeredTileBuilder: (int index) =>
              StaggeredTile.count(2, index.isEven ? 3 : 4),
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
        ),
      ),
    );
  }
}
