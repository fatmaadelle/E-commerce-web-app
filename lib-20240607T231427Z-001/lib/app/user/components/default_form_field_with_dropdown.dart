import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget defaultFormFieldWithDropdown({
  required String label,
  required List<String> items,
  required String hint,
  required String? value,
  required Function(String?) onChanged,
  required String? Function(String?) validate,
  required IconData prefix,
  Function()? onTap,
}) {
  return Container(
    decoration:BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      border: Border.all(width: 2,
          color: Colors.grey),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.6),
          spreadRadius: 2,
          blurRadius: 5,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ],
    ),
    child: Row(
      children: [
        Icon(
          prefix,
          color: Colors.grey,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: label,
              border: InputBorder.none,
            ),
            hint: Text(hint),
            value: value,
            validator: validate,
            onChanged: onChanged,
            items: items.map((String item) {
              return DropdownMenuItem(
                value: item,
                child: Text(item,
                style: TextStyle(
                  color: Colors.white,
                fontSize: 12.sp,),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    ),
  );
}