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
    final primaryColor = color ?? const Color.fromARGB(255, 56, 92, 221);

    return Container(
      padding: const EdgeInsets.all(20.0),
      // 1. HAPUS height: 200, ganti width infinity saja
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        // 2. MainAxisSize.min agar tinggi menyesuaikan isi konten (tidak full screen)
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Garis kecil di tengah atas (Handle bar) - Opsional biar cantik
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          Text(
            title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            message,
            style: const TextStyle(fontSize: 16, color: Colors.black54),
          ),
          const SizedBox(height: 25),

          // LOGIKA TOMBOL
          if (isCancel)
            Row(
              children: [
                // 3. Gunakan Expanded agar tombol berbagi ruang 50:50
                Expanded(
                  child: AceButton(
                    color:
                        Colors.grey.shade200, // Tombol Cancel biasanya abu-abu
                    colorText: Colors.black,
                    label: "Cancel",
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const SizedBox(width: 15), // Jarak antar tombol
                Expanded(
                  child: AceButton(
                    color: primaryColor,
                    colorText: Colors.white,
                    label: btnText ?? "OK",
                    onPressed: onPressed,
                  ),
                ),
              ],
            )
          else
            // Tombol OK Sendirian (Full Width)
            SizedBox(
              width: double.infinity,
              child: AceButton(
                color: primaryColor,
                colorText: Colors.white,
                label: btnText ?? "OK",
                onPressed: onPressed,
              ),
            ),

          // Tambahan jarak aman untuk HP yang punya gesture bar di bawah (iPhone X ke atas)
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  static Future<void> show(
    BuildContext context, {
    required String title,
    required String message,
    String? btnText,
    VoidCallback? onPressed,
    Color? color,
    bool isCancel = false, // Default false biar praktis
  }) {
    return showModalBottomSheet(
      context: context,
      isDismissible:
          !isCancel, // Kalau popup penting (ada cancel), user gaboleh klik luar
      enableDrag: !isCancel,
      backgroundColor:
          Colors.transparent, // Transparan karena kita atur radius di Container
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
