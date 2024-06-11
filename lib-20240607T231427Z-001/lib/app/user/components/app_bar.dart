import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../lib/pages/loginadmin.dart';
import '../../data/models/product_model.dart';
import '../../routes/app_pages.dart'; // Import FirebaseAuth

bool isAuthenticated() {
  final User? currentUser = FirebaseAuth.instance.currentUser;
  return currentUser != null;
}
class ResponsiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final int selectedIndex;
  const ResponsiveAppBar({
    Key? key,
    required this.selectedIndex,
  }) : super(key: key);
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 700) {
          // For small screens, show the SmallAppBar
          return SmallAppBar();
        } else {
          // For larger screens, show the MyAppBar
          return MyAppBar(selectedIndex: selectedIndex);
        }
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final int selectedIndex;

  const MyAppBar({
    Key? key,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  _MyAppBarState createState() => _MyAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _MyAppBarState extends State<MyAppBar> {
  final TextEditingController _searchController = TextEditingController();
     late ProductModel product;



  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 5,
      title: Row(
        children: [
          MaterialButton(
            onPressed: () {
              Get.offNamed(Routes.HOME);
            },
            child: Row(
              children: [
                Image.asset(
                  "assets/images/LOGO3.png",
                  width: 100,
                  height: 50,
                ),
                Text(
                  'FOM',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 0.035 * MediaQuery.of(context).size.width),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        Flexible(
          fit: FlexFit.loose,
          child: Container(
            width: 0.3 * MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                width: 2,
                color: Colors.black,
              ),
            ),
            alignment: Alignment.center,

            child: TypeAheadField<ProductModel>(
              builder: (context, controller, focusNode) {
                return TextField(
                    controller: controller,
                    focusNode: focusNode,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Search...',
                    )
                );
              },
              controller: _searchController,
              suggestionsCallback: (pattern) async {
                // Replace this with your actual function to fetch suggestions
                List<ProductModel> suggestions = await ProductModel.searchByName(pattern);
                return suggestions;
              },
              itemBuilder: (context, suggestion) {
                // Customize how each suggestion appears in the dropdown
                return ListTile(
                  title: Text(suggestion.name ?? ''),
                );
              },
              onSelected: (ProductModel value) {
                Get.toNamed(Routes.PRODUCT_DETAILS, arguments: value);
              },
            ),

          ),
        ),
        Flexible(
          child: SizedBox(width: 0.01 * MediaQuery.of(context).size.width),
        ),
        IconButton(
          icon: FaIcon(FontAwesomeIcons.home),
          tooltip: "Home",
          onPressed: () {
            Get.offNamed(Routes.HOME);
          },
          color: widget.selectedIndex == 0 ? Colors.blue : Colors.white,
        ),
        StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox();
            }

            if (snapshot.hasData) {
              return IconButton(
                icon: FaIcon(FontAwesomeIcons.solidHeart),
                tooltip: 'Favourites',
                onPressed: () {
                  Get.offNamed(Routes.FAVORITES);
                },
                color: widget.selectedIndex == 1 ? Colors.red : Colors.white,
              );
            } else {
              return IconButton(
                icon: FaIcon(FontAwesomeIcons.solidHeart),
                tooltip: "Favorites",
                onPressed: () {
                  Get.snackbar(
                    "Must Be Loggedin First",
                    "",
                    backgroundColor: Colors.black,
                    colorText: Colors.white,
                    duration: Duration(seconds: 2),
                  );
                  Get.offNamed(Routes.LOGIN);
                },
                color: Colors.white,
              );
            }
          },
        ),
        StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox();
            }

            if (snapshot.hasData) {
              return IconButton(
                icon: FaIcon(FontAwesomeIcons.cartShopping),
                tooltip: "Cart",
                onPressed: () {
                  Get.offNamed(Routes.CART);
                  Get.appUpdate();
                },
                color: widget.selectedIndex == 2 ? Colors.indigo : Colors.white,
              );
            } else {
              return IconButton(
                icon: FaIcon(FontAwesomeIcons.cartShopping),
                tooltip: "Cart",
                onPressed: () {
                  Get.snackbar(
                    "Must Be Loggedin First",
                    "",
                    backgroundColor: Colors.black,
                    colorText: Colors.white,
                    duration: Duration(seconds: 2),
                  );
                  Get.offNamed(Routes.LOGIN);
                },
                color: Colors.white,
              );
            }
          },
        ),
        StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox();
            }
            if (snapshot.hasData) {
              return IconButton(
                icon: FaIcon(FontAwesomeIcons.user),
                onPressed: () {
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
                },
                color: widget.selectedIndex == 3 ? Colors.green : Colors.white,
                tooltip: "Profile",
              );
            } else {
              return IconButton(
                icon: FaIcon(FontAwesomeIcons.user),
                tooltip: "Profile",
                onPressed: () {
                  Get.snackbar(
                    "Must Be Loggedin First",
                    "",
                    backgroundColor: Colors.black,
                    colorText: Colors.white,
                    duration: Duration(seconds: 2),
                  );
                  Get.offNamed(Routes.LOGIN);
                },
                color: Colors.white,
              );
            }
          },
        ),
      ],
    );
  }

  bool isAuthenticated() {
    return FirebaseAuth.instance.currentUser != null;
  }
}
class SmallAppBar extends StatelessWidget implements PreferredSizeWidget {
   SmallAppBar({
    Key? key,
  }) : super(key: key);
  final TextEditingController _searchController = TextEditingController();
  late ProductModel product;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 5,
      title: Row(
        children: [
          MaterialButton(
            onPressed: () {
              Get.offNamed(Routes.HOME);
            },
            child: Row(
              children: [
                Image.asset(
                  "assets/images/LOGO3.png",
                  width: 40,
                  height: 50,
                ),
                Text(
                  'FOM',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 0.035 * MediaQuery.of(context).size.width),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        Flexible(
          fit: FlexFit.loose,
          child: Container(
            width: 0.4 * MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                width: 2,
                color: Colors.black,
              ),
            ),
            alignment: Alignment.center,
            child: TypeAheadField<ProductModel>(
              builder: (context, controller, focusNode) {
                return TextField(
                    controller: controller,
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Search...',
                      prefix: Icon(Icons.search,color: Colors.black,)
                    )
                );
              },


              controller: _searchController,
              suggestionsCallback: (pattern) async {
                // Replace this with your actual function to fetch suggestions
                List<ProductModel> suggestions = await ProductModel.searchByName(pattern);
                return suggestions;
              },
              itemBuilder: (context, suggestion) {
                // Customize how each suggestion appears in the dropdown
                return ListTile(
                  title: Text(suggestion.name ?? ''),
                );
              },
              onSelected: (ProductModel value) {
                Get.toNamed(Routes.PRODUCT_DETAILS, arguments: value);
              },
            ),
          ),
        ),
        Flexible(child: SizedBox(width: 20)),
        // Show login/signup or logout based on authentication state
        StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox(); // Return an empty widget while waiting for authentication state
            }
            if (snapshot.hasData) {
              // User is authenticated
              return Container(
                decoration: BoxDecoration(),
                child: PopupMenuButton<int>(
                  icon: Icon(Icons.more_vert, color: Colors.white),
                  onSelected: (int value) {
                    if (value == 2) {
                      FirebaseAuth.instance.signOut();
                      Get.offNamed(Routes.SPLASH);
                      Get.snackbar(
                        "Logged Out",
                        "Bye!",
                        backgroundColor: Colors.black,
                        colorText: Colors.white,
                        duration: Duration(seconds: 2),
                      );
                    }
                    else if(value == 3)
                    {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdminLogin()));
                    }
                  },
                  itemBuilder: (BuildContext context) => [
                    const PopupMenuItem<int>(
                      value: 2,
                      child: Row(
                        children: [
                          Text(
                            'Logout',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.logout,
                            color: Colors.red,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              // User is not authenticated
              return Container(
                decoration: BoxDecoration(),
                child: PopupMenuButton<int>(
                  icon: Icon(Icons.more_vert, color: Colors.white),
                  onSelected: (int value) {
                    if (value == 0) {
                      Get.offNamed(Routes.LOGIN);
                    } else if (value == 1) {
                      Get.offNamed(Routes.REGISTER);
                    }
                    else if (value == 2) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdminLogin()));
                    }
                  },
                  itemBuilder: (BuildContext context) => [
                    const PopupMenuItem<int>(
                      value: 0,
                      child: Row(
                        children: [
                          Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.login,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    ),
                    const PopupMenuItem<int>(
                      value: 1,
                      child: Row(
                        children: [
                          Text(
                            'Signup',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.person_add_alt_outlined,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    ),
                    const PopupMenuItem<int>(
                      value: 2,
                      child: Row(
                        children: [
                          Text(
                            'admin',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.settings_accessibility,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
