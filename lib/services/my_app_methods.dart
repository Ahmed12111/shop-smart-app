import 'package:flutter/material.dart';
import 'package:shop_smart_app/widgets/custom_sub_title.dart';
import 'package:shop_smart_app/widgets/custom_title_text.dart';
import 'assets_manager.dart';

class MyAppMethods {
  static Future<void> showErrorORWarningDialog({
    required BuildContext context,
    required String subtitle,
    required Function fct,
    bool isError = true,
  }) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(AssetsManager.warning, height: 60, width: 60),
              const SizedBox(height: 16.0),
              CustomSubTitle(text: subtitle, fontWeight: FontWeight.w600),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: !isError,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const CustomSubTitle(
                        text: "Cancel",
                        color: Colors.green,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      fct();
                      Navigator.pop(context);
                    },
                    child: const CustomSubTitle(text: "OK", color: Colors.red),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  static Widget _buildPickerOption(
    BuildContext context, {
    required IconData icon,
    required String text,
    required Function onTap,
  }) {
    return InkWell(
      onTap: () {
        onTap();
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      },
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 40, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 8),
            CustomSubTitle(text: text),
          ],
        ),
      ),
    );
  }

  static Future<void> imagePickerDialog({
    required BuildContext context,
    required Function camera,
    required Function gallery,
    required Function remove,
  }) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          title: const Center(child: CustomTitleText(text: "Choose option")),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildPickerOption(
                    context,
                    icon: Icons.camera_alt_outlined,
                    text: "Camera",
                    onTap: camera,
                  ),
                  _buildPickerOption(
                    context,
                    icon: Icons.image_outlined,
                    text: "Gallery",
                    onTap: gallery,
                  ),
                ],
              ),
              const Divider(thickness: 1, height: 20),
              TextButton.icon(
                onPressed: () {
                  remove();
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                  size: 22,
                ),
                label: const Text(
                  "Remove",
                  style: TextStyle(color: Colors.red, fontSize: 20),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static String getImageUrl(String? imageString) {
    if (imageString == null || imageString.isEmpty) {
      return '';
    }

    if (imageString.startsWith('http')) {
      return imageString;
    }

    return 'data:image/jpeg;base64,$imageString';
  }
}
