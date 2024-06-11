import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color color;
  final String title;
  final VoidCallback onTap;

  const CustomButton({
    required this.color,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(color),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: color == Colors.white ? Colors.black : Colors.white,
        ),
      ),
    );
  }
}


