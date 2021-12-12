import 'package:flutter/material.dart';
import 'package:flutter_shop_cpt21/screens/cart_screen.dart';
import 'package:flutter_shop_cpt21/widgets/feeds_product.dart';

import '../wishlist_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const routeName = '/product-details-screen';

  const ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  GlobalKey previewContainer = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: _bottomSheet(),
      appBar: AppBar(
        title: Text('Details'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(WishlistScreen.routeName);
            },
            icon: const Icon(Icons.favorite),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(CartScreen.routeName);
            },
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            foregroundDecoration: BoxDecoration(color: Colors.black12),
            height: MediaQuery.of(context).size.height * 0.45,
            width: double.infinity,
            child: Image.network(
                'https://images.pexels.com/photos/4600998/pexels-photo-4600998.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260'),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 300),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.save),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.share),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Text(
                                'Title',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '\$ 250.00',
                              style: TextStyle(
                                fontSize: 21,
                                color: Colors.purple,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 3),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey,
                          height: 1,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey,
                          height: 1,
                        ),
                      ),
                      _contentRow(
                        title: 'Brand',
                        nameTitle: 'Brand Name',
                      ),
                      _contentRow(
                        title: 'Quantity',
                        nameTitle: '12 left',
                      ),
                      _contentRow(
                        title: 'Category',
                        nameTitle: 'Category Name',
                      ),
                      _contentRow(
                        title: 'Popularity',
                        nameTitle: 'Popular',
                      ),
                      const SizedBox(height: 15),
                      const Divider(
                        thickness: 1,
                        color: Colors.grey,
                        height: 1,
                      ),
                      Container(
                        color: Colors.black54,
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                'No reviews yet',
                                style: TextStyle(
                                  fontSize: 21,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                'Be The First To Review!',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            const SizedBox(height: 70),
                            const Divider(
                              thickness: 1,
                              color: Colors.grey,
                              height: 1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'Suggested Product: ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 30),
                  width: double.infinity,
                  height: 300,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 7,
                    itemBuilder: (ctx, i) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FeedsProduct(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _contentRow extends StatelessWidget {
  final String title;
  final String nameTitle;
  const _contentRow({
    required this.title,
    required this.nameTitle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 16, right: 16),
      child: Row(
        children: [
          Text(
            '${title}: ',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            nameTitle,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class _bottomSheet extends StatelessWidget {
  const _bottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            color: Colors.pinkAccent,
            height: 50,
            child: Center(
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'ADD TO CART',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            color: Colors.white,
            height: 50,
            child: Center(
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'BUY NOW',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.grey.withOpacity(0.2),
            height: 50,
            child: Center(
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite_border),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
