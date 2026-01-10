import 'package:flutter/material.dart';

class ScaffoldSession extends StatefulWidget {
  const ScaffoldSession({
    super.key,
    // required this.controller, // Hapus controller, tidak butuh di sini
    // this.maxWidth = 300.0,    // Hapus ini juga
    required this.body,
    required this.title,
    this.backgroundColor,
    this.bodyColor,
    this.borderRadius = 30.0, // Default value
    required this.onPressed, // Fungsi untuk tombol Menu
  });

  final Widget body;
  final String title;
  final Color? backgroundColor;
  final Color? bodyColor;
  final double borderRadius;
  final VoidCallback onPressed;

  @override
  State<ScaffoldSession> createState() => _ScaffoldSessionState();
}

class _ScaffoldSessionState extends State<ScaffoldSession> {
  @override
  Widget build(BuildContext context) {
    // LANGSUNG RETURN SCAFFOLD (Hapus AnimatedBuilder & Transform)
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.backgroundColor ?? Theme.of(context).colorScheme.surface,
        title: Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          // PENTING: Panggil fungsi yang dikirim dari Parent
          onPressed: widget.onPressed, 
        ),
      ),
      body: Container(
        color: widget.backgroundColor ?? Theme.of(context).colorScheme.surface,
        width: double.infinity,
        height: double.infinity,
        child: ClipRRect(
          // Radius ini nanti statis saja di sini, atau dinamis di parent (pilih salah satu)
          borderRadius: BorderRadius.circular(widget.borderRadius),
          child: Container(
            color: widget.bodyColor ?? Theme.of(context).colorScheme.surface,
            width: double.infinity,
            height: double.infinity,
            child: widget.body,
          ),
        ),
      ),
    );
  }
}