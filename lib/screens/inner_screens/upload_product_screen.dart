import 'dart:io';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

  String? _categoryValue;
  String? _brandValue;
  String _url = '';
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  GlobalMethods _globalMethods = GlobalMethods();
  var uuid = Uuid();

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
    try {
      if (_image == null) {
        return _globalMethods.authDialog(context, 'Please provide an image');
      } else {
        setState(() {
          _isLoading = true;
        });
        final ref = FirebaseStorage.instance
            .ref()
            .child('productImages')
            .child(_productTitle + '.jpg');
        await ref.putFile(_image!);
        _url = await ref.getDownloadURL();
        final User? user = _auth.currentUser;
        final _uid = user!.uid;
        final productId = uuid.v4();
        await FirebaseFirestore.instance
            .collection('products')
            .doc(productId)
            .set({
          'createdAt': Timestamp.now(),
          'userId': _uid,
          'productId': productId,
          'productTitle': _productTitle,
          'productPrice': _productPrice,
          'productDescription': _productDescription,
          'productCategory': _productCategory,
          'productImage': _url,
          'productBrand': _productBrand,
          'productQuantity': _productQuantity,
        });

        Navigator.canPop(context) ? Navigator.pop(context) : null;
      }
    } catch (error) {
      _globalMethods.authDialog(context, error.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
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
      bottomSheet: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _trySubmit,
          child: _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Text(
                  'S U B M i T',
                  style: TextStyle(color: Colors.white),
                ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
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
                    ],
                  ),

                  const SizedBox(height: 10),
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
                            // FilteringTextInputFormatter.allow(RegExp('r[0-9]')),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: InputDecoration(labelText: 'Price \$'),
                          onSaved: (val) {
                            _productPrice = val.toString();
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
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
                      DropdownButton<String>(
                        items: [
                          DropdownMenuItem<String>(
                            child: Text('Phones'),
                            value: 'Phones',
                          ),
                          DropdownMenuItem<String>(
                            child: Text('Clothes'),
                            value: 'Clothes',
                          ),
                          DropdownMenuItem<String>(
                            child: Text('Beauty & health'),
                            value: 'Beauty',
                          ),
                          DropdownMenuItem<String>(
                            child: Text('Shoes'),
                            value: 'Shoes',
                          ),
                          DropdownMenuItem<String>(
                            child: Text('Funiture'),
                            value: 'Funiture',
                          ),
                          DropdownMenuItem<String>(
                            child: Text('Watches'),
                            value: 'Watches',
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _categoryValue = value.toString();
                            _categoryContrroller.text = value.toString();

                            print(_productCategory);
                          });
                        },
                        hint: Text('Select a Category'),
                        value: _categoryValue,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 9),
                          child: Container(
                            child: TextFormField(
                              controller: _brandContrroller,

                              key: ValueKey('Brand'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Brand is missed';
                                }
                                return null;
                              },
                              //keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: 'Brand',
                              ),
                              onSaved: (value) {
                                _productBrand = value.toString();
                              },
                            ),
                          ),
                        ),
                      ),
                      DropdownButton<String>(
                        items: [
                          DropdownMenuItem<String>(
                            child: Text('Brandless'),
                            value: 'Brandless',
                          ),
                          DropdownMenuItem<String>(
                            child: Text('Addidas'),
                            value: 'Addidas',
                          ),
                          DropdownMenuItem<String>(
                            child: Text('Apple'),
                            value: 'Apple',
                          ),
                          DropdownMenuItem<String>(
                            child: Text('Dell'),
                            value: 'Dell',
                          ),
                          DropdownMenuItem<String>(
                            child: Text('H&M'),
                            value: 'H&M',
                          ),
                          DropdownMenuItem<String>(
                            child: Text('Nike'),
                            value: 'Nike',
                          ),
                          DropdownMenuItem<String>(
                            child: Text('Samsung'),
                            value: 'Samsung',
                          ),
                          DropdownMenuItem<String>(
                            child: Text('Huawei'),
                            value: 'Huawei',
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _brandValue = value.toString();
                            _brandContrroller.text = value.toString();
                          });
                        },
                        hint: Text('Select a Brand'),
                        value: _brandValue,
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        //flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 9),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            key: ValueKey('Quantity'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Quantity is missed';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Quantity',
                            ),
                            onSaved: (value) {
                              _productQuantity = value.toString();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                      key: ValueKey('Description'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'product description is required';
                        }
                        return null;
                      },
                      //controller: this._controller,
                      maxLines: 10,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        //  counterText: charLength.toString(),
                        labelText: 'Description',
                        hintText: 'Product description',
                        border: OutlineInputBorder(),
                      ),
                      onSaved: (value) {
                        _productDescription = value.toString();
                      },
                      onChanged: (text) {
                        // setState(() => charLength -= text.length);
                      }),
                  //    SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
