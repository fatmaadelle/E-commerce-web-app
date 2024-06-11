import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../routes/app_pages.dart';


class BottomNavigationBarController extends GetxController {
  int selectedIndex;

  BottomNavigationBarController({required this.selectedIndex});

  void updateSelectedIndex(int index) {
    selectedIndex = index;

    switch (selectedIndex) {
      case 0:
        Get.offNamed(Routes.HOME);
        break;
      case 1:
        if (isAuthenticated()) {
          Get.offNamed(Routes.FAVORITES);
        } else {
          Get.snackbar(
            "Must Be Loggedin First",
            "",
            backgroundColor: Colors.white,
            colorText: Colors.black,
            duration: Duration(seconds: 1),
          );
          Get.offNamed(Routes.LOGIN);
        }
        break;
      case 2:
        if (isAuthenticated()) {
          Get.offNamed(Routes.CART);
        } else {
          Get.snackbar(
            "Must Be Loggedin First",
            "",
            backgroundColor: Colors.white,
            colorText: Colors.black,
            duration: Duration(seconds: 1),
          );
          Get.offNamed(Routes.LOGIN);
        }
        break;
      case 3:
        if (isAuthenticated()) {
          Get.offNamed(Routes.PROFILE);
        } else {
          Get.snackbar(
            "Must Be Loggedin First",
            "",
            backgroundColor: Colors.white,
            colorText: Colors.black,
            duration: Duration(seconds: 1),
          );
          Get.offNamed(Routes.LOGIN);
        }
        break;

    }
  }

  bool isAuthenticated() {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    return currentUser != null;
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      mouseCursor: MaterialStateMouseCursor.clickable,
      currentIndex: selectedIndex,
      onTap: updateSelectedIndex,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      backgroundColor: Colors.grey[900], // Set background color directly
      unselectedItemColor: Colors.grey, // Set the color for unselected item
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold), // Bold style for selected labels
      unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal), // Bold style for unselected labels
      items: [
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.home, color: selectedIndex == 0 ? Colors.blue : Colors.white,),
            label: 'Home',
            tooltip: "Home"
        ),
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.solidHeart, color: selectedIndex == 1 ? Colors.red : Colors.white,),
            label: 'Favorites',
            tooltip: "Favorites"

        ),
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.cartShopping, color: selectedIndex == 2 ? Colors.indigo : Colors.white,),
            label: 'Cart',
            tooltip: "Cart"
        ),
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.user, color: selectedIndex == 3 ? Colors.green : Colors.white,),
            label: 'Profile',
            tooltip: "profile"
        ),
      ],
    );
  }
}