import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../app/data/models/user_model.dart';
import 'auth_controller.dart';

class UserController extends GetxController {
  // to hold the current user
  UserData? user;

  // to reference the Firestore collection
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

  /// get the current user from Firestore
  Future<void> getUser() async {
    // retrieve the current user's UID
    String uid = Get.find<AuthController>().user!.uid;

    // retrieve the user document from Firestore
    DocumentSnapshot documentSnapshot = await usersCollection.doc(uid).get();

    // create a UserData object from the document data
    user = UserData.fromJson(documentSnapshot.data() as Map<String, dynamic>);

    update();
  }

  /// update the current user in Firestore
  Future<void> updateUser(UserData user) async {
    // retrieve the current user's UID
    String uid = Get.find<AuthController>().user!.uid;

    // update the user document in Firestore
    await usersCollection.doc(uid).set(user.toJson());

    // update the UserData object
    this.user = user;

    update();
  }

}