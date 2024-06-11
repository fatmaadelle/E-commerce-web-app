
import 'package:flutter/material.dart';


//TextButton With underline
class HoverTextButton extends StatefulWidget {
  final Color textColor;
  final Color underLineColor = Colors.transparent;
  final VoidCallback onPressed;
  final String text;

  HoverTextButton({
    required this.textColor,
    required this.onPressed,
    required this.text,
  });

  @override
  _HoverTextButtonState createState() => _HoverTextButtonState();
}
class _HoverTextButtonState extends State<HoverTextButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child: TextButton(
        onPressed: widget.onPressed,
        child: Text(
          widget.text,
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: widget.textColor,
            decoration: TextDecoration.combine([
              TextDecoration.underline,
            ]),
            decorationColor: isHovered ? Colors.blue[900] : widget.underLineColor,
          ),
        ),
      ),
    );
  }
}