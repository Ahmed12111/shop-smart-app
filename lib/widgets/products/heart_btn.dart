import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shop_smart_app/providers/wishlist_provider.dart';
import 'package:shop_smart_app/services/my_app_methods.dart';

class CustomHeartButtonWidget extends StatefulWidget {
  const CustomHeartButtonWidget({
    super.key,
    this.size = 28,
    this.color = Colors.transparent,
    required this.productId,
  });
  final double size;
  final Color color;
  final String productId;
  @override
  State<CustomHeartButtonWidget> createState() =>
      _CustomHeartButtonWidgetState();
}

class _CustomHeartButtonWidgetState extends State<CustomHeartButtonWidget> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final wishListProvider = Provider.of<WishlistProvider>(context);

    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, color: widget.color),
      child: IconButton(
        style: IconButton.styleFrom(shape: const CircleBorder()),
        onPressed: () async {
          setState(() {
            isLoading = true;
          });
          try {
            if (wishListProvider.getWishlistItems.containsKey(
              widget.productId,
            )) {
              wishListProvider.removeWishlistItemFromFirebase(
                productId: widget.productId,
                wishlistId:
                    wishListProvider.getWishlistItems[widget.productId]!.id,
              );
            } else {
              wishListProvider.addToWishlistFirebase(
                productId: widget.productId,
                context: context,
              );
            }

            await wishListProvider.fetchWishlist();
          } catch (e) {
            MyAppMethods.showErrorORWarningDialog(
              context: context,
              subtitle: e.toString(),
              fct: () {},
            );
          } finally {
            setState(() {
              isLoading = false;
            });
          }
        },
        icon: isLoading
            ? Center(child: CircularProgressIndicator(strokeWidth: 4))
            : wishListProvider.isProductInWishlist(productId: widget.productId)
            ? Icon(IconlyBold.heart, size: widget.size, color: Colors.redAccent)
            : Icon(
                IconlyLight.heart,
                size: widget.size,
                color: Colors.blueAccent,
              ),
      ),
    );
  }
}
