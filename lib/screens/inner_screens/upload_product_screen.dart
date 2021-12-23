import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shop_cpt21/services/global_methods.dart';
import 'package:image_picker/image_picker.dart';

class UploadProductScreen extends StatefulWidget {
  static const routeName = '/upload-product-screen';

  const UploadProductScreen({Key? key}) : super(key: key);

  @override
  _UploadProductScreenState createState() => _UploadProductScreenState();
}

class _UploadProductScreenState extends State<UploadProductScreen> {
  @override
  final _formKey = GlobalKey<FormState>();

  var _productTitle = '';
  var _productPrice = '';
  var _productCategory = '';
  var _productBrand = '';
  var _productDescription = '';
  var _productQuantity = '';

  final TextEditingController _categoryContrroller = TextEditingController();
  final TextEditingController _brandContrroller = TextEditingController();

  late String _categoryValue;
  late String _brandValue;

  GlobalMethods _globalMethods = GlobalMethods();

  File? _image;

  _showAlertDialog(BuildContext context, String title, String content) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        });
  }

  void _trySubmit() async {
    final _isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (_isValid) {
      _formKey.currentState!.save();
    }
  }

  Future _getCameraImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      _image = File(image!.path);
    });
  }

  Future _getGalleryImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _image = File(image!.path);
    });
  }

  void _removeImage() {
    setState(() {
      _image = null;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        flex: 3,
                        child: TextFormField(
                          key: ValueKey('title'),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Please enter a title';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(labelText: 'Title'),
                          onSaved: (val) {
                            _productTitle = val.toString();
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        flex: 1,
                        child: TextFormField(
                          key: ValueKey('price'),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Price is missing';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('r[0-9]')),
                          ],
                          decoration: InputDecoration(labelText: 'Price \$'),
                          onSaved: (val) {
                            _productPrice = val.toString();
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: _image == null
                            ? Container(
                                height: 200,
                                width: 200,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 2, color: Colors.grey),
                                ),
                              )
                            : Container(
                                height: 200,
                                width: 200,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 2, color: Colors.grey),
                                ),
                                child: Image.file(
                                  _image!,
                                  fit: BoxFit.contain,
                                ),
                              ),
                      ),
                      Column(
                        children: [
                          TextButton.icon(
                            onPressed: _getCameraImage,
                            icon: const Icon(Icons.camera_alt),
                            label: Text('Camera'),
                          ),
                          TextButton.icon(
                            onPressed: _getGalleryImage,
                            icon: const Icon(Icons.image),
                            label: Text('Gallery'),
                          ),
                          TextButton.icon(
                            onPressed: _removeImage,
                            icon: const Icon(Icons.remove_circle),
                            label: Text('Remove'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              key: ValueKey('category'),
                              controller: _categoryContrroller,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Please enter a caategory';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'Add a new Category',
                              ),
                              onSaved: (val) {
                                _productCategory = val.toString();
                              },
                            ),
                          ),
                          DropdownButton(
                            items: [
                              DropdownMenuItem(
                                child: Text('Phones'),
                                value: 'Phones',
                              ),
                              DropdownMenuItem(
                                child: Text('Cloathes'),
                                value: 'Cloathes',
                              ),
                              DropdownMenuItem(
                                child: Text('Beauty & Health'),
                                value: 'Beaauty',
                              ),
                              DropdownMenuItem(
                                child: Text('Shoes'),
                                value: 'Shoes',
                              ),
                              DropdownMenuItem(
                                child: Text('Furniture'),
                                value: 'Furrniture',
                              ),
                              DropdownMenuItem(
                                child: Text('Watches'),
                                value: 'Watches',
                              ),
                            ],
                            hint: Text('Select a Category'),
                            value: _categoryValue,
                            onChanged: (String value) {
                              setState(() {
                                _categoryValue = value;
                                _categoryContrroller.text = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
