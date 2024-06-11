import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';

class RegisterController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var rePasswordController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var birthdayController = TextEditingController();
  var rePassword;
  var formkey1 = GlobalKey<FormState>();
  bool isPassword = true;
  Color textDecorationColor = Colors.white;
  List<String> genders = ['Male', 'Female'];
  String? selectedGender;

  void registerUser() async {
    if (formkey1.currentState!.validate()) {
      try {
        UserData userData = UserData(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          phoneNumber: phoneController.text,
          birthday: DateTime.parse(birthdayController.text),
          gender: selectedGender!,
          address: addressController.text,
          email: emailController.text,
        );

        // Register user using the provided email and password
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        // Save user data to Cloud Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(userData.toMap());

        // Forward user data to admin
        forwardUserDataToAdmin(userData);

        // User registration successful
        Get.snackbar(
          'Success',
          'Signed Up Successfully !!.',
          backgroundColor: Colors.green,
          colorText: Colors.black,
        );
        Get.offNamed(Routes.LOGIN);
      } on FirebaseAuthException catch (e) {
        // Handle FirebaseAuthException
        Get.snackbar(
          'Failed',
          ' ${e.message} !',
          backgroundColor: Colors.red,
          colorText: Colors.black,
        );
      } catch (e) {
        // Handle other exceptions
        print('Registration error: $e');
      }
    }
  }

  final ValueNotifier<bool> isPasswordVisible = ValueNotifier<bool>(false);


  void forwardUserDataToAdmin(UserData userData) {
    // Forward user data to admin logic here
    print('Forwarding user data to admin...');
    print('First Name: ${userData.firstName}');
    print('Last Name: ${userData.lastName}');
    print('Phone Number: ${userData.phoneNumber}');
    print('Birthday: ${userData.birthday}');
    print('Gender: ${userData.gender}');
    print('Address: ${userData.address}');
    print('Email: ${userData.email}');
  }
}

class UserData {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final DateTime birthday;
  final String gender;
  final String address;
  final String email;

  UserData({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.birthday,
    required this.gender,
    required this.address,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'birthday': birthday.toIso8601String(),
      'gender': gender,
      'address': address,
      'email': email,
    };
  }
}