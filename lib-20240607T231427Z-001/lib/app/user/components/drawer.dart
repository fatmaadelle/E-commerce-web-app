import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../routes/app_pages.dart';

bool isAuthenticated() {
  final User? currentUser = FirebaseAuth.instance.currentUser;
  return currentUser != null;
}
class DefaultDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Text(''),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          Divider(color: Colors.black.withOpacity(1),height: 20.h,
            thickness: 10.h,
          ),
          if(isAuthenticated())
          ListTile(
            title: Row(
              children: [
                Text('My Orders'),
                FaIcon(FontAwesomeIcons.bucket,
                color:Colors.blue ,)
              ],
            ),
            onTap: () {
              Get.offNamed(Routes.ORDERS);
            },
          ),
          Divider(color: Colors.black.withOpacity(1),height: 2,
            thickness: 1.5,
          ),
          ListTile(
            title: Row(
              children: [
                Text('Contact Us'),
                SizedBox(width: 5,),
                FaIcon(FontAwesomeIcons.envelope,
                color: Colors.blue,)
              ],
            ),
            onTap: () {
              Get.offNamed(Routes.CONTACTUS);
            },
          ),
          Divider(color: Colors.black.withOpacity(1),height: 2,
            thickness: 1.5,
          ),
          ListTile(
            title: Row(
              children: [
                Text('About Us'),
              FaIcon(FontAwesomeIcons.infoCircle,
              color: Colors.blue,)],
            ),
            onTap: () {
              Get.offNamed(Routes.ABOUTUS);
            },
          ),
          Divider(color: Colors.black.withOpacity(1),height: 2,
            thickness: 1.5,
          ),
          isAuthenticated() ?
          ListTile(
            title: Row(
              children: [
                Text( 'Logout',
                  style: TextStyle(
                    color: Colors.red[800],
                  ),),
                Icon(Icons.logout,
                  color: Colors.red[800],)
              ],
            ),
            onTap: () {
              if (isAuthenticated()) {
                FirebaseAuth.instance.signOut();
              } else {
                // Navigate to the sign in page
                Get.offNamed(Routes.LOGIN);
              }
              Get.offNamed(Routes.SPLASH);

            },
          ):ListTile(
            title: Row(
              children: [
                Text( 'Login',
                  style: TextStyle(
                    color: Colors.blue[800],
                  ),),
                Icon(Icons.login,
                  color: Colors.blue[800],)
              ],
            ),
            onTap: () {
              if (isAuthenticated()) {
                FirebaseAuth.instance.signOut();
              } else {
                // Navigate to the sign in page
                Get.offNamed(Routes.LOGIN);
              }
            },
          ),
          Divider(color: Colors.black.withOpacity(1),height: 2,
            thickness: 1.5,
          ),
        ],
      ),
    );
  }
}