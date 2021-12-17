import 'package:flutter/material.dart';
import 'package:flutter_shop_cpt21/screens/home_screen.dart';

class GlobalMethods {
  Future<void> showDialogue(BuildContext context, VoidCallback callback) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('All items will be deleted!'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('No')),
            TextButton(
                onPressed: () {
                  callback();
                  Navigator.pop(context);
                },
                child: Text('Yes')),
          ],
        );
      },
    );
  }
}
