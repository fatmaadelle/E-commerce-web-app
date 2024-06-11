import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../../../data/models/product_model.dart';
import '../../../../../utils/dummy_helper.dart';
import '../../cart/controllers/cart_controller.dart';

class HomeController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  RxList<ProductModel> _products = RxList<ProductModel>();
  List<ProductModel> get products => _products.toList();

  @override
  void onInit() {
    super.onInit();
    getProductStream();
    fetchProducts();
    update();
  }

  Stream<List<ProductModel>> getProductStream() {
    return _firestore.collection('product').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return ProductModel.fromJson(data, doc.id);
      }).toList();

    });

  }

  Future<void> fetchProducts() async {
    try {
      String? uid = _auth.currentUser?.uid;

      QuerySnapshot productSnapshot = await _firestore.collection('product').get();
      List<ProductModel> firestoreProducts = productSnapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return ProductModel.fromJson(data, doc.id);
      }).toList();

      _products.assignAll(firestoreProducts);
      _products.addAll(DummyHelper.products);

      if (uid != null) {
        _firestore.collection('users').doc(uid).collection('favorites').snapshots().listen((favoriteSnapshot) {
          List<String> favoriteIds = favoriteSnapshot.docs.map((doc) => doc.id).toList();
          _products.forEach((product) {
            product.isFavorite = favoriteIds.contains(product.id);
          });
          update(['FavoriteButton']);
        });

        _firestore.collection('users').doc(uid).collection('cart').snapshots().listen((cartSnapshot) {
          List<String> cartIds = cartSnapshot.docs.map((doc) => doc.id).toList();
          _products.forEach((product) {
            product.isCart = cartIds.contains(product.id);
          });
          update(['CartButton']);
        });
      }
      update();
    } catch (e) {
      print('An error occurred while fetching products: $e');
    }
  }

  bool isProductInFavorites(String productId) {
    return _products.any((product) => product.id == productId && product.isFavorite == true);
  }

  bool isProductInCart(String productId) {
    return _products.any((product) => product.id == productId && product.isCart == true);
  }

  Future<void> onFavoriteButtonPressed({required String productId}) async {
    try {
      var product = _products.firstWhere(
            (product) => product.id == productId,
        orElse: () => ProductModel(id: '-1'),
      );
      String? uid = _auth.currentUser?.uid;
      if (product.id != '-1' && uid != null) {
        if (product.isFavorite != null && product.isFavorite!) {
          product.isFavorite = false;
          await _firestore.collection('users').doc(uid).collection('favorites').doc(productId).delete();
        } else {
          product.isFavorite = true;
          await _firestore.collection('users').doc(uid).collection('favorites').doc(productId).set(product.toJson());
        }
        _products[_products.indexWhere((p) => p.id == productId)] = product;
        update(['FavoriteButton']);
      }
    } catch (e) {
      print('An error occurred on favorite button pressed: $e');
    }
  }

  void onCartButtonPressed({required String productId}) async {
    try {
      var product = _products.firstWhere(
            (product) => product.id == productId,
        orElse: () => ProductModel(id: '-1'),
      );
      String? uid = _auth.currentUser?.uid;
      if (product.id != '-1' && uid != null) {
        if (product.isCart != null && product.isCart!) {
          // If the product is already in the cart, remove it
          product.isCart = false;
          await _firestore.collection('users').doc(uid)
              .collection('cart')
              .doc(productId).delete();
          Get.find<CartController>().refreshTotal();

        } else {
          // If the product is not in the cart, add it with quantity 1
          product.isCart = true;
          await _firestore.collection('users').doc(uid).collection('cart').doc(productId).set({
            ...product.toJson(),
            'quantity': 1 // Set initial quantity to 1
          });
          // Refresh the total price in the cart controller
          Get.find<CartController>().refreshTotal();
        }
        update(['CartButton']);
      }
    }
    catch (e) {
      print('An error occurred on cart button pressed: $e');
    }
  }


}
