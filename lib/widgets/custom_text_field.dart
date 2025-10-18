import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key, 
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Color(0xFF1D1E20),
      style: TextStyle(
        color: Color(0xFF1D1E20),
        fontSize: 20,
        fontWeight: FontWeight.w500,
        wordSpacing: 0.5,
        letterSpacing: 0.5,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          vertical: 16.0
        ),
        labelText: text,
        labelStyle: TextStyle(
          color: Color(0xFF8F959E),
          fontWeight: FontWeight.normal,
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFE7E8EA)
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFE7E8EA),
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFE7E8EA),
          ),
        ),
        
      ),
    );
  }
}
