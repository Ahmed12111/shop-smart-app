import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_smart_app/providers/viewed_prod_provider.dart';
import 'package:shop_smart_app/services/assets_manager.dart';
import 'package:shop_smart_app/widgets/custom_app_bar_title.dart';
import 'package:shop_smart_app/widgets/empty_cart_widget.dart';
import 'package:shop_smart_app/widgets/products/custom_product_widget.dart';

class ViewedRecentlyScreen extends StatelessWidget {
  static const routName = '/ViewedRecentlyScreen';
  const ViewedRecentlyScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final viewedProvider = Provider.of<ViewedProdProvider>(context);

    return viewedProvider.getviewedProdItems.isEmpty
        ? Scaffold(
            body: EmptyBagWidget(
              imagePath: AssetsManager.shoppingBasket,
              title: "Your Viewed recently is empty",
              subtitle:
                  'Looks like you didn\'t add anything yet to your cart \ngo ahead and start shopping now',
              buttonText: "Back to shop Now",
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
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: DynamicHeightGridView(
                itemCount: viewedProvider.getviewedProdItems.values
                    .toList()
                    .length,
                builder: ((context, index) {
                  return CustomProductWidget(
                    productId: viewedProvider.getviewedProdItems.values
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
