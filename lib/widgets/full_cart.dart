import 'package:flutter/material.dart';

class FullCart extends StatefulWidget {
  final String pId;
  final String id;
  final String title;
  final String imageUrl;
  final int quantity;
  final double price;
  const FullCart({
    Key? key,
    required this.id,
    required this.imageUrl,
    required this.pId,
    required this.price,
    required this.quantity,
    required this.title,
  }) : super(key: key);

  @override
  _FullCartState createState() => _FullCartState();
}

class _FullCartState extends State<FullCart> {
  @override
  Widget build(BuildContext context) {
    double subTotaal = widget.quantity * widget.price;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        width: double.infinity,
        height: 150,
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.grey),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 130,
              decoration: BoxDecoration(
                color: Colors.grey,
                image: DecorationImage(
                  image: NetworkImage(
                    widget.imageUrl,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          widget.title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: InkWell(
                          onTap: () {},
                          child: const Icon(
                            Icons.close,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      const Text(
                        'Price : ',
                        style: TextStyle(fontSize: 16),
                      ),
                      Flexible(
                        child: Text(
                          '\$${widget.price}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        'SubTotal : ',
                        style: TextStyle(fontSize: 16),
                      ),
                      Flexible(
                        child: Text(
                          '\$$subTotaal',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        'Shipping : ',
                        style: TextStyle(fontSize: 16),
                      ),
                      Flexible(
                        child: Text(
                          '\$450.00',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          '-',
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      Text(
                        widget.quantity.toString(),
                        style: TextStyle(fontSize: 20),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          '+',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
