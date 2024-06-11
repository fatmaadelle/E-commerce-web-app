import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundedButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget child;
  const RoundedButton({
    Key? key,
    required this.onPressed,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration:BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.transparent,
          child: Container(
            width: 30.w,
            height: 30 .h,
            child: child,
          ),
        ),
      ),
    );
  }
}