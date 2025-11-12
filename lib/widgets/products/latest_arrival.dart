import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_smart_app/models/product_model.dart';
import 'package:shop_smart_app/providers/cart_provider.dart';
import 'package:shop_smart_app/providers/product_provider.dart';
import 'package:shop_smart_app/providers/viewed_prod_provider.dart';
import 'package:shop_smart_app/widgets/custom_snack_bar_widget.dart';
import 'package:shop_smart_app/widgets/custom_sub_title.dart';
import '../../screens/inner_screens/product_details.dart';
import 'heart_btn.dart';

class LatestArrivalProductsWidget extends StatelessWidget {
  const LatestArrivalProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final productModel = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final productProvider = Provider.of<ProductProvider>(
      context,
      listen: false,
    );
    final viewedProvider = Provider.of<ViewedProdProvider>(
      context,
      listen: false,
    );

    final getCurrentProduct = productProvider.findProductById(
      productModel.productId,
    );

    // ✅ Prevent null product crashes
    if (getCurrentProduct == null) {
      return const SizedBox.shrink();
    }

    Size size = MediaQuery.of(context).size;

    // ✅ Safe Base64 decoding
    Uint8List imageBytes;
    try {
      imageBytes = base64Decode(productModel.productImage);
    } catch (_) {
      imageBytes = Uint8List(0);
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {
          viewedProvider.addProductToHistory(productId: productModel.productId);
          await Navigator.pushNamed(
            context,
            ProductDetailsScreen.routName,
            arguments: productModel.productId,
          );
        },
        child: SizedBox(
          width: size.width * 0.45,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.memory(
                    imageBytes,
                    height: size.width * 0.5,
                    alignment: Alignment.center,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: size.width * 0.5,
                        alignment: Alignment.center,
                        child: const Icon(Icons.error, size: 50),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 7),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productModel.productTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    FittedBox(
                      child: Row(
                        children: [
                          CustomHeartButtonWidget(
                            productId: getCurrentProduct.productId,
                          ),
                          IconButton(
                            onPressed: () {
                              if (cartProvider.isProductInCart(
                                productId: getCurrentProduct.productId,
                              )) {
                                CustomSnackbar.showError(
                                  context,
                                  "This product is already in cart!",
                                );
                                return;
                              }

                              cartProvider.addProductToCart(
                                productId: getCurrentProduct.productId,
                              );

                              CustomSnackbar.showSuccess(
                                context,
                                "Product added to cart successfully.",
                              );
                            },
                            icon: Icon(
                              cartProvider.isProductInCart(
                                    productId: getCurrentProduct.productId,
                                  )
                                  ? Icons.check
                                  : Icons.add_shopping_cart_rounded,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    FittedBox(
                      child: CustomSubTitle(
                        text: "${productModel.productPrice} \$",
                        color: Colors.blue,
                      ),
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
