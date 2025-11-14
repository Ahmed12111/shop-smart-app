import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_smart_app/providers/wishlist_provider.dart';
import 'package:shop_smart_app/services/assets_manager.dart';
import 'package:shop_smart_app/widgets/custom_app_bar_title.dart';
import 'package:shop_smart_app/widgets/custom_dialog_widget.dart';
import 'package:shop_smart_app/widgets/empty_cart_widget.dart';
import 'package:shop_smart_app/widgets/products/custom_product_widget.dart';

class WishlistScreen extends StatelessWidget {
  static const routName = '/WishlistScreen';
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wishListProvider = Provider.of<WishlistProvider>(context);

    return wishListProvider.getWishlistItems.isEmpty
        ? Scaffold(
            body: EmptyBagWidget(
              imagePath: AssetsManager.bagWish,
              title: 'Your Wishlist is Empty',
              subtitle:
                  'Looks like you haven\'t added anything to your wishlist yet. Start shopping now!',
              buttonText: 'Back To Shopping',
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: CustomAppBarTitle(),
              centerTitle: true,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_new_outlined),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    DialogHelper.showDeleteConfirmation(
                      context,
                      itemName: 'All Wishlist',
                      message:
                          'This action cannot be undone. Are you sure you want to delete your wishlist?',
                      onDelete: () async {
                        await wishListProvider.clearWishlistFromFirebase();
                        wishListProvider.clearLocalWishlist();
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.delete_forever_rounded,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: DynamicHeightGridView(
                itemCount: wishListProvider.getWishlistItems.values
                    .toList()
                    .length,
                builder: ((context, index) {
                  return CustomProductWidget(
                    productId: wishListProvider.getWishlistItems.values
                        .toList()[index]
                        .productId,
                  );
                }),
                crossAxisCount: 2,
              ),
            ),
          );
  }
}
