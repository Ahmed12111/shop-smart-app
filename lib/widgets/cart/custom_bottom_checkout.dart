import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_smart_app/widgets/custom_sub_title.dart';
import 'package:shop_smart_app/widgets/custom_title_text.dart';

import '../../providers/cart_provider.dart';
import '../../providers/product_provider.dart';

class CartBottomCheckout extends StatelessWidget {
  const CartBottomCheckout({super.key, required this.function});
  final Function function;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: const Border(top: BorderSide(width: 1, color: Colors.grey)),
      ),
      child: SizedBox(
        height: kBottomNavigationBarHeight + 10,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      child: CustomTitleText(
                        text:
                            "Total (${cartProvider.getCartItems.length} products/${cartProvider.getQty()} Items)",
                      ),
                    ),
                    CustomSubTitle(
                      text:
                          "${cartProvider.getTotal(productProvider: productProvider).toStringAsFixed(2)}\$",
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  await function();
                },
                child: const Text("Checkout"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
