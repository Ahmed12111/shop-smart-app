import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';
import '../../providers/product_provider.dart';
import 'package:shop_smart_app/widgets/credit_card_widget.dart';
import 'package:shop_smart_app/widgets/custom_snack_bar_widget.dart';
import 'package:shop_smart_app/widgets/custom_sub_title.dart';
import 'package:shop_smart_app/widgets/custom_text_button.dart';
import 'package:shop_smart_app/widgets/custom_title_text.dart';

class CartBottomCheckout extends StatelessWidget {
  const CartBottomCheckout({super.key, required this.function});
  final Future<void> Function() function;

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final products = context.read<ProductProvider>();

    final totalPrice = cart
        .getTotal(productProvider: products)
        .toStringAsFixed(2);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      height: kBottomNavigationBarHeight + 25,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: const Border(top: BorderSide(width: 1, color: Colors.grey)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                child: CustomTitleText(
                  text: "Total products (${cart.getCartItems.length})",
                ),
              ),
              CustomSubTitle(text: "$totalPrice\$", color: Colors.blue),
            ],
          ),

          const Gap(20),

          // RIGHT SIDE — Checkout Button
          Expanded(
            child: CustomTextButton(
              borderRadius: 12,
              backgroundColor: Colors.blueAccent,
              text: "Checkout",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CheckoutCard(
                      totalPrice: double.parse(totalPrice),
                      onPaymentSuccess: (data) async {
                        await function();
                        CustomSnackbar.showSuccess(
                          context,
                          "The operation is performed successfully.",
                        );
                        Navigator.pop(context);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
