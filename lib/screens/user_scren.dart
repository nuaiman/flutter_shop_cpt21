import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  static const routeName = '/User-screen';

  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            stretch: true,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background: Image.network(
                'https://images.pexels.com/photos/1537875/pexels-photo-1537875.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260',
                fit: BoxFit.cover,
              ),
              title: Row(
                children: const [
                  SizedBox(
                    width: 12,
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260'),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text('Fluttercraft')
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListView(
                primary: false,
                shrinkWrap: true,
                children: [
                  // User Bag
                  const _userTileText(text: 'User Bag'),
                  const _userTileHeightSpace(height: 10),
                  _userListTile(
                    onTap: () {},
                    lIcon: Icons.favorite,
                    color: Colors.red,
                    title: 'Wishlist',
                    tIcon: Icons.arrow_forward_ios,
                    tIconCallBack: () {},
                  ),
                  _userListTile(
                    onTap: () {},
                    lIcon: Icons.shopping_cart,
                    color: Colors.deepPurpleAccent,
                    title: 'Cart',
                    tIcon: Icons.arrow_forward_ios,
                    tIconCallBack: () {},
                  ),

                  // User Settings
                  const _userTileHeightSpace(height: 15),
                  const _userTileText(text: 'User Settings'),
                  const _userTileHeightSpace(height: 10),
                  Card(
                    child: SwitchListTile.adaptive(
                      secondary:
                          Icon(Icons.light_mode, color: Colors.amber.shade700),
                      title: const Text('Light Mode'),
                      value: false,
                      onChanged: (value) {},
                    ),
                  ),

                  // User Information
                  const _userTileHeightSpace(height: 15),
                  const _userTileText(text: 'User Informattion'),
                  const _userTileHeightSpace(height: 10),

                  _userListTile(
                    lIcon: Icons.email,
                    color: Colors.green,
                    title: 'Email',
                    subTitle: 'Email',
                    onTap: () {},
                  ),
                  _userListTile(
                    lIcon: Icons.call,
                    color: Colors.yellow.shade800,
                    title: 'Phone Number',
                    subTitle: 'Number',
                    onTap: () {},
                  ),
                  _userListTile(
                    lIcon: Icons.local_shipping,
                    color: Colors.indigo,
                    title: 'Address',
                    subTitle: 'Address',
                    onTap: () {},
                  ),
                  const _userListTile(
                    lIcon: Icons.watch_later,
                    color: Colors.redAccent,
                    title: 'Join Date',
                    subTitle: 'date',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: camel_case_types
class _userListTile extends StatelessWidget {
  final IconData lIcon;
  final Color color;
  final String title;
  final String? subTitle;
  final IconData? tIcon;
  final VoidCallback? tIconCallBack;
  final VoidCallback? onTap;
  const _userListTile({
    this.subTitle,
    this.tIcon,
    this.tIconCallBack,
    this.onTap,
    Key? key,
    required this.lIcon,
    required this.color,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(
          lIcon,
          color: color,
        ),
        title: Text(title),
        subtitle: subTitle == null ? null : Text(subTitle!),
        onTap: onTap,
        trailing: IconButton(
          icon: Icon(tIcon),
          onPressed: tIconCallBack,
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class _userTileHeightSpace extends StatelessWidget {
  final double height;
  const _userTileHeightSpace({
    Key? key,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}

// ignore: camel_case_types
class _userTileText extends StatelessWidget {
  final String text;
  const _userTileText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      ' $text',
      style: const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w700,
        // decoration: TextDecoration.underline,
      ),
    );
  }
}
