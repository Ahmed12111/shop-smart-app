// widgets/custom_text_field.dart
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Color? fillColor;
  final bool hasBorder;
  final VoidCallback? onSuffixIconTap;
  final VoidCallback? onPrefixIconTap;
  final ValueChanged<String>? onChanged;
  final int? maxLength;
  final TextAlign textAlign;
  final TextStyle? style;
  final FocusNode? focusNode;
  final FormFieldValidator<String>? validator;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmited;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.fillColor,
    this.hasBorder = false,
    this.onSuffixIconTap,
    this.onChanged,
    this.maxLength,
    this.textAlign = TextAlign.start,
    this.style,
    this.focusNode,
    this.validator,
    this.prefixIcon,
    this.onPrefixIconTap,
    this.textInputAction,
    this.onFieldSubmited,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: onFieldSubmited,
      textInputAction: textInputAction,
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textAlign: textAlign,
      maxLength: maxLength,
      style: style,
      focusNode: focusNode,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: fillColor ?? Colors.grey[200],
        counterText: maxLength != null ? '' : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: hasBorder
              ? const BorderSide(color: Colors.black)
              : BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: hasBorder
              ? const BorderSide(color: Colors.black)
              : BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: hasBorder
              ? const BorderSide(color: Colors.black, width: 2)
              : BorderSide.none,
        ),
        suffixIcon: suffixIcon != null
            ? IconButton(
                icon: Icon(suffixIcon, color: Colors.blueAccent),
                onPressed: onSuffixIconTap,
              )
            : null,
        prefixIcon: prefixIcon != null
            ? IconButton(icon: Icon(prefixIcon), onPressed: onPrefixIconTap)
            : null,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
      ),
    );
  }
}
