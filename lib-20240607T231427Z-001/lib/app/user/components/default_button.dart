import 'package:flutter/material.dart';
Widget defaultButton({
  IconData? icon,
  double width = double.infinity,
  Color color = Colors.black,
  Color borderColor = Colors.blue,
  Color TXTColor = Colors.indigo,
  double radius = 20,
  double height = 50,
  double fontsize = 20,
  required Function function,
  required String text,
  bool isUPPer = false,
}) =>
    SizedBox(
      width: width, // Constrain width of SizedBox
      height: height,
      // Constrain height of SizedBox
      child: MaterialButton(
        onPressed: () {
          function();
        },
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: BorderSide(color:borderColor, width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(icon,color:Colors.indigo ),
              ),
            Text(
              isUPPer ? text.toUpperCase() : text,
              style: TextStyle(
                color: TXTColor,
                fontWeight: FontWeight.bold,
                fontSize: fontsize,
              ),
            ),
          ],
        ),
      ),
    );