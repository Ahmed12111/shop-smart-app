import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String message;
  final IconData? icon;
  final Color? iconColor;
  final String? positiveButtonText;
  final String? negativeButtonText;
  final VoidCallback? onPositivePressed;
  final VoidCallback? onNegativePressed;
  final Widget? customContent;

  const CustomDialog({
    super.key,
    required this.title,
    required this.message,
    this.icon,
    this.iconColor,
    this.positiveButtonText = 'OK',
    this.negativeButtonText,
    this.onPositivePressed,
    this.onNegativePressed,
    this.customContent,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: (iconColor ?? Colors.blue).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 48, color: iconColor ?? Colors.blue),
              ),
              const SizedBox(height: 16),
            ],

            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),

            if (customContent != null)
              customContent!
            else
              Text(
                message,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 24),

            Row(
              children: [
                if (negativeButtonText != null) ...[
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        onNegativePressed?.call();
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                      child: Text(
                        negativeButtonText!,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                ],

                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      onPositivePressed?.call();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      positiveButtonText!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DialogHelper {
  static void showSuccess(
    BuildContext context, {
    required String title,
    required String message,
    VoidCallback? onPressed,
  }) {
    showDialog(
      context: context,
      builder: (context) => CustomDialog(
        title: title,
        message: message,
        icon: Icons.check_circle,
        iconColor: Colors.green,
        positiveButtonText: 'Great!',
        onPositivePressed: onPressed,
      ),
    );
  }

  static void showError(
    BuildContext context, {
    required String title,
    required String message,
    VoidCallback? onPressed,
  }) {
    showDialog(
      context: context,
      builder: (context) => CustomDialog(
        title: title,
        message: message,
        icon: Icons.error_outline,
        iconColor: Colors.red,
        positiveButtonText: 'OK',
        onPositivePressed: onPressed,
      ),
    );
  }

  static void showWarning(
    BuildContext context, {
    required String title,
    required String message,
    VoidCallback? onPositivePressed,
    VoidCallback? onNegativePressed,
  }) {
    showDialog(
      context: context,
      builder: (context) => CustomDialog(
        title: title,
        message: message,
        icon: Icons.warning_amber_rounded,
        iconColor: Colors.orange,
        positiveButtonText: 'Yes',
        negativeButtonText: 'No',
        onPositivePressed: onPositivePressed,
        onNegativePressed: onNegativePressed,
      ),
    );
  }

  static void showConfirmation(
    BuildContext context, {
    required String title,
    required String message,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
  }) {
    showDialog(
      context: context,
      builder: (context) => CustomDialog(
        title: title,
        message: message,
        icon: Icons.help_outline,
        iconColor: Colors.blue,
        positiveButtonText: confirmText,
        negativeButtonText: cancelText,
        onPositivePressed: onConfirm,
        onNegativePressed: onCancel,
      ),
    );
  }

  static void showDeleteConfirmation(
    BuildContext context, {
    required String itemName,
    required VoidCallback onDelete,
    required String message,
  }) {
    showDialog(
      context: context,
      builder: (context) => CustomDialog(
        title: 'Delete $itemName?',
        message: message,
        icon: Icons.delete_outline,
        iconColor: Colors.red,
        positiveButtonText: 'Delete',
        negativeButtonText: 'Cancel',
        onPositivePressed: onDelete,
      ),
    );
  }

  static void showCustom(
    BuildContext context, {
    required String title,
    required Widget content,
    IconData? icon,
    Color? iconColor,
    String positiveText = 'OK',
    String? negativeText,
    VoidCallback? onPositive,
    VoidCallback? onNegative,
  }) {
    showDialog(
      context: context,
      builder: (context) => CustomDialog(
        title: title,
        message: '',
        customContent: content,
        icon: icon,
        iconColor: iconColor,
        positiveButtonText: positiveText,
        negativeButtonText: negativeText,
        onPositivePressed: onPositive,
        onNegativePressed: onNegative,
      ),
    );
  }
}
