import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AceListTiles extends StatelessWidget {
  const AceListTiles({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
    required this.isActive,
    this.aceIcon = false,
    this.isSwitch = false, // Mode Switch
    this.valueSwitch = false, // Nilai true/false
    this.switchCallback, // Fungsi saat berubah
  });

  final String title;
  final IconData icon;
  final VoidCallback? onTap;
  final bool isActive;
  final bool isSwitch;
  final bool aceIcon;
  final ValueChanged<bool>? switchCallback; // Pakai tipe data ini lebih standar
  final bool valueSwitch;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        // Jika aktif, pakai warna Primary. Jika tidak, pakai Surface.
        color: isActive
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          // --- LOGIKA TAP AREA ---
          // Jika ini mode Switch, maka tap dimanapun akan men-trigger switchCallback
          // Jika bukan, maka jalankan onTap biasa
          onTap: isSwitch 
              ? () => switchCallback?.call(!valueSwitch) 
              : onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                if (aceIcon) ...[
                  SvgPicture.asset(
                    'assets/icons/ace.svg',
                    width: 15,
                    height: 15,
                    colorFilter: ColorFilter.mode(
                      isActive ? Colors.white : Colors.black,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 9),
                ],

                Icon(
                  icon,
                  color: isActive ? Colors.white : Colors.black,
                  size: 24,
                ),

                const SizedBox(width: 9),
                
                // Teks Judul
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                      color: isActive ? Colors.white : Colors.black87,
                    ),
                  ),
                ),

                // Panah (Jika bukan switch & tidak aktif)
                if (!isActive && !isSwitch)
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Colors.grey,
                  ),
                
                // --- WIDGET SWITCH ---
                if (isSwitch)
                  Switch(
                    value: valueSwitch,
                    // Warna saat aktif (ON) biar kontras dengan background Primary
                    activeColor: Colors.white, 
                    activeTrackColor: Colors.white.withOpacity(0.5),
                    // Warna saat mati (OFF)
                    inactiveThumbColor: Colors.grey,
                    inactiveTrackColor: Colors.grey[300],
                    onChanged: (val) {
                      // Panggil callback dengan aman
                      switchCallback?.call(val);
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}