import 'package:flutter/material.dart';
import 'package:shop_smart_app/widgets/custom_sub_title.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.iconData,
    required this.text,
    required this.image,
    this.onTap,
  });
  final IconData iconData;
  final String text;
  final String image;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
      leading: Image.asset(image),
      title: CustomSubTitle(text: text),
      trailing: Icon(iconData),
    );
  }
}
