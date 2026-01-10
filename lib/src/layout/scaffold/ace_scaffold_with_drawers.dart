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

  bool _canDrag = false;
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
              double xOffset = _controller.value * _maxWidth;
              double currentRadius = widget.borderRadius * _controller.value;
              return Transform(
                transform: Matrix4.identity()..translate(xOffset, 0, 0),
                alignment: Alignment.centerLeft,

                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,

                  // 2. LOGIKA AWAL SENTUHAN (START)
                  onHorizontalDragStart: (details) {
                    bool isClosed = _controller.isDismissed;

                    // ATURAN:
                    // Kalau menu tertutup, cek posisi jari (dx).
                    // Jika jari ada di area > 60 pixel dari kiri, JANGAN BOLEHKAN DRAG.
                    if (isClosed && details.globalPosition.dx > 60) {
                      _canDrag = false;
                    } else {
                      _canDrag = true;
                    }
                  },

                  // 3. LOGIKA UPDATE (CEK _canDrag)
                  onHorizontalDragUpdate: (details) {
                    // Kalau dilarang drag, stop di sini. Biarkan ListView yang ambil alih.
                    if (!_canDrag) return;

                    if (details.primaryDelta == null) return;
                    _controller.value += details.primaryDelta! / _maxWidth;
                  },

                  // 4. LOGIKA SELESAI (END)
                  onHorizontalDragEnd: (details) {
                    // Kalau tadi gak boleh drag, jangan lakukan apa-apa
                    if (!_canDrag) return;

                    if (details.primaryVelocity! > 300) {
                      _openDrawer();
                    } else if (details.primaryVelocity! < -300) {
                      _closeDrawer();
                    } else {
                      if (_controller.value > 0.5)
                        _openDrawer();
                      else
                        _closeDrawer();
                    }
                  },

                  onTap: _controller.isDismissed ? null : _closeDrawer,
                  // Panggil ScaffoldSession yang sudah bersih
                  child: ScaffoldSession(
                    // controller: _controller, // Sudah tidak butuh controller
                    // maxWidth: _maxWidth,     // Tidak butuh
                    body: widget.body,
                    title: widget.titlePage,
                    backgroundColor: widget.backgroundColor,
                    bodyColor: widget.bodyColor,
                    // Kita bisa passing radius dinamis dari sini
                    borderRadius: currentRadius,
                    // Pass fungsi toggle ke tombol hamburger
                    onPressed: () {
                      if (_controller.isDismissed)
                        _controller.forward();
                      else
                        _controller.reverse();
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
