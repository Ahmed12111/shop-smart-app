import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shop_smart_app/consts/theme_data.dart';
import 'package:shop_smart_app/firebase_options.dart';
import 'package:shop_smart_app/providers/cart_provider.dart';
import 'package:shop_smart_app/providers/order_provider.dart';
import 'package:shop_smart_app/providers/product_provider.dart';
import 'package:shop_smart_app/providers/theme_provider.dart';
import 'package:shop_smart_app/providers/user_provider.dart';
import 'package:shop_smart_app/providers/viewed_prod_provider.dart';
import 'package:shop_smart_app/providers/wishlist_provider.dart';
import 'package:shop_smart_app/roots_app.dart';
import 'package:shop_smart_app/screens/auth/login_screen.dart';
import 'package:shop_smart_app/screens/auth/register_screen.dart';
import 'package:shop_smart_app/screens/inner_screens/product_details.dart';
import 'package:shop_smart_app/screens/inner_screens/viewed_recently.dart';
import 'package:shop_smart_app/screens/inner_screens/wishlist.dart';
import 'package:shop_smart_app/screens/search_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const ShopSmartApp());
}

class ShopSmartApp extends StatelessWidget {
  const ShopSmartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => WishlistProvider()),
        ChangeNotifierProvider(create: (context) => ViewedProdProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => OrdersProvider()),
      ],
      builder: (context, child) {
        return Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return MaterialApp(
              title: "Shop Smart",
              debugShowCheckedModeBanner: false,
              theme: Styles.themeData(
                isDark: themeProvider.getIsDark(),
                context: context,
              ),
              home: RootsApp(),
              routes: {
                ProductDetailsScreen.routName: (context) =>
                    ProductDetailsScreen(),
                WishlistScreen.routName: (context) => WishlistScreen(),
                ViewedRecentlyScreen.routName: (context) =>
                    ViewedRecentlyScreen(),
                RegisterScreen.routName: (context) => RegisterScreen(),
                LoginScreen.routName: (context) => LoginScreen(),
                SearchScreen.routName: (context) => SearchScreen(),
                RootsApp.routName: (context) => RootsApp(),
              },
            );
          },
        );
      },
    );
  }
}
