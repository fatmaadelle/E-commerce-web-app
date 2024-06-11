import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../app/data/models/user_model.dart';

class AuthController extends GetxController {
  // to hold the current user
  FirebaseUser? user;

  /// get the current user from FirebaseAuth
  Future<void> getUser() async {
    user = FirebaseAuth.instance.currentUser as FirebaseUser?;
    update();
  }

  /// sign in the user with email and password
  Future<void> signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      await getUser();
    } catch (e) {
      // handle the error
    }
  }

  /// sign up the user with email and password
  Future<void> signUp(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      await getUser();
    } catch (e) {
      // handle the error
    }
  }

  /// sign out the user
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    user = null;
    update();
  }

}