import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactUsController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  void submitMessage() {
    if (formKey.currentState!.validate()) {
      // Form is valid, proceed with submitting data
      // Show submitted dialog
      Get.dialog(
        AlertDialog(
          title: Text('Message Submitted'),
          content: Text('Thank you for your message! We will get back to you soon.'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );

      // Clear form fields
      nameController.clear();
      emailController.clear();
      messageController.clear();
    }
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.dispose();
  }
}
