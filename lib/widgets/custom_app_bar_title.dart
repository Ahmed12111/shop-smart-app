import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_smart_app/widgets/custom_title_text.dart';

class CustomAppBarTitle extends StatelessWidget {
  const CustomAppBarTitle({super.key, this.fontSize = 22});
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.blueAccent,
      highlightColor: Colors.red,
      period: Duration(seconds: 5),
      child: CustomTitleText(text: "ShopSmart", fontSize: fontSize),
    );
  }
}
