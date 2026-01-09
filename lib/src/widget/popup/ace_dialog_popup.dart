import 'package:aceui/aceui.dart';
import 'package:flutter/material.dart';

class AceAlertPopup extends StatelessWidget {
  final String title;
  final String message;
  final String? btnText;
  final VoidCallback? onPressed;
  final Color? color;
  final bool isCancel;

  const AceAlertPopup({
    super.key,
    required this.title,
    required this.message,
    this.btnText,
    this.onPressed,
    this.color,
    required this.isCancel,
  });

  @override
  Widget build(BuildContext context) {
    // Default color using the project's blue theme
    final primaryColor = color ?? const Color.fromARGB(255, 56, 92, 221);

    return Container(
      padding: const EdgeInsets.all(16.0),
      height: 200,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(message),
          const SizedBox(height: 15),
          if (isCancel == true) ...[
            Row(
              children: [
                AceButton(
                  color: primaryColor,
                  colorText: Colors.white,
                  label: btnText ?? "OK",
                  onPressed: onPressed,
                ),
                AceButton(
                  color: primaryColor,
                  colorText: Colors.white,
                  label: "Cancel",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ] else ...[
            AceButton(
              color: primaryColor,
              colorText: Colors.white,
              label: btnText ?? "OK",
              onPressed: onPressed,
            ),
          ],
        ],
      ),
    );
  }

  /// Helper method to show the popup
  static Future<void> show(
    BuildContext context, {
    required String title,
    required String message,
    String? btnText,
    VoidCallback? onPressed,
    Color? color,
    required bool isCancel,
  }) {
    return showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      builder: (context) {
        return AceAlertPopup(
          title: title,
          message: message,
          btnText: btnText,
          onPressed: onPressed,
          color: color,
          isCancel: isCancel,
        );
      },
    );
  }
}
