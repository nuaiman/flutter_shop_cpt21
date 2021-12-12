import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_cpt21/screens/inner_screens/product_details_screen.dart';

class FeedsProduct extends StatefulWidget {
  const FeedsProduct({Key? key}) : super(key: key);

  @override
  _FeedsProductState createState() => _FeedsProductState();
}

class _FeedsProductState extends State<FeedsProduct> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(ProductDetailsScreen.routeName);
      },
      child: Stack(
        children: [
          Container(
            height: 300,
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: Colors.grey),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      constraints: BoxConstraints(
                          minHeight: 170,
                          maxHeight: MediaQuery.of(context).size.height * 0.21),
                      child: Center(
                        child: Image.network(
                            'https://images.pexels.com/photos/6612384/pexels-photo-6612384.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Description',
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 18,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$ 299.99',
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Quantity: 12 left',
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: const Icon(Icons.more_horiz),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Badge(
            toAnimate: true,
            animationType: BadgeAnimationType.slide,
            shape: BadgeShape.square,
            badgeColor: Colors.deepPurpleAccent,
            borderRadius: BorderRadius.circular(8),
            badgeContent:
                const Text('New', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
