import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../controllers/profile_controllers.dart';
import '../edit_form/profile_edit_form.dart';

class UserDataCard extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final ProfileController profileController = Get.find();
    return GetBuilder<ProfileController>(
      builder: (controller) {
        return Column(
          children: [
            MaterialButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return UserImage();
                  },
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width:screenWidth>700? 150:100,
                    height: screenWidth>700? 150:100,
                    child: profileController.userData.value.userImage == null
                        ? CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://firebasestorage.googleapis.com/v0/b/market-f41cc.appspot.com/o/avatar.jpg?alt=media&token=1ab76c48-b042-4c83-bccb-26def12b9cc7',
                      ),
                      radius: 50,
                    )
                        : CircleAvatar(
                      backgroundImage: NetworkImage(
                        profileController.userData.value.userImage!,
                      ),
                      radius: 50,
                    ),
                  ),
                  FaIcon(FontAwesomeIcons.edit,
                  color: Colors.black,
                  size: 30,)
                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 3, color: Colors.blue),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),

              child: ListTile(
                title: Text(
                  'First Name',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                leading: Column(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.user,
                      color: Colors.blue[600],
                      size: 35,
                    ),
                    SizedBox(height: 4),
                  ],
                ),
                subtitle: Text(
                  profileController.userData.value.firstName,
                  style: TextStyle(
                    fontFamily: 'SourceSansPro',
                    fontSize: 20,
                    color: Colors.blueGrey[700],
                  ),
                ),
                trailing: Container(
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
                  child: IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.edit,
                      color: Colors.black,
                      size: 30,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return FirstNameEditForm();
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 5,),
            Container(
              decoration:BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 3,
                  color: Colors.blue),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
              child: ListTile(
                title: Text(
                  'Last Name',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                leading: Column(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.user,
                      color: Colors.red[600],
                      size: 35,
                    ),
                    SizedBox(height: 4),
                  ],
                ),
                subtitle: Text(
                  profileController.userData.value.lastName,
                  style: TextStyle(
                    fontFamily: 'SourceSansPro',
                    fontSize: 20,
                    color: Colors.blueGrey[700],
                  ),
                ),
                trailing: Container(
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
                  child: IconButton(
                    icon:
                    FaIcon(
                      FontAwesomeIcons.edit,
                      color: Colors.black,
                      size: 30,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return LastNameEditForm();
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 5,),
            Container(
              decoration:BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 3,
                    color: Colors.blue),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: ListTile(
                title: Text(
                  'Phone Number',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                leading: Column(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.phone,
                      color: Colors.green[700],
                      size: 35,
                    ),
                    SizedBox(height: 4),
                  ],
                ),
                subtitle: Text(
                  profileController.userData.value.phoneNumber,
                  style: TextStyle(
                    fontFamily: 'SourceSansPro',
                    fontSize: 20,
                    color: Colors.blueGrey[700],
                  ),
                ),
                trailing: Container(
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
                  child: IconButton(
                    icon:
                    FaIcon(
                      FontAwesomeIcons.edit,
                      color: Colors.black,
                      size: 30,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return PhoneNumberEditForm();
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 5,),

            Container(
              decoration:BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 3,
                    color: Colors.blue),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: ListTile(
                title: Text(
                  'Email',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                leading: Column(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.envelope,
                      color: Colors.red[700],
                      size: 35,
                    ),
                    SizedBox(height: 4),
                  ],
                ),
                subtitle: Text(
                  profileController.userData.value.email,
                  style: TextStyle(
                    fontFamily: 'SourceSansPro',
                    fontSize: 20,
                    color: Colors.blueGrey[700],
                  ),
                ),
                trailing: Container(
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
                  child: IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.edit,
                      color: Colors.black,
                      size: 30,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return EmailEditForm();
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 5,),
            Container(
              decoration:BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 3,
                    color: Colors.blue),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: ListTile(
                title: Text(
                  'Address',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                leading: Column(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.locationDot,
                      color: Colors.red[700],
                      size: 35,
                    ),
                    SizedBox(height: 4),
                  ],
                ),
                subtitle: Text(
                  profileController.userData.value.address,
                  style: TextStyle(
                    fontFamily: 'SourceSansPro',
                    fontSize: 20,
                    color: Colors.blueGrey[700],
                  ),
                ),
                trailing: Container(decoration:BoxDecoration(
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
                  child: IconButton(
                    icon:  FaIcon(
                      FontAwesomeIcons.edit,
                      color: Colors.black,
                      size: 30,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AddressEditForm();
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 5,),

            Container(
              decoration:BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 3,
                    color: Colors.blue),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: ListTile(
                title: Text(
                  'Gender',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                leading: Column(
                  children: [
                    FaIcon(
                      profileController.genderValue.value == 'Male'?
                      FontAwesomeIcons.male:
                      FontAwesomeIcons.female,
                      color:
                      profileController.genderValue.value == 'Male'?
                      Colors.blue[500]:
                      Colors.pinkAccent,
                      size: 35,
                    ),
                    SizedBox(height: 4),
                  ],
                ),
                subtitle: Text(
                  profileController.userData.value.gender,
                  style: TextStyle(
                    fontFamily: 'SourceSansPro',
                    fontSize: 20,
                    color: Colors.blueGrey[700],
                  ),
                ),
                trailing: Container(decoration:BoxDecoration(
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
                  child: IconButton(
                    icon:  FaIcon(
                      FontAwesomeIcons.edit,
                      color: Colors.black,
                      size: 30,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return GenderEditForm();
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 5,),

            Container(
              decoration:BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 3,
                    color: Colors.blue),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: ListTile(
                title: Text(
                  'Birthday',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                leading: Column(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.calendarAlt,
                      color: Colors.black,
                      size: 35,
                    ),
                    SizedBox(height: 4),
                  ],
                ),
                subtitle: Text(
                  profileController.userData.value.getFormattedBirthday(),
                  style: TextStyle(
                    fontFamily: 'SourceSansPro',
                    fontSize: 20,
                    color: Colors.blueGrey[700],
                  ),
                ),
                trailing: Container(
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
                  child: IconButton(
                    icon:  FaIcon(
                      FontAwesomeIcons.edit,
                      color: Colors.black,
                      size: 30,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return BirthdayEditForm();
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
