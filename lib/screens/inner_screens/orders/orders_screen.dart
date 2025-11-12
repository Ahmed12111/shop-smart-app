import 'package:flutter/material.dart';
import 'package:shop_smart_app/widgets/custom_title_text.dart';
import 'package:shop_smart_app/widgets/empty_cart_widget.dart';
import '../../../services/assets_manager.dart';
import 'orders_widget.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/OrderScreen';

  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool isEmptyOrders = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const CustomTitleText(text: 'Placed orders')),
      body: isEmptyOrders
          ? EmptyBagWidget(
              imagePath: AssetsManager.orderSvg,
              title: "No orders has been placed yet",
              subtitle: "",
              buttonText: "Shop now",
            )
          : ListView.separated(
              itemCount: 15,
              itemBuilder: (ctx, index) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                  child: OrdersWidgetFree(),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
            ),
    );
  }
}
