import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class UserData {
  String? userImage;
  String firstName;
  String lastName;
  String phoneNumber;
  String email;
  String address;
  String gender;
  DateTime birthday;

  UserData({
    this.userImage,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.address,
    required this.gender,
    required this.birthday,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      userImage: json["userImage"] as String?,
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      email: json['email'] ?? '',
      address: json['address'] ?? '',
      gender: json['gender'] ?? '',
      birthday: json["birthday"],
    );
  }


  void setImage(String imageUrl) {
    userImage = imageUrl;
  }

  Map<String, dynamic> toJson() => {
    "userImage": userImage,
    'firstName': firstName,
    'lastName': lastName,
    'phoneNumber': phoneNumber,
    'email': email,
    'address': address,
    'gender': gender,
    'birthday': Timestamp.fromDate(birthday), // Convert DateTime to Timestamp
  };


  String getFormattedBirthday() {
    return DateFormat('yyyy-MM-dd').format(birthday);
  }
}


class FirebaseUser {
  // to hold the user's UID
  final String uid;

  // to hold the user's email address
  final String email;

  // to hold the user's display name
  final String displayName;

  // to hold the user's photo URL
  final String photoURL;

  // to hold the user's phone number
  final String phoneNumber;

  // to hold the user's provider ID
  final String providerId;

  // to hold the user's creation time
  final DateTime creationTime;

  // to hold the user's last sign-in time
  final DateTime lastSignInTime;

  // to hold the user's is anonymous flag
  final bool isAnonymous;

  // to hold the user's email verified flag
  final bool emailVerified;

  // to create a FirebaseUser object
  FirebaseUser({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.photoURL,
    required this.phoneNumber,
    required this.providerId,
    required this.creationTime,
    required this.lastSignInTime,
    required this.isAnonymous,
    required this.emailVerified,
  });
}
