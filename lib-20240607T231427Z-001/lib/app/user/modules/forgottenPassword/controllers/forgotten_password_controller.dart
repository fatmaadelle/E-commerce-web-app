import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ForgottenPasswordController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formkey = GlobalKey<FormState>();
  bool isPassword = true;

  void submitForm() {
    if (formkey.currentState!.validate()) {
      print(emailController.text);
      print(passwordController.text);
    }
  }
}