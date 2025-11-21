import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shop_smart_app/models/user_model.dart';
import 'package:shop_smart_app/providers/product_provider.dart';
import 'package:shop_smart_app/providers/theme_provider.dart';
import 'package:shop_smart_app/providers/user_provider.dart';
import 'package:shop_smart_app/screens/auth/login_screen.dart';
import 'package:shop_smart_app/screens/inner_screens/orders/orders_screen.dart';
import 'package:shop_smart_app/screens/inner_screens/viewed_recently.dart';
import 'package:shop_smart_app/screens/inner_screens/wishlist.dart';
import 'package:shop_smart_app/services/assets_manager.dart';
import 'package:shop_smart_app/services/auth_service.dart';
import 'package:shop_smart_app/services/my_app_methods.dart';
import 'package:shop_smart_app/widgets/custom_app_bar.dart';
import 'package:shop_smart_app/widgets/custom_dialog_widget.dart';
import 'package:shop_smart_app/widgets/custom_list_tile.dart';
import 'package:shop_smart_app/widgets/custom_sub_title.dart';
import 'package:shop_smart_app/widgets/custom_title_text.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  bool isLoading = true;
  UserModel? userModel;

  Future<void> fetchUserInfo() async {
    if (user == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      userModel = await userProvider.fetchUserInfo();
    } catch (error) {
      await MyAppMethods.showErrorORWarningDialog(
        context: context,
        subtitle: "An error has been occured $error",
        fct: () {},
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    fetchUserInfo();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final productProvider = Provider.of<ProductProvider>(
        context,
        listen: false,
      );
      productProvider.fetchProducts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            children: <Widget>[
              Visibility(
                visible: user == null ? true : false,
                child: CustomTitleText(
                  text: "Please login to have ultimate access",
                ),
              ),
              userModel == null
                  ? SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 65,
                            height: 65,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).cardColor,
                              border: Border.all(
                                width: 3,
                                color: Theme.of(context).cardColor,
                              ),
                              image: DecorationImage(
                                image:
                                    userModel?.userImage == null ||
                                        userModel!.userImage.isEmpty
                                    ? const AssetImage(
                                        'assets/images/placeholder.png',
                                      )
                                    : userModel!.userImage.startsWith('http')
                                    ? NetworkImage(userModel!.userImage)
                                    : MemoryImage(
                                        base64Decode(userModel!.userImage),
                                      ), // Direct Base64
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.03,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                CustomTitleText(text: userModel!.userName),

                                CustomSubTitle(text: userModel!.userEmail),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

              Padding(
                padding: EdgeInsets.only(left: 4, top: 24),
                child: Align(
                  alignment: AlignmentGeometry.centerLeft,
                  child: CustomTitleText(text: "General"),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 24,
                ),
                child: Column(
                  children: <Widget>[
                    user == null
                        ? SizedBox.shrink()
                        : CustomListTile(
                            iconData: IconlyLight.arrowRight2,
                            image: AssetsManager.orderSvg,
                            text: "All Orders",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return OrdersScreen();
                                  },
                                ),
                              );
                            },
                          ),
                    user == null
                        ? SizedBox.shrink()
                        : SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.03,
                          ),
                    user == null
                        ? SizedBox.shrink()
                        : CustomListTile(
                            iconData: IconlyLight.arrowRight2,
                            image: AssetsManager.wishlistSvg,
                            text: "Wish List",
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                WishlistScreen.routName,
                              );
                            },
                          ),
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
                    CustomListTile(
                      iconData: IconlyLight.arrowRight2,
                      image: AssetsManager.recent,
                      text: "Viewed Recently",
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          ViewedRecentlyScreen.routName,
                        );
                      },
                    ),
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
                    CustomListTile(
                      iconData: IconlyLight.arrowRight2,
                      image: AssetsManager.address,
                      text: "Address",
                      onTap: null,
                    ),
                  ],
                ),
              ),

              Divider(thickness: 1, indent: 15, endIndent: 15),

              Padding(
                padding: EdgeInsets.only(left: 4, top: 12, bottom: 12),
                child: Align(
                  alignment: AlignmentGeometry.centerLeft,
                  child: CustomTitleText(text: "Settings"),
                ),
              ),

              SwitchListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 14),
                title: Row(
                  children: [
                    Image.asset(AssetsManager.theme, width: 55, height: 55),
                    SizedBox(width: MediaQuery.sizeOf(context).width * 0.03),
                    CustomSubTitle(text: "Change Mode"),
                  ],
                ),
                value: themeProvider.getIsDark(),
                onChanged: (val) {
                  themeProvider.setThemeDark(isDark: val);
                },
              ),

              Divider(thickness: 1, indent: 15, endIndent: 15),

              Padding(
                padding: EdgeInsets.only(left: 4, top: 12, bottom: 12),
                child: Align(
                  alignment: AlignmentGeometry.centerLeft,
                  child: CustomTitleText(text: "Others"),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                child: CustomListTile(
                  iconData: IconlyLight.arrowRight2,
                  image: AssetsManager.privacy,
                  text: "Privacy Policy",
                ),
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.05),

              ElevatedButton.icon(
                label: Text(
                  user == null ? "Login" : "Logout",
                  style: TextStyle(color: Colors.white),
                ),
                icon: Icon(
                  user == null ? Icons.login : IconlyLight.logout,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (user == null) {
                    Navigator.pushNamed(context, LoginScreen.routName);
                  } else {
                    DialogHelper.showWarning(
                      context,
                      title: "Are you sure to log out ?",
                      message: '',
                      onPositivePressed: () async {
                        AuthService.signOut();
                        Navigator.pushNamed(context, LoginScreen.routName);
                      },
                      onNegativePressed: () {
                        Navigator.pop(context);
                      },
                    );
                  }
                },
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
