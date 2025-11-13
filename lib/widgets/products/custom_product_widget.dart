import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:shop_smart_app/providers/cart_provider.dart';
import 'package:shop_smart_app/providers/product_provider.dart';
import 'package:shop_smart_app/providers/viewed_prod_provider.dart';
import 'package:shop_smart_app/providers/wishlist_provider.dart';
import 'package:shop_smart_app/screens/inner_screens/product_details.dart';
import 'package:shop_smart_app/widgets/custom_snack_bar_widget.dart';
import 'package:shop_smart_app/widgets/custom_title_text.dart';
import 'package:shop_smart_app/widgets/products/heart_btn.dart';

class CustomProductWidget extends StatefulWidget {
  const CustomProductWidget({super.key, required this.productId});
  final String productId;
  @override
  State<CustomProductWidget> createState() => _CustomProductWidgetState();
}

class _CustomProductWidgetState extends State<CustomProductWidget> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final getCurrentProduct = productProvider.findProductById(widget.productId);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final viewedProvider = Provider.of<ViewedProdProvider>(context);
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: getCurrentProduct == null
          ? SizedBox.shrink()
          : GestureDetector(
              onTap: () {
                viewedProvider.addProductToHistory(
                  productId: getCurrentProduct.productId,
                );

                Navigator.pushNamed(
                  context,
                  ProductDetailsScreen.routName,
                  arguments: getCurrentProduct.productId,
                );
              },
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Image.memory(
                      base64Decode(getCurrentProduct.productImage),
                      height: size.width * 0.5,
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
                  Gap(10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 2,
                        child: CustomTitleText(
                          text: getCurrentProduct.productTitle,
                          maxLines: 2,
                        ),
                      ),
                      Flexible(
                        child: IconButton(
                          onPressed: () {
                            wishlistProvider.addOrRemoveFromWishlist(
                              productId: widget.productId,
                            );
                          },
                          icon:
                              wishlistProvider.isProductInWishlist(
                                productId: widget.productId,
                              )
                              ? CustomHeartButtonWidget(
                                  productId: widget.productId,
                                )
                              : CustomHeartButtonWidget(
                                  productId: widget.productId,
                                ),
                        ),
                      ),
                    ],
                  ),
                  Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 3,
                        child: CustomTitleText(
                          text: "${getCurrentProduct.productPrice}\$",
                        ),
                      ),
                      Flexible(
                        child: Material(
                          borderRadius: BorderRadius.circular(16.0),
                          color: Colors.lightBlue,
                          child: InkWell(
                            splashColor: Colors.red,
                            borderRadius: BorderRadius.circular(16.0),
                            onTap: () async {
                              if (cartProvider.isProductInCart(
                                productId: getCurrentProduct.productId,
                              )) {
                                CustomSnackbar.showError(
                                  context,
                                  "This product is already in cart!",
                                );
                                return;
                              }
                              try {
                                await cartProvider.addToCartFirebase(
                                  productId: getCurrentProduct.productId,
                                  qty: int.parse(
                                    getCurrentProduct.productQuantity,
                                  ),
                                  context: context,
                                );
                              } catch (e) {
                                CustomSnackbar.showError(context, e.toString());
                              }

                              CustomSnackbar.showSuccess(
                                context,
                                "Product is added to cart Successfully.",
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                cartProvider.isProductInCart(
                                      productId: getCurrentProduct.productId,
                                    )
                                    ? Icons.check
                                    : Icons.add_shopping_cart_rounded,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
    );
  }
}
