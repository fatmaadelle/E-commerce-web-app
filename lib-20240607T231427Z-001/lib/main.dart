import 'package:ecommerce_app/app/user/modules/cart/controllers/cart_controller.dart';
import 'package:ecommerce_app/app/user/modules/orders/controllers/orders_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/data/local/my_shared_pref.dart';
import 'app/routes/app_pages.dart';
import 'app/user/modules/favorites/controllers/favorites_controller.dart';
import 'config/theme/my_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures Flutter is initialized before proceeding// Create the initial instance
  await GetStorage.init(); // Initializes GetStorage for local data storage
  await Firebase.initializeApp( // Initializes Firebase with specific configuration
    options: FirebaseOptions(
      apiKey: "AIzaSyDDsOnFwX0G3JFoZvQHqEpTSG9fxkzv4xE",
      authDomain: "market-f41cc.firebaseapp.com",
      projectId: "market-f41cc",
      storageBucket: "market-f41cc.appspot.com",
      messagingSenderId: "1026171264804",
      appId: "1:1026171264804:web:707a8fa11190cb09215db1",
      measurementId: "G-3JHG9RHQ45",
    ),
  );

  await MySharedPref.init(); // Initializes custom shared preferences for the app
  Get.put(FavoritesController());
  Get.put(CartController());
  Get.put(OrdersController());

  runApp(
    ScreenUtilInit(
      designSize: Size(375, 812), // Defines the base design size for the layout
      minTextAdapt: true, // Enables adaptive text scaling
      splitScreenMode: true, // Enables split-screen support
      builder: (context, widget) {
        return GetMaterialApp(
          title: "E-commerce App", // App title
          useInheritedMediaQuery: false, // Determines whether to inherit media queries
          debugShowCheckedModeBanner: false, // Hides the debug banner
          initialRoute: AppPages.INITIAL, // Initial route when the app launches
          getPages: AppPages.routes, // Defines app routes
          theme: MyTheme.getThemeData(isLight: MySharedPref.getThemeIsLight()), // Theme setup
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1), // Ensures consistent text scaling
              child: child!, // The child widget (GetMaterialApp's child)
            );
          },
        );
      },
    ),
  );
}
