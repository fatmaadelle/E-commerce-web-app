import 'package:ecommerce_app/lib/pages/loginadmin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  runApp(const StartPoint());
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
}
class StartPoint extends StatelessWidget {
  const StartPoint({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false, // Hides the debug banner

      home: AdminLogin(),
    );
  }
}


