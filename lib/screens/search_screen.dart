import 'package:flutter/material.dart';
import 'package:flutter_shop_cpt21/models%20&%20providers/product.dart';
import 'package:flutter_shop_cpt21/widgets/feeds_product.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search-screen';
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<SearchScreen> {
  @override
  late TextEditingController _searchTextController;
  final FocusNode _node = FocusNode();
  void initState() {
    super.initState();
    _searchTextController = TextEditingController();
    _searchTextController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _node.dispose();
    _searchTextController.dispose();
  }

  late List<Product> _searchList;
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductProvider>(context);
    final productsList = productsData.products();
    return Scaffold(
      body: _searchTextController.text.isNotEmpty && _searchList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Icon(
                    Icons.search,
                    size: 60,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    'No results found',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: _searchTextController.text.isNotEmpty
                    ? _searchList.length
                    : productsList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (ctx, i) {
                  return ChangeNotifierProvider.value(
                    value: _searchTextController.text.isNotEmpty
                        ? _searchList[i]
                        : productsList[i],
                    child: FeedsProduct(),
                  );
                },
              ),
            ),
      bottomSheet: TextField(
        onChanged: (value) {
          // _searchTextController.text.toLowerCase();
          setState(() {
            _searchList = productsData.getBySearch(value);
          });
        },
        controller: _searchTextController,
        minLines: 1,
        focusNode: _node,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          prefixIcon: Icon(
            Icons.search,
          ),
          hintText: 'Search',
          filled: true,
          fillColor: Theme.of(context).cardColor,
          suffixIcon: IconButton(
            onPressed: _searchTextController.text.isEmpty
                ? null
                : () {
                    _searchTextController.clear();
                    _node.unfocus();
                  },
            icon: Icon(Icons.close,
                color: _searchTextController.text.isNotEmpty
                    ? Colors.red
                    : Colors.grey),
          ),
        ),
      ),
    );
  }
}
