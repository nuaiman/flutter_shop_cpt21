import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_cpt21/screens/auth/login_screen.dart';
import 'package:flutter_shop_cpt21/services/global_methods.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/Signup-screen';

  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  void _chanageVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  final _formKey = GlobalKey<FormState>();

  String _email = '';
  String _password = '';
  String _fullName = '';
  late int _phoneNumber;
  File? _image;
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  GlobalMethods _globalMethods = GlobalMethods();

  Future _getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _image = File(image!.path);
    });
  }

  late bool _isVisible;

  void _submitData() async {
    final _isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    var date = DateTime.now().toString();
    var parsedDate = DateTime.parse(date);
    var formattedDate =
        '${parsedDate.day}/${parsedDate.month}/${parsedDate.year}';
    if (_isValid) {
      setState(() {
        _isLoading = true;
      });
      _formKey.currentState!.save();
    }
    try {
      await _auth.createUserWithEmailAndPassword(
          email: _email.toLowerCase().trim(), password: _password.trim());

      final User? user = _auth.currentUser;
      final _uid = user!.uid;
      FirebaseFirestore.instance.collection('users').doc(_uid).set({
        'id': _uid,
        'name': _fullName,
        'email': _email,
        'phoneNumber': _phoneNumber,
        'imageUrl': '',
        'joinedDate': formattedDate,
        // 'createdAt': TimeStamp.now()
      });

      Navigator.canPop(context) ? Navigator.pop(context) : null;
    } catch (error) {
      _globalMethods.authDialog(context, error.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  FocusNode _passwordFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _numberFocusNode = FocusNode();

  @override
  void initState() {
    _isVisible = false;
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _emailFocusNode.dispose();
    _numberFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // RotatedBox(
          //   quarterTurns: 2,
          //   child: WaveWidget(
          //     config: CustomConfig(
          //       colors: [
          //         Colors.orangeAccent,
          //         Colors.tealAccent,
          //         Colors.pinkAccent,
          //         Colors.deepPurpleAccent,
          //       ],
          //       durations: [35000, 11000, 10800, 6000],
          //       heightPercentages: [0.01, 0.02, 0.03, 0.1],
          //       blur: const MaskFilter.blur(BlurStyle.solid, 0),
          //     ),
          //     heightPercentange: 0.2,
          //     size: const Size(double.infinity, double.infinity),
          //   ),
          // ),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 80),
                    Row(
                      children: [
                        InkWell(
                          onTap: _getImage,
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage:
                                _image == null ? null : FileImage(_image!),
                            child: Icon(
                              _image == null ? Icons.camera : null,
                              color: Colors.white,
                              size: 50,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Text(
                          'Signup',
                          style: TextStyle(fontSize: 65),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      onSaved: (value) {
                        _fullName = value!;
                      },
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(_numberFocusNode),
                      key: ValueKey('name'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      onSaved: (value) {
                        _phoneNumber = int.parse(value!);
                      },
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(_emailFocusNode),
                      // keyboardType: TextInputType.emailAddress,
                      key: ValueKey('number'),
                      validator: (value) {
                        if (value!.length < 11) {
                          return 'Phone number must be 11 units';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: Icon(Icons.phone),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      onSaved: (value) {
                        _email = value!;
                      },
                      onEditingComplete: () => FocusScope.of(context)
                          .requestFocus(_passwordFocusNode),
                      keyboardType: TextInputType.emailAddress,
                      key: ValueKey('email'),
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      focusNode: _passwordFocusNode,
                      onSaved: (value) {
                        _password = value!;
                      },
                      onEditingComplete: _submitData,
                      obscureText: _isVisible,
                      key: ValueKey('password'),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 8) {
                          return 'Password must be atleast 8 units';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Password',
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isVisible = !_isVisible;
                            });
                          },
                          icon: Icon(_isVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ElevatedButton(
                            onPressed: _submitData,
                            child: Text(
                              'Signup',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(LoginScreen.routeName);
                  },
                  child: Text(
                    'Login to Your Account',
                    style: TextStyle(color: Colors.deepPurpleAccent),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ],
      ),
    );
  }
}
