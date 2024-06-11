
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/app_bar.dart';
import '../../../components/bottom_navigation_bar.dart';
import '../../../components/drawer.dart';
import '../../../components/footer.dart';
import '../../../components/screen_title.dart';
import '../controllers/profile_controllers.dart';
import 'data_card/data_card.dart';

class ProfileView extends StatelessWidget {
  final ProfileController userDataController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: userDataController, // Initialize the controller here
      builder: (controller) {
        final screenWidth = MediaQuery.of(context).size.width;
        final screenHeight = MediaQuery.of(context).size.height;
        return Scaffold(
          appBar: ResponsiveAppBar(selectedIndex: 3),
          drawer: DefaultDrawer(),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ScreenTitle(title: 'Profile',
                  dividerEndIndent: MediaQuery.sizeOf(context).width*0.5,),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: UserDataCard(),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child:  FooterSection(),
                ),
              ],
            ),
          ),
          bottomNavigationBar: screenWidth < 700 && screenHeight > 200
              ? BottomNavigationBarController(selectedIndex: 3).buildBottomNavigationBar()
              : null,
        );
      },
    );
  }
}
