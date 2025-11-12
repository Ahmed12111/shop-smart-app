import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shop_smart_app/providers/cart_provider.dart';
import 'package:shop_smart_app/screens/cart/cart_screen.dart';
import 'package:shop_smart_app/screens/home_screen.dart';
import 'package:shop_smart_app/screens/profile_screen.dart';
import 'package:shop_smart_app/screens/search_screen.dart';

class RootsApp extends StatefulWidget {
  static const routName = '/RootsApp';
  const RootsApp({super.key});

  @override
  State<RootsApp> createState() => _RootsAppState();
}

class _RootsAppState extends State<RootsApp> {
  static int index = 0;

  late PageController controller;

  List<Widget> pages = const [
    HomeScreen(),
    SearchScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: index);
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: PageView(
          onPageChanged: (value) {
            setState(() {
              index = value;
            });
          },
          controller: controller,
          children: pages,
        ),

        bottomNavigationBar: NavigationBar(
          selectedIndex: index,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          height: kBottomNavigationBarHeight + 10,
          destinations: [
            NavigationDestination(
              selectedIcon: Icon(IconlyBold.home),
              icon: Icon(IconlyLight.home),
              label: "Home",
            ),
            NavigationDestination(
              selectedIcon: Icon(IconlyBold.search),
              icon: Icon(IconlyLight.search),
              label: "Search",
            ),
            NavigationDestination(
              selectedIcon: cartProvider.getCartItems.isEmpty
                  ? Icon(IconlyBold.bag2)
                  : Badge(
                      backgroundColor: Colors.blueAccent,
                      label: Text(cartProvider.getCartItems.length.toString()),
                      child: Icon(IconlyBold.bag2),
                    ),
              icon: cartProvider.getCartItems.isEmpty
                  ? Icon(IconlyLight.bag2)
                  : Badge(
                      backgroundColor: Colors.blueAccent,
                      label: Text(cartProvider.getCartItems.length.toString()),
                      child: Icon(IconlyLight.bag2),
                    ),
              label: "Cart",
            ),

            NavigationDestination(
              selectedIcon: Icon(IconlyBold.profile),
              icon: Icon(IconlyLight.profile),
              label: "Profile",
            ),
          ],
          onDestinationSelected: (value) {
            setState(() {
              index = value;
            });
            controller.jumpToPage(index);
          },
        ),
      ),
    );
  }
}
