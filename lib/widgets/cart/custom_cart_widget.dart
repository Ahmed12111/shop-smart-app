import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shop_smart_app/models/cart_model.dart';
import 'package:shop_smart_app/providers/cart_provider.dart';
import 'package:shop_smart_app/providers/product_provider.dart';
import 'package:shop_smart_app/providers/wishlist_provider.dart';
import 'package:shop_smart_app/widgets/cart/custom_quantity_bottom_sheet.dart';
import 'package:shop_smart_app/widgets/custom_dialog_widget.dart';
import 'package:shop_smart_app/widgets/custom_sub_title.dart';
import 'package:shop_smart_app/widgets/custom_title_text.dart';
import 'package:shop_smart_app/widgets/products/heart_btn.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cartModelProvider = Provider.of<CartModel>(context);
    final productModelProvider = Provider.of<ProductProvider>(context);
    final getCurrent = productModelProvider.findProductById(
      cartModelProvider.productId,
    );
    final cartProvider = Provider.of<CartProvider>(context);
    final wishlistProvider = Provider.of<WishlistProvider>(context);

    Size size = MediaQuery.of(context).size;
    return getCurrent == null
        ? SizedBox.shrink()
        : FittedBox(
            child: IntrinsicWidth(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.memory(
                        base64Decode(getCurrent.productImage),
                        height: size.width * 0.4,
                        width: size.width * 0.4,
                        alignment: Alignment.center,
                        fit: BoxFit.cover, // Better UX
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: size.width * 0.5,
                            alignment: Alignment.center,
                            child: const Icon(Icons.error, size: 50),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    IntrinsicWidth(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: size.width * 0.6,
                                child: CustomTitleText(
                                  text: getCurrent.productTitle,
                                  maxLines: 2,
                                ),
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      DialogHelper.showDeleteConfirmation(
                                        context,
                                        itemName: 'this product',
                                        message:
                                            'This action cannot be undone. Are you sure you want to delete your product?',
                                        onDelete: () async {
                                          await cartProvider
                                              .removeCartItemFromFirebase(
                                                cartId:
                                                    cartModelProvider.cartId,
                                                productId:
                                                    cartModelProvider.productId,
                                                qty: cartModelProvider.quantity,
                                              );
                                        },
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.clear,
                                      color: Colors.red,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      wishlistProvider.addOrRemoveFromWishlist(
                                        productId: getCurrent.productId,
                                      );
                                    },
                                    icon:
                                        wishlistProvider.isProductInWishlist(
                                          productId: getCurrent.productId,
                                        )
                                        ? CustomHeartButtonWidget(
                                            productId: getCurrent.productId,
                                          )
                                        : CustomHeartButtonWidget(
                                            productId: getCurrent.productId,
                                          ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              CustomSubTitle(
                                text: "${getCurrent.productPrice}\$",
                                fontSize: 20,
                                color: Colors.blue,
                              ),
                              const Spacer(),
                              OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  side: const BorderSide(
                                    width: 2,
                                    color: Colors.blue,
                                  ),
                                ),
                                onPressed: () async {
                                  await showModalBottomSheet(
                                    backgroundColor: Theme.of(
                                      context,
                                    ).scaffoldBackgroundColor,
                                    context: context,
                                    builder: (context) {
                                      return CustomQuantityBottomSheet(
                                        cartModel: cartModelProvider,
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(IconlyLight.arrowDown2),
                                label: Text(
                                  "Qty: ${cartModelProvider.quantity} ",
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
