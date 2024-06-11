import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget content;
  final Color color;
  final VoidCallback onTap;
  final double width;
  final double height;

  const CustomCard({
    required this.content,
    required this.color,
    required this.onTap,
    required this.width,
    required this.height
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),),
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: content,
        ),
      ),
    );
  }
}
