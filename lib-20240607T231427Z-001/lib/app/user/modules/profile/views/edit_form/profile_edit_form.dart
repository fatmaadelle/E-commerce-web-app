import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';
import '../../../../components/default_form_field.dart';
import '../../controllers/profile_controllers.dart';


class FirstNameEditForm extends StatefulWidget {
  @override
  State<FirstNameEditForm> createState() => _FirstNameEditFormState();
}

class _FirstNameEditFormState extends State<FirstNameEditForm> {
  final ProfileController profileController = Get.find();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              defaultFormField(
                controller: profileController.firstNameController.value,
                label: 'First Name',
                prefix: FontAwesomeIcons.person,
                type: TextInputType.name,
                prefixColor: Colors.blue,
                inputFormatter: FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]+')), // Accept only letters
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        profileController.saveUserData(
                          newFirstName: profileController.firstNameController.value.text,
                          newLastName: profileController.userData.value.lastName,
                          newPhoneNumber: profileController.userData.value.phoneNumber,
                          newEmail: profileController.userData.value.email,
                          newAddress: profileController.userData.value.address,
                          newGender: profileController.userData.value.gender,
                          newBirthday: profileController.userData.value.birthday,
                        );
                        Get.back();
                      }
                    },
                    child: Text('Save'),
                  ),
                  ElevatedButton(
                    onPressed: () => Get.back(),
                    child: Text("Cancel"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LastNameEditForm extends StatefulWidget {
  @override
  State<LastNameEditForm> createState() => _LastNameEditFormState();
}

class _LastNameEditFormState extends State<LastNameEditForm> {
  final ProfileController profileController = Get.find();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              defaultFormField(
                controller: profileController.lastNameController.value,
                label: 'Last Name',
                prefix: FontAwesomeIcons.user,
                prefixColor: Colors.red,
                type: TextInputType.name,
                inputFormatter: FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]+')), // Accept only letters
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        profileController.saveUserData(
                          newFirstName: profileController.userData.value.firstName,
                          newLastName: profileController.lastNameController.value.text,
                          newPhoneNumber: profileController.userData.value.phoneNumber,
                          newEmail: profileController.userData.value.email,
                          newAddress: profileController.userData.value.address,
                          newGender: profileController.userData.value.gender,
                          newBirthday: profileController.userData.value.birthday,
                        );
                        Get.back();
                      }
                    },
                    child: Text('Save'),
                  ),
                  ElevatedButton(
                    onPressed: () => Get.back(),
                    child: Text("Cancel"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PhoneNumberEditForm extends StatefulWidget {
  @override
  State<PhoneNumberEditForm> createState() => _PhoneNumberEditFormState();
}

class _PhoneNumberEditFormState extends State<PhoneNumberEditForm> {
  final ProfileController profileController = Get.find();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              defaultFormField(
                controller: profileController.phoneNumberController.value,
                label: 'Phone Number',
                prefix: FontAwesomeIcons.phone,prefixColor: Colors.green,
                type: TextInputType.phone,
                  inputFormatter:FilteringTextInputFormatter.digitsOnly, // Accept only digits
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  if (value.length != 11) {
                    return 'Phone number must be 11 digits';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        profileController.saveUserData(
                          newFirstName: profileController.userData.value.firstName,
                          newLastName: profileController.userData.value.lastName,
                          newPhoneNumber: profileController.phoneNumberController.value.text,
                          newEmail: profileController.userData.value.email,
                          newAddress: profileController.userData.value.address,
                          newGender: profileController.userData.value.gender,
                          newBirthday: profileController.userData.value.birthday,
                        );
                        Get.back();
                      }
                    },
                    child: Text('Save'),
                  ),
                  ElevatedButton(
                    onPressed: () => Get.back(),
                    child: Text("Cancel"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class EmailEditForm extends StatefulWidget {
  @override
  State<EmailEditForm> createState() => _EmailEditFormState();
}

class _EmailEditFormState extends State<EmailEditForm> {
  final ProfileController profileController = Get.find();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
        Text("Email Can't Be Modified"),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                      Get.back();
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class AddressEditForm extends StatefulWidget {
  @override
  State<AddressEditForm> createState() => _AddressEditFormState();
}

class _AddressEditFormState extends State<AddressEditForm> {
  final ProfileController profileController = Get.find();

  final _formKey = GlobalKey<FormState>();

  void _showLocationPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Location'),
          content: Container(
            height: MediaQuery.of(context).size.height * 0.75,
            width: MediaQuery.of(context).size.width,
            child: FlutterLocationPicker(
              initZoom: 11,
              minZoomLevel: 5,
              maxZoomLevel: 16,
              trackMyPosition: true,
              searchBarBackgroundColor: Colors.white,
              selectedLocationButtonTextstyle: const TextStyle(fontSize: 18),
              mapLanguage: 'en',
              onError: (e) => print(e),
              selectLocationButtonLeadingIcon: const Icon(Icons.check),
              onPicked: (pickedData) {
                // Update controller's address field
                profileController.addressController.value.text = pickedData.address;
                Navigator.of(context).pop(); // Close the dialog
              },
              onChanged: (pickedData) {
                // Update controller's address field on change if needed
              },
              showContributorBadgeForOSM: true,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              defaultFormField(
                controller: profileController.addressController.value,
                label: 'Address',
                prefix: Icons.location_on,
                onTap: () => _showLocationPicker(context),
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
                type: TextInputType.streetAddress,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        profileController.saveUserData(
                          newFirstName: profileController.userData.value.firstName,
                          newLastName: profileController.userData.value.lastName,
                          newPhoneNumber: profileController.userData.value.phoneNumber,
                          newEmail: profileController.userData.value.email,
                          newAddress: profileController.addressController.value.text,
                          newGender: profileController.userData.value.gender,
                          newBirthday: profileController.userData.value.birthday,
                        );
                        Get.back();
                      }
                    },
                    child: Text('Save'),
                  ),
                  ElevatedButton(
                    onPressed: () => Get.back(),
                    child: Text("Cancel"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class GenderEditForm extends StatefulWidget {
  @override
  State<GenderEditForm> createState() => _GenderEditFormState();
}

class _GenderEditFormState extends State<GenderEditForm> {
  final ProfileController profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Gender',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            ),
            SizedBox(height: 20),
            Container(
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
              child: Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: DropdownButtonFormField<String>(
                  value: profileController.genderValue.value,
                  icon: Icon(Icons.arrow_downward),

                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      profileController.genderValue.value = newValue; // Update gender value locally
                    }
                  },
                  items: <String>['Male', 'Female']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Container(
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(value,
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold
                            ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    profileController.saveUserData(
                      newFirstName: profileController.userData.value.firstName,
                      newLastName: profileController.userData.value.lastName,
                      newPhoneNumber: profileController.userData.value.phoneNumber,
                      newEmail: profileController.userData.value.email,
                      newAddress: profileController.userData.value.address,
                      newGender: profileController.genderValue.value, // Use updated gender value
                      newBirthday: profileController.userData.value.birthday,
                    );
                    Get.back(); // Dismiss the dialog
                  },
                  child: Text('Save'),
                ),
                ElevatedButton(
                  onPressed: () => Get.back(), // Dismiss the dialog
                  child: Text("Cancel"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BirthdayEditForm extends StatefulWidget {
  @override
  State<BirthdayEditForm> createState() => _BirthdayEditFormState();
}

class _BirthdayEditFormState extends State<BirthdayEditForm> {
  final ProfileController profileController = Get.find();
  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Birthday'),
      content: Form(
        child: defaultFormField(
          readOnly: true,
          controller: _dateController,
          type: TextInputType.datetime,
          inputFormatter:
          FilteringTextInputFormatter.allow(RegExp(r'[0-9/-]')),
          onTap: () {
            showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.parse("1940-01-01"),
              lastDate: DateTime.now(),
              builder: (BuildContext context, Widget? child) {
                return Theme(
                  data: ThemeData(
                    textTheme: TextTheme(
                      headline1: TextStyle(fontSize: 20,), // Change the font size here
                    ),
                  ),
                  child: child!,
                );
              },
            ).then((value) {
              if (value != null) {
                final formattedDate = DateFormat('yyyy-MM-dd').format(value).toString();
                print(formattedDate);
                _dateController.text = formattedDate;
              }
            });
          },
          validate: (value) {
            if (value!.isEmpty) {
              return "Please enter your Birthday";
            }
            return null;
          },
          label: "Birthday",
          prefix:FontAwesomeIcons.calendarAlt,
          prefixColor: Colors.blue,),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            profileController.saveUserData(
              newFirstName: profileController.userData.value.firstName,
              newLastName: profileController.userData.value.lastName,
              newPhoneNumber: profileController.userData.value.phoneNumber,
              newEmail: profileController.userData.value.email,
              newAddress: profileController.userData.value.address,
              newGender: profileController.userData.value.gender,
              newBirthday: DateFormat('yyyy-MM-dd').parse(_dateController.text),
            );
            Get.back();
          },
          child: Text('Save'),
        ),
        ElevatedButton(
            onPressed:()=>
                Get.back(),
            child: Text("Cancel"))
      ],
    );
  }
}

class UserImage extends StatefulWidget {
@override
_UserImageState createState() => _UserImageState();
}

class _UserImageState extends State<UserImage> {
  final ProfileController profileController = Get.find();
  final _formKey = GlobalKey<FormState>();
  XFile? selectedImage;

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery); // Pick a single image
    if (image != null) {
      setState(() {
        selectedImage = image;
      });
    }
  }

  Future<void> _uploadImage() async {
    if (selectedImage == null) {
      return;
    }
    String? imagePath = await profileController.uploadImage(selectedImage);
    if (imagePath != null) {
      await profileController.saveUserData(
        newFirstName: profileController.firstNameController.value.text,
        newLastName: profileController.lastNameController.value.text,
        newPhoneNumber: profileController.phoneNumberController.value.text,
        newEmail: profileController.emailController.value.text,
        newAddress: profileController.addressController.value.text,
        newGender: profileController.genderValue.value,
        newBirthday: profileController.userData.value.birthday,
        newUserImage: imagePath,
      );
    } else {
      // Handle error case where imagePath is null
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: _selectImage,
                child: Text("Select Image"),
              ),
              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await _uploadImage(); // Upload the selected image
                        Get.back(); // Close the dialog after saving
                      }
                    },
                    child: Text('Save'),
                  ),
                  ElevatedButton(
                    onPressed: () => Get.back(), // Close the dialog
                    child: Text("Cancel"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
