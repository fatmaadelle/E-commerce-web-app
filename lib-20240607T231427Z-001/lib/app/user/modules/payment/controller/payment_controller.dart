import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../routes/app_pages.dart';
import '../../cart/controllers/cart_controller.dart';

class PaymentController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final cardNumberController = TextEditingController();
  final cvvController = TextEditingController();
  final expirationDateController = TextEditingController();
  final cardholderNameController = TextEditingController();

  final selectedPaymentMethod = 0.obs;
  final isLoading = false.obs;

  void selectPaymentMethod(int method) {
    selectedPaymentMethod.value = method;
  }

  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  void clearFormFields() {
    cardNumberController.clear();
    cvvController.clear();
    expirationDateController.clear();
    cardholderNameController.clear();
  }

  void submitPayment() async {
    final selectedMethod = selectedPaymentMethod.value;
    isLoading.value = true; // Begin processing
    try {
      final cartController = Get.find<CartController>();

      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        Get.snackbar("Authentication Error", "Please log in to place an order.");
        isLoading.value = false;
        return;
      }

      String paymentMethod = ''; // Initialize paymentMethod with an empty string
      if (selectedMethod == 0) {
        // Handle "Cash on Delivery"
        paymentMethod = 'Cash on Delivery';
        await cartController.createOrder(paymentMethod: paymentMethod);
        Get.snackbar("Success", "Your order has been placed successfully for Cash on Delivery.",
            backgroundColor: Colors.green);
        Get.offAllNamed(Routes.HOME);
      } else if (selectedMethod == 1) {
        // Handle "Bank"
        paymentMethod = 'Bank';
        if (!validateForm()) {
          Get.snackbar(
              "Invalid Input", "Please correct the errors in the form.",
              backgroundColor: Colors.red);
          isLoading.value = false;
          return;
        }
      }

      // Save payment method to Firestore
      savePaymentMethod(user.uid, paymentMethod);
    } catch (e) {
      Get.snackbar("Error", "An error occurred while placing your order.",
          backgroundColor: Colors.red);
    } finally {
      isLoading.value = false; // Stop processing
    }
    CartController().refreshTotal();
  }

  Future<void> savePaymentMethod(String userId, String paymentMethod) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'paymentMethod': paymentMethod,
      });
    } catch (e) {
      print("Error saving payment method: $e");
    }
  }
}

class ExpirationDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // If text is being deleted, allow it
    if (newValue.text.length < oldValue.text.length) {
      return newValue;
    }
    // Add '/' after 2 digits if needed
    if (newValue.text.length == 2 && oldValue.text.length < 2) {
      return TextEditingValue(
        text: '${newValue.text}/',
        selection: TextSelection.collapsed(offset: newValue.text.length + 1),
      );
    }

    return newValue; // Otherwise, return the new text
  }
}