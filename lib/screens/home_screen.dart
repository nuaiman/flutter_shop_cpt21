import 'package:backdrop/app_bar.dart';
import 'package:backdrop/button.dart';
import 'package:backdrop/scaffold.dart';
import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_cpt21/widgets/back_layer.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/Home-screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _carouselImages = [
      Image.asset('assets/images/carousel1.png'),
      Image.asset('assets/images/carousel2.jpeg'),
      Image.asset('assets/images/carousel3.jpeg'),
      Image.asset('assets/images/carousel4.png'),
    ];

    return Scaffold(
      body: BackdropScaffold(
        headerHeight: MediaQuery.of(context).size.height * 0.2,
        backLayerBackgroundColor: Colors.grey.shade900,
        appBar: BackdropAppBar(
          title: const Text('Flutter Shop'),
          leading: const BackdropToggleButton(
            icon: AnimatedIcons.home_menu,
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const CircleAvatar(
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 14,
                  backgroundImage: NetworkImage(
                    'https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg',
                  ),
                ),
              ),
            ),
          ],
        ),
        backLayer: const BackLayer(),
        frontLayer: ListView(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              child: Carousel(
                images: _carouselImages,
                autoplay: true,
                animationDuration: Duration(seconds: 5),
                animationCurve: Curves.fastOutSlowIn,
                indicatorBgPadding: 7,
                dotSize: 5,
                boxFit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
