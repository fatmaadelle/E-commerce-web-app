import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../../../data/models/product_model.dart';
import '../../home/controllers/home_controller.dart';

class FavoritesController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final HomeController homeController = Get.put(HomeController());

  RxList<ProductModel> _favorites = RxList<ProductModel>();
  List<ProductModel> get favorites => _favorites.toList();

  @override
  void onInit() {
    super.onInit();
    getFavoriteProducts();
  }

  Stream<List<ProductModel>> get favoriteProductsStream => _firestore
      .collection('users')
      .doc(_auth.currentUser?.uid)
      .collection('favorites')
      .snapshots()
      .map((snapshot) {
    var favoriteIds = snapshot.docs.map((doc) => doc.id).toList();
    var updatedFavorites = homeController.products
        .where((product) => favoriteIds.contains(product.id))
        .toList();
    return updatedFavorites;
  });

  Future<void> getFavoriteProducts() async {
    String uid = _auth.currentUser?.uid ?? '';
    if (uid.isNotEmpty) {
      try {
        var snapshot = await _firestore
            .collection('users')
            .doc(uid)
            .collection('favorites')
            .get();
        var favoriteIds = snapshot.docs.map((doc) => doc.id).toList();
        var updatedFavorites = homeController.products
            .where((product) => favoriteIds.contains(product.id))
            .toList();
        _favorites.assignAll(updatedFavorites);
        update();
      } catch (e) {
        print('Error fetching favorite products: $e');
      }
    }
  }

  Future<void> onFavoritePressed(String productId, bool isFavorite) async {
    String uid = _auth.currentUser?.uid ?? '';
    if (uid.isEmpty) return;

    try {
      DocumentReference favoriteRef = _firestore.collection('users').doc(uid).collection('favorites').doc(productId);

      if (isFavorite) {
        await favoriteRef.delete();
      } else {
        await favoriteRef.set({'productId': productId});
      }
      await getFavoriteProducts();
    } catch (e) {
      print('Error updating favorites: $e');
    }
  }

}
