import 'package:flutter/material.dart';

class AceFormLayout extends StatefulWidget {
  final List<Widget> children;
  final String title;
  final String subtitle;
  final Color titleColor;
  final Color progressColor;
  final int? startindex;
  final int? endindex;
  const AceFormLayout({
    super.key,
    required this.children,
    this.title = "title",
    this.subtitle = "subtitle",
    this.titleColor = const Color.fromARGB(255, 56, 92, 221),
    this.progressColor = const Color.fromARGB(255, 56, 92, 221),
    this.startindex,
    this.endindex,
  });

  @override
  State<AceFormLayout> createState() => _AceFormLayoutState();
}

class _AceFormLayoutState extends State<AceFormLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: widget.titleColor,
                ),
              ),
              Text(
                widget.subtitle,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
              ),
              SizedBox(height: 20),
              if (widget.startindex != null && widget.endindex != null)
                LinearProgressIndicator(
                  borderRadius: BorderRadius.circular(10),
                  minHeight: 20,
                  value: widget.startindex! / widget.endindex!,
                  backgroundColor: Colors.black12,
                  color: widget.progressColor,
                ),
              SizedBox(height: 20),
              ...widget.children,
            ],
          ),
        ),
      ),
    );
  }
}
