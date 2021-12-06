import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  static const routeName = '/User-screen';

  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Screen'),
      ),
    );
  }
}
