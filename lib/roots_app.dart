import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shop_smart_app/providers/cart_provider.dart';
import 'package:shop_smart_app/providers/product_provider.dart';
import 'package:shop_smart_app/providers/user_provider.dart';
import 'package:shop_smart_app/providers/wishlist_provider.dart';
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
  bool isLoading = true;
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

  Future<void> fetchFCT() async {
    final productsProvider = Provider.of<ProductProvider>(
      context,
      listen: false,
    );
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final wishlistProvider = Provider.of<WishlistProvider>(
      context,
      listen: false,
    );

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      Future.wait({
        productsProvider.fetchProducts(),
        userProvider.fetchUserInfo(),
      });
      Future.wait({cartProvider.fetchCart(), wishlistProvider.fetchWishlist()});
    } catch (error) {
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void didChangeDependencies() {
    if (isLoading) {
      fetchFCT();
    }

    super.didChangeDependencies();
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
