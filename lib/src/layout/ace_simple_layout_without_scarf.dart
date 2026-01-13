import 'package:flutter/material.dart';

class AceSimpleLayoutWithoutScarf extends StatelessWidget {
  const AceSimpleLayoutWithoutScarf({
    super.key,
    required this.childern,
    required this.title,
  });

  final List<Widget> childern;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [...childern],
      ),
    );
  }
}
