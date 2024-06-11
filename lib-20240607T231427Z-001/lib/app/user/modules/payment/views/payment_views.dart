import 'package:flutter/material.dart';
import 'package:flutter/services.dart';  // For TextInputFormatter
import 'package:get/get.dart';
import 'package:ecommerce_app/app/user/components/default_button.dart';
import 'package:ecommerce_app/app/user/components/default_form_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../cart/controllers/cart_controller.dart';
import '../controller/payment_controller.dart';

class PaymentView extends StatelessWidget {
  final PaymentController paymentController = Get.put(PaymentController());
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: paymentController.scaffoldKey,
      appBar: AppBar(
        title: Text("Payment"),
        leading: IconButton(
          onPressed: () {
            Get.offNamed("/cart");  // Navigate back to the cart
          },
          tooltip: "Back",
          icon: FaIcon(FontAwesomeIcons.arrowLeft),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Payment Details",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
              SizedBox(height: 16),
              _buildTotalPrice(),
              SizedBox(height: 16),
              _buildPaymentMethodSelector(),
              SizedBox(height: 16),
              if (paymentController.selectedPaymentMethod.value == 1)
                _buildBankCardForm(),
              SizedBox(height: 32),
              Center(
                child: defaultButton(
                  text: "Submit Payment",
                  function:
                    _submitPayment,

                  color: Colors.black,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildTotalPrice() {
    return Obx(() {
      final total = cartController.total.value.toStringAsFixed(2);
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Total:", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          Text("\$$total", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        ],
      );
    });
  }

  Widget _buildPaymentMethodSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Choose Payment Method:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        RadioListTile<int>(
          title: Text("Cash on Delivery"),
          value: 0,
          groupValue: paymentController.selectedPaymentMethod.value,
          onChanged: (int? value) {
            paymentController.selectPaymentMethod(value ?? 0);
          },
        ),
        RadioListTile<int>(
          title: Text("Bank Card"),
          value: 1,
          groupValue: paymentController.selectedPaymentMethod.value,
          onChanged: (int? value) {
            paymentController.selectPaymentMethod(value ?? 0);
          },
        ),
      ],
    );
  }

  Widget _buildBankCardForm() {
    return Form(
      key: paymentController.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Enter Card Details", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
        defaultFormField(
          controller: paymentController.cardNumberController,
          maxLength: 16,
          label: "Card Number",
          type: TextInputType.number,
          suffix: Icons.credit_card,
          validate: (value) {
            if (value == null || value.trim().isEmpty) {
              return "Please enter the card number.";
            }
            if (value.length != 16) {
              return "Card number must be 16 digits.";
            }
            return null;
          },
          inputFormatter:
            FilteringTextInputFormatter.digitsOnly,  // Allow only digits
         // Limit to 16 digits
        ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: defaultFormField(
                  controller: paymentController.expirationDateController,
                  label: "Expiration Date (MM/YY)",
                  maxLength: 5,
                  inputFormatter: ExpirationDateInputFormatter(),                  suffix: FontAwesomeIcons.calendarAlt,
                  type: TextInputType.datetime,
                  validate: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter the expiration date.";
                    }
                    if (!RegExp(r'^(0[1-9]|1[0-2])/([2-9][0-9])$').hasMatch(value)) {
                      return "Invalid expiration date.";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: defaultFormField(
                  controller: paymentController.cvvController,
                  label: "CVV",
                  maxLength: 3,
                  suffix: Icons.lock,
                  inputFormatter: FilteringTextInputFormatter.digitsOnly,
                  type: TextInputType.number,
                  validate: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter the CVV.";
                    }
                    if (value.length != 3) {
                      return "CVV must be 3 digits.";
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          defaultFormField(
            controller: paymentController.cardholderNameController,
            label: "Cardholder Name",
            inputFormatter: FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]+')),
            suffix: Icons.person,
            validate: (value) {
              if (value == null || value. isEmpty) {
                return "Please enter the cardholder name.";
              }
              return null;
            }, type: TextInputType.name,
          ),
        ],
      ),
    );
  }
  void _submitPayment() {
    final selectedMethod = paymentController.selectedPaymentMethod.value;

    if (selectedMethod == 0) {
      // Cash on Delivery selected
      paymentController.submitPayment(); // No form validation needed for cash on delivery
    } else if (selectedMethod == 1) {
      // Bank Card selected, check if form is valid
      if (paymentController.validateForm()) {
        paymentController.submitPayment();
      } else {
        Get.snackbar("Invalid Input", "Please correct the errors in the form.",
            backgroundColor: Colors.red);
      }
    } else {
      // Handle other cases or raise an error if method is unknown
      Get.snackbar("Payment Error", "Please select a valid payment method.",
      backgroundColor: Colors.red);
    }
  }

}
