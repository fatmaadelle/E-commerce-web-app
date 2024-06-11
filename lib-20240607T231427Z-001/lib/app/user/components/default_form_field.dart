import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget defaultFormField({
  Color? textColor,
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  TextInputFormatter? customFormatter,
  required String? Function(String?) validate,
  required String label,
  IconData? prefix,
  Color prefixColor = Colors.black54,
  IconData? suffix,
  bool isPassword = false,
  Function? showPassword,
  bool isClickable = true,
  bool border = true,
  TextInputFormatter? inputFormatter, // Nullable input formatter
  bool readOnly = false,
  int? maxLength, // New parameter for length limiting
}) {
  List<TextInputFormatter> inputFormatters = [];

  // If specific input formatter is provided, add it to the list
  if (inputFormatter != null) {
    inputFormatters.add(inputFormatter);
  }

  if (customFormatter != null) {
    inputFormatters.add(customFormatter);
  }
  // If maxLength is specified, add LengthLimitingTextInputFormatter
  if (maxLength != null) {
    inputFormatters.add(LengthLimitingTextInputFormatter(maxLength));
  }

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
    child: TextFormField(
      readOnly: readOnly,
      onTap: onTap as void Function()?,
      keyboardType: type,
      obscureText: isPassword,
      validator: validate,
      controller: controller,
      inputFormatters: inputFormatters, // Use updated formatters list
      decoration: InputDecoration(
        labelText: label,
        enabled: isClickable,
        border: border ? OutlineInputBorder(borderRadius: BorderRadius.circular(15)) : null,
        prefixIcon: Icon(prefix, color: prefixColor, size: 35),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: showPassword as void Function()?, // Safely cast to avoid nullability issue
          icon: Icon(suffix, size: 30),
        )
            : null,
      ),
    ),
  );
}



