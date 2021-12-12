import 'package:flutter/material.dart';

class BrandsNavRailScreen extends StatefulWidget {
  static const routeName = '/brands-nav-rail';
  const BrandsNavRailScreen({Key? key}) : super(key: key);

  @override
  _BrandsNavRailScreenState createState() => _BrandsNavRailScreenState();
}

class _BrandsNavRailScreenState extends State<BrandsNavRailScreen> {
  late String routeArgs;
  late String brands;
  int _selectedIndex = 0;

  @override
  void didChangeDependencies() {
    routeArgs = ModalRoute.of(context)!.settings.arguments.toString();

    _selectedIndex = int.parse(routeArgs.substring(0, 1));

    if (_selectedIndex == 0) {
      setState(() {
        brands = 'Addidas';
      });
    }
    if (_selectedIndex == 1) {
      setState(() {
        brands = 'Apple';
      });
    }
    if (_selectedIndex == 2) {
      setState(() {
        brands = 'Dell';
      });
    }
    if (_selectedIndex == 3) {
      setState(() {
        brands = 'H&M';
      });
    }
    if (_selectedIndex == 4) {
      setState(() {
        brands = 'Huawei';
      });
    }
    if (_selectedIndex == 5) {
      setState(() {
        brands = 'Nike';
      });
    }
    if (_selectedIndex == 6) {
      setState(() {
        brands = 'Samsung';
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          LayoutBuilder(
            builder: (ctx, cons) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: cons.maxHeight),
                  child: IntrinsicHeight(
                    child: NavigationRail(
                      selectedLabelTextStyle: TextStyle(
                        letterSpacing: 2.5,
                        fontSize: 25,
                        decoration: TextDecoration.underline,
                      ),
                      leading: Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            'https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg',
                          ),
                        ),
                      ),
                      labelType: NavigationRailLabelType.all,
                      selectedIndex: _selectedIndex,
                      onDestinationSelected: (index) {
                        setState(() {
                          _selectedIndex = index;
                          if (_selectedIndex == 0) {
                            setState(() {
                              brands = 'Addidas';
                            });
                          }
                          if (_selectedIndex == 1) {
                            setState(() {
                              brands = 'Apple';
                            });
                          }
                          if (_selectedIndex == 2) {
                            setState(() {
                              brands = 'Dell';
                            });
                          }
                          if (_selectedIndex == 3) {
                            setState(() {
                              brands = 'H&M';
                            });
                          }
                          if (_selectedIndex == 4) {
                            setState(() {
                              brands = 'Huawei';
                            });
                          }
                          if (_selectedIndex == 5) {
                            setState(() {
                              brands = 'Nike';
                            });
                          }
                          if (_selectedIndex == 6) {
                            setState(() {
                              brands = 'Samsung';
                            });
                          }
                          // if (_selectedIndex == 7) {
                          //   setState(() {
                          //     brands = 'All';
                          //   });
                          // }
                        });
                      },
                      destinations: [
                        NavigationRailDestination(
                          icon: Icon(null),
                          label: RotatedBox(
                            quarterTurns: 3,
                            child: Text('Addidas'),
                          ),
                        ),
                        NavigationRailDestination(
                          icon: Icon(null),
                          label: RotatedBox(
                            quarterTurns: 3,
                            child: Text('Apple'),
                          ),
                        ),
                        NavigationRailDestination(
                          icon: Icon(null),
                          label: RotatedBox(
                            quarterTurns: 3,
                            child: Text('Dell'),
                          ),
                        ),
                        NavigationRailDestination(
                          icon: Icon(null),
                          label: RotatedBox(
                            quarterTurns: 3,
                            child: Text('H&M'),
                          ),
                        ),
                        NavigationRailDestination(
                          icon: Icon(null),
                          label: RotatedBox(
                            quarterTurns: 3,
                            child: Text('Huawei'),
                          ),
                        ),
                        NavigationRailDestination(
                          icon: Icon(null),
                          label: RotatedBox(
                            quarterTurns: 3,
                            child: Text('Nike'),
                          ),
                        ),
                        NavigationRailDestination(
                          icon: Icon(null),
                          label: RotatedBox(
                            quarterTurns: 3,
                            child: Text('Samsung'),
                          ),
                        ),
                        NavigationRailDestination(
                          icon: Icon(null),
                          label: RotatedBox(
                            quarterTurns: 3,
                            child: Text('All'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
