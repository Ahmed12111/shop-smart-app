import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:shop_smart_app/providers/cart_provider.dart';
import 'package:shop_smart_app/services/assets_manager.dart';
import 'package:shop_smart_app/widgets/cart/custom_bottom_checkout.dart';
import 'package:shop_smart_app/widgets/cart/custom_cart_widget.dart';
import 'package:shop_smart_app/widgets/custom_app_bar_title.dart';
import 'package:shop_smart_app/widgets/custom_dialog_widget.dart';
import 'package:shop_smart_app/widgets/empty_cart_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return cartProvider.getCartItems.isEmpty
        ? Scaffold(
            body: EmptyBagWidget(
              imagePath: AssetsManager.shoppingBasket,
              title: "Your cart is empty",
              subtitle:
                  'Looks like you didn\'t add anything yet to your cart \ngo ahead and start shopping now',
              buttonText: "Shop Now",
              isButtoned: false,
              onButtonPressed: () {},
            ),
          )
        : Scaffold(
            bottomSheet: const CartBottomCheckout(),
            appBar: AppBar(
              title: CustomAppBarTitle(),
              centerTitle: true,
              leading: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: SvgPicture.asset(AssetsManager.smartLogo),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    DialogHelper.showDeleteConfirmation(
                      context,
                      itemName: 'All Cart',
                      message:
                          'This action cannot be undone. Are you sure you want to delete your cart?',
                      onDelete: () {
                        cartProvider.clearLocalCart();
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.delete_forever_rounded,
                    size: 20,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartProvider.getCartItems.length,
                    itemBuilder: (context, index) {
                      return ChangeNotifierProvider.value(
                        value: cartProvider.getCartItems.values
                            .toList()
                            .reversed
                            .toList()[index],
                        child: CartWidget(),
                      );
                    },
                  ),
                ),

                Gap(90),
              ],
            ),
          );
  }
}
