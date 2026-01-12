import 'package:flutter/material.dart';

class AceSimpleLayout extends StatelessWidget {
  const AceSimpleLayout({
    super.key,
    required this.childern,
    required this.title,
  });

  final List<Widget> childern;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(children: [...childern]),
    );
  }
}
