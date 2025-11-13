import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_smart_app/models/order_model.dart';
import 'package:shop_smart_app/widgets/custom_app_bar.dart';
import 'package:shop_smart_app/widgets/empty_cart_widget.dart';
import '../../../providers/order_provider.dart';
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
    final ordersProvider = Provider.of<OrdersProvider>(context);
    return Scaffold(
      appBar: CustomAppBar(),
      body: FutureBuilder<List<OrdersModel>>(
        future: ordersProvider.fetchOrder(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: SelectableText(
                "An error has been occured ${snapshot.error}",
              ),
            );
          } else if (!snapshot.hasData || ordersProvider.getOrders.isEmpty) {
            return EmptyBagWidget(
              imagePath: AssetsManager.order,
              title: "No orders has been placed yet",
              subtitle: "",
              buttonText: "Shop now",
            );
          }
          return ListView.separated(
            itemCount: snapshot.data!.length,
            itemBuilder: (ctx, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                child: OrdersWidget(
                  ordersModel: ordersProvider.getOrders[index],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
          );
        }),
      ),
    );
  }
}
