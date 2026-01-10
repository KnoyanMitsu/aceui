import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:aceui/src/layout/scaffold/scaffold_session.dart';

class AceScaffoldWithDrawers extends StatefulWidget {
  const AceScaffoldWithDrawers({
    super.key,
    required this.listtile,
    required this.body,
    required this.titlePage,
    required this.title,
    this.backgroundColor,
    this.bodyColor,
    this.borderRadius = 30,
    this.bottomListtile,
  });
  final List<Widget> listtile;
  final Widget body;
  final String titlePage;
  final String title;
  final Color? backgroundColor;
  final Color? bodyColor;
  final double borderRadius;
  final List<Widget>? bottomListtile;

  @override
  State<AceScaffoldWithDrawers> createState() => _AceScaffoldWithDrawersState();
}

class _AceScaffoldWithDrawersState extends State<AceScaffoldWithDrawers>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final double _maxWidth = 300.0;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _closeDrawer() {
    _controller.reverse();
  }

  void _openDrawer() {
    _controller.forward();
  }

  void _toggleDrawer() {
    if (_controller.isDismissed) {
      _openDrawer();
    } else {
      _closeDrawer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.backgroundColor ?? Theme.of(context).colorScheme.surface,
      child: Stack(
        children: [
          SizedBox(
            width: _maxWidth,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/logo.svg',
                        width: 49,
                        height: 49,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        widget.title,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ...widget.listtile,
                  Spacer(),
                  if (widget.bottomListtile != null) ...widget.bottomListtile!,
                ],
              ),
            ),
          ),

          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return GestureDetector(
                // 1. LOGIKA SLIDE (DRAG)
                behavior: HitTestBehavior.translucent, // <--- 1. Tambah ini

                onHorizontalDragUpdate: (details) {
                  // 2. Tambahkan Sensitivitas
                  // Kadang delta di HP High DPI sangat kecil, jadi kita validasi
                  if (details.primaryDelta == null) return;

                  double delta = details.primaryDelta! / _maxWidth;

                  // Opsional: Cek arah agar tidak "overshoot" (geser kebablasan)
                  // Jika sudah tertutup (value 0), jangan biarkan geser ke kiri (negatif)
                  if (_controller.value == 0 && delta < 0) return;
                  // Jika sudah terbuka (value 1), jangan biarkan geser ke kanan (positif)
                  if (_controller.value == 1 && delta > 0) return;

                  _controller.value += delta;
                },

                onHorizontalDragEnd: (details) {
                  // Logika snap tetap sama, velocity 300 biasanya cukup aman untuk HP
                  if (details.primaryVelocity! > 300) {
                    _openDrawer();
                  } else if (details.primaryVelocity! < -300) {
                    _closeDrawer();
                  } else {
                    if (_controller.value > 0.5) {
                      _openDrawer();
                    } else {
                      _closeDrawer();
                    }
                  }
                },

                onTap: _controller.isDismissed ? null : _closeDrawer,
                // Child: ScaffoldSession Anda
                child: ScaffoldSession(
                  controller: _controller,
                  maxWidth: _maxWidth,
                  body: widget.body,
                  title: widget.titlePage,
                  backgroundColor: widget.backgroundColor,
                  borderRadius: widget.borderRadius,
                  bodyColor: widget.bodyColor,
                  onPressed: _toggleDrawer,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
