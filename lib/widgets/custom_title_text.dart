import 'package:flutter/material.dart';

class CustomTitleText extends StatelessWidget {
  const CustomTitleText({
    super.key, 
    required this.text, 
    this.fontSize = 20, 
    this.maxLines = 1, 
    this.fontWeight = FontWeight.bold, 
    this.color,
    this.textDecoration = TextDecoration.none,
  });

  final String text;
  final double fontSize;
  final int maxLines;
  final FontWeight? fontWeight;
  final Color? color;
  final TextDecoration textDecoration;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines : maxLines,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}