import 'package:flutter/material.dart';

class AceAlertPopup extends StatelessWidget {
  final String title;
  final String message;
  final String? btnText;
  final VoidCallback? onPressed;
  final Color? color;
  final IconData? icon;

  const AceAlertPopup({
    super.key,
    required this.title,
    required this.message,
    this.btnText,
    this.onPressed,
    this.color,
    this.icon,  
  });

  @override
  Widget build(BuildContext context) {
    // Default color using the project's blue theme
    final primaryColor = color ?? const Color.fromARGB(255, 56, 92, 221);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Content Container
          Container(
            padding: const EdgeInsets.only(
              left: 20,
              top: 45 + 20, // Padding for the avatar
              right: 20,
              bottom: 20,
            ),
            margin: const EdgeInsets.only(top: 45), // Margin for the avatar
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 22),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      elevation: 0,
                    ),
                    onPressed: onPressed ?? () => Navigator.of(context).pop(),
                    child: Text(
                      btnText ?? "OK",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Top Icon
          Positioned(
            top: 0,
            child: CircleAvatar(
              backgroundColor: primaryColor,
              radius: 45,
              child: Icon(
                icon ?? Icons.info_outline,
                size: 50,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
