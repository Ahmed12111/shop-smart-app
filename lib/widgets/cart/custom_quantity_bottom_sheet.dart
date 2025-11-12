import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:shop_smart_app/models/cart_model.dart';
import 'package:shop_smart_app/providers/cart_provider.dart';
import 'package:shop_smart_app/widgets/custom_sub_title.dart';

class CustomQuantityBottomSheet extends StatelessWidget {
  const CustomQuantityBottomSheet({super.key, required this.cartModel});
  final CartModel cartModel;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Column(
      children: <Widget>[
        Gap(10),
        SizedBox(
          width: 50,
          height: 3,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),

        Expanded(
          child: ListView.builder(
            itemCount: 15,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  cartProvider.updateQuantity(
                    productId: cartModel.productId,
                    quantity: index + 1,
                  );
                  Navigator.pop(context);
                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomSubTitle(text: "${index + 1}"),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
