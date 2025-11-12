import 'package:flutter/material.dart';
import 'package:shop_smart_app/consts/app_colors.dart';

class Styles {
  static ThemeData themeData({
    required bool isDark,
    required BuildContext context,
  }) {
    return ThemeData(
      brightness: isDark ? Brightness.dark : Brightness.light,
      scaffoldBackgroundColor: isDark
          ? AppColors.darkScaffoldColor
          : AppColors.lightScaffoldColor,
      cardColor: !isDark
          ? AppColors.lightCardColor
          : Color.fromARGB(255, 13, 6, 37),
      appBarTheme: AppBarTheme(
        backgroundColor: isDark
            ? AppColors.darkScaffoldColor
            : AppColors.lightScaffoldColor,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: isDark
              ? AppColors.darkElevatedButtonColor
              : AppColors.lightElevatedButtonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
