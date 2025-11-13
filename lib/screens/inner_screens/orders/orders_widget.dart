import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shop_smart_app/models/order_model.dart';

import 'package:shop_smart_app/widgets/custom_sub_title.dart';
import 'package:shop_smart_app/widgets/custom_title_text.dart';

class OrdersWidget extends StatefulWidget {
  const OrdersWidget({super.key, required this.ordersModel});
  final OrdersModel ordersModel;
  @override
  State<OrdersWidget> createState() => _OrdersWidgetState();
}

class _OrdersWidgetState extends State<OrdersWidget> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.memory(
              base64Decode(widget.ordersModel.imageUrl),
              height: size.width * 0.3,
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
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: CustomTitleText(
                          text: widget.ordersModel.productTitle,
                          maxLines: 2,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const CustomSubTitle(text: 'Price:  ', fontSize: 15),
                      Flexible(
                        child: CustomSubTitle(
                          text: "${widget.ordersModel.price} \$",
                          fontSize: 15,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  CustomSubTitle(
                    text: "Qty: ${widget.ordersModel.quantity}",
                    fontSize: 15,
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
