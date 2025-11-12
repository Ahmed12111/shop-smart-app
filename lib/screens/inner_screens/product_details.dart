import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:shop_smart_app/providers/cart_provider.dart';
import 'package:shop_smart_app/providers/product_provider.dart';
import 'package:shop_smart_app/widgets/custom_app_bar_title.dart';
import 'package:shop_smart_app/widgets/custom_snack_bar_widget.dart';
import 'package:shop_smart_app/widgets/custom_sub_title.dart';
import 'package:shop_smart_app/widgets/products/heart_btn.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const routName = '/ProductDetails';
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final productProvider = Provider.of<ProductProvider>(
      context,
      listen: false,
    );
    final getCurrentProduct = productProvider.findProductById(productId);
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const CustomAppBarTitle(),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.canPop(context) ? Navigator.pop(context) : null;
          },
          icon: const Icon(Icons.arrow_back_ios, size: 18),
        ),
      ),
      body: getCurrentProduct == null
          ? SizedBox.shrink()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    Image.memory(
                      base64Decode(getCurrentProduct.productImage),
                      height: size.width * 0.7,
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
                    const SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                // flex: 5,
                                child: Text(
                                  getCurrentProduct.productTitle,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 14),
                              CustomSubTitle(
                                text: "${getCurrentProduct.productPrice}\$",
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CustomHeartButtonWidget(
                                  // color: ,
                                  size: 32,
                                  productId: getCurrentProduct.productId,
                                ),
                                SizedBox(width: 20),
                                Expanded(
                                  child: SizedBox(
                                    height: kBottomNavigationBarHeight - 10,
                                    child: ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blueAccent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        if (cartProvider.isProductInCart(
                                          productId:
                                              getCurrentProduct.productId,
                                        )) {
                                          CustomSnackbar.showError(
                                            context,
                                            "This roduct is aleredy in cart!",
                                          );
                                        }
                                        cartProvider.addProductToCart(
                                          productId:
                                              getCurrentProduct.productId,
                                        );

                                        CustomSnackbar.showSuccess(
                                          context,
                                          "Product is added to cart Successfully.",
                                        );
                                      },
                                      icon: Icon(
                                        cartProvider.isProductInCart(
                                              productId:
                                                  getCurrentProduct.productId,
                                            )
                                            ? Icons.check
                                            : Icons.add_shopping_cart,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      label: Text(
                                        cartProvider.isProductInCart(
                                              productId:
                                                  getCurrentProduct.productId,
                                            )
                                            ? "In to cart"
                                            : "Add to cart",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomSubTitle(text: "About this item"),
                              CustomSubTitle(
                                text: getCurrentProduct.productCategory,
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),
                          CustomSubTitle(
                            text: getCurrentProduct.productDescription,
                          ),

                          Gap(40),
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
