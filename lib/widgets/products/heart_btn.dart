import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shop_smart_app/providers/wishlist_provider.dart';

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
  @override
  Widget build(BuildContext context) {
    final wishListProvider = Provider.of<WishlistProvider>(context);

    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, color: widget.color),
      child: IconButton(
        style: IconButton.styleFrom(shape: const CircleBorder()),
        onPressed: () {
          wishListProvider.addOrRemoveFromWishlist(productId: widget.productId);
        },
        icon: wishListProvider.isProductInWishlist(productId: widget.productId)
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
