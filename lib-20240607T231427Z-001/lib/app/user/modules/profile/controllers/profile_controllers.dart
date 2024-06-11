import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../../data/models/user_model.dart';

class ProfileController extends GetxController {
  final Rx<UserData> _userData = UserData(
    userImage: '',
    firstName: '',
    lastName: '',
    phoneNumber: '',
    email: '',
    address: '',
    gender: 'Other',
    birthday: DateTime.utc(2000, 1, 1),
  ).obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  XFile? selectedImages;

  Rx<UserData> get userData => _userData;
  Rx<TextEditingController> firstNameController = TextEditingController().obs;
  Rx<TextEditingController> lastNameController = TextEditingController().obs;
  Rx<TextEditingController> phoneNumberController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> addressController = TextEditingController().obs;
  Rx<String> genderValue = 'Other'.obs;
  Rx<TextEditingController> birthdayController = TextEditingController().obs;

  @override
  void onInit() {
    super.onInit();
    bindUserData();
  }

  void bindUserData() {
    String documentId = getCurrentUserDocumentId();
    if (documentId.isNotEmpty) {
      fetchUserData(documentId);
    } else {
      // Handle the case when there is no logged-in user
    }
  }

  Future<void> fetchUserData(String documentId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(documentId).get();
      if (doc.exists && doc.data() != null) {
        var data = doc.data() as Map<String, dynamic>;

        // Check and convert birthday field to DateTime
        if (data['birthday'] is Timestamp) {
          data['birthday'] = (data['birthday'] as Timestamp).toDate();
        } else if (data['birthday'] is String) {
          data['birthday'] = DateTime.parse(data['birthday']);
        } else {
          data['birthday'] = DateTime.now(); // Default in case of unknown type
        }

        _userData.value = UserData.fromJson(data);
        updateControllers();
      } else {
        print('User data not found.');
        // Handle missing document
      }
    } catch (e) {
      print('Error fetching user data: $e');
      // Handle exceptions during fetching
    }
  }

  void updateControllers() {
    firstNameController.value.text = _userData.value.firstName;
    lastNameController.value.text = _userData.value.lastName;
    phoneNumberController.value.text = _userData.value.phoneNumber;
    emailController.value.text = _userData.value.email;
    addressController.value.text = _userData.value.address;
    genderValue.value = _userData.value.gender;

    // Debug print to check the birthday value
    print("Updating birthday controller with: ${_userData.value.birthday}");

    birthdayController.value.text = DateFormat('yyyy-MM-dd').format(_userData.value.birthday);
    update(); // Update the UI after initializing controllers
  }

  String getCurrentUserDocumentId() {
    User? currentUser = FirebaseAuth.instance.currentUser;
    return currentUser?.uid ?? '';
  }

  void _updateUserData({
    required String newFirstName,
    required String newLastName,
    required String newPhoneNumber,
    required String newEmail,
    required String newAddress,
    required String newGender,
    required DateTime newBirthday,
    String? newUserImage,
  }) {
    _userData.value = UserData(
      firstName: newFirstName,
      lastName: newLastName,
      phoneNumber: newPhoneNumber,
      email: newEmail,
      address: newAddress,
      gender: newGender,
      birthday: newBirthday,
      userImage: newUserImage ?? _userData.value.userImage,
    );
  }

  Future<void> saveUserData({
    required String newFirstName,
    required String newLastName,
    required String newPhoneNumber,
    required String newEmail,
    required String newAddress,
    required String newGender,
    required DateTime newBirthday,
    String? newUserImage,
  }) async {
    String userId = getCurrentUserDocumentId();
    if (userId.isNotEmpty) {
      _updateUserData(
        newFirstName: newFirstName,
        newLastName: newLastName,
        newPhoneNumber: newPhoneNumber,
        newEmail: newEmail,
        newAddress: newAddress,
        newGender: newGender,
        newBirthday: newBirthday,
        newUserImage: newUserImage,
      );
      await _firestore.collection('users').doc(userId).update({
        'firstName': newFirstName,
        'lastName': newLastName,
        'phoneNumber': newPhoneNumber,
        'email': newEmail,
        'address': newAddress,
        'gender': newGender,
        'birthday': Timestamp.fromDate(newBirthday), // Convert DateTime to Timestamp
        if (newUserImage != null) 'userImage': newUserImage,
      });
      await fetchUserData(userId); // Fetch the updated data after saving
      update(); // Update the UI after saving data
    }
  }



  Future<String?> uploadImage(XFile? selectedImage) async {
    if (selectedImage == null) {
      return null; // If no image is selected, return null
    }
    var ref = FirebaseStorage.instance.ref().child("userImage/${DateTime.now().toString()}");
    var imageData = await selectedImage.readAsBytes();
    var uploadTask = ref.putData(imageData);
    var downloadUrl = await (await uploadTask).ref.getDownloadURL();

    return downloadUrl;
  }

  Future<void> _uploadAndFetchImage() async {
    if (selectedImages == null) {
      return;
    }

    String? imagePath = await uploadImage(selectedImages);
    if (imagePath != null) {
      await saveUserData(
        newFirstName: userData.value.firstName,
        newLastName: userData.value.lastName,
        newPhoneNumber: userData.value.phoneNumber,
        newEmail: userData.value.email,
        newAddress: userData.value.address,
        newGender: userData.value.gender,
        newBirthday: userData.value.birthday,
        newUserImage: imagePath,
      );
      await fetchUserData(getCurrentUserDocumentId());
    } else {
      // Handle error case where imagePath is null
    }
  }

  void clearUserData() {
    _userData.value = UserData(
      firstName: '',
      lastName: '',
      phoneNumber: '',
      email: '',
      address: '',
      gender: 'Other',
      birthday: DateTime.now(),
    );
    firstNameController.value.clear();
    lastNameController.value.clear();
    phoneNumberController.value.clear();
    emailController.value.clear();
    addressController.value.clear();
    genderValue.value = 'Other';
    birthdayController.value.text = '';
    update(); // Update the UI
  }
}
