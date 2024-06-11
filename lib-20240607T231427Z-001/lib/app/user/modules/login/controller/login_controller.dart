import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../routes/app_pages.dart';

class LoginController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formkey = GlobalKey<FormState>();
  var isPassword = true.obs;

  // Function to toggle password visibility
  void showPassword() {
    isPassword.value = !isPassword.value;
  }

  get textDecorationColor => null;
  Future<void> signInWithEmailAndPassword()  async {

    if (formkey.currentState!.validate()) {
      if ((emailController == "adminfady@gmail.com")&& passwordController == "10"){
        Get.offNamed(Routes.PRODUCTMANGE);
      }
      try {
        // Sign in the user with email and password using Firebase Auth
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        // User logged in successfully
        print('User logged in: ${userCredential.user!.uid}');
        // Show a snackbar indicating successful login
        Get.snackbar(
          'Success',
          'Logged in Successfully!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Navigate to home page (replace this with your desired destination)
        Get.offNamed(Routes.SPLASH); // Navigate to home screen
      } catch (e) {
        // Handle login error
        print('Login failed: $e');

        // Show a snackbar indicating login failure
        Get.snackbar(
          'Error',
          'Login failed. Please try again.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }
}