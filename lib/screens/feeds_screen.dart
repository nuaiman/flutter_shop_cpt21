import 'package:flutter/material.dart';

class FeedsScreen extends StatelessWidget {
  static const routeName = '/Feeds-screen';

  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feeds Screen'),
      ),
    );
  }
}
