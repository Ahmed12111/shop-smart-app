import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key, 
    required this.backGroundColor, 
    required this.textColor, 
    required this.text, 
    required this.onPressed,
    this.iconData, 
  });
  final Color backGroundColor;
  final Color textColor;
  final String text;
  final Widget? iconData;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: iconData,
      style: TextButton.styleFrom(
        backgroundColor: backGroundColor,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(10),
        ),
      ),
      label: Text(
        text, 
        style: TextStyle(
          color: textColor,
          fontSize: 17,
        ),
      ),
    );
  }
}
