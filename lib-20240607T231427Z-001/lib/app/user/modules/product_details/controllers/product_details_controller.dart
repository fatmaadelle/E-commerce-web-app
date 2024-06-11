import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/app/data/models/review_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:safe_text/safe_text.dart';
import '../../../../../utils/dummy_helper.dart';
import '../../../../data/models/product_model.dart';
import '../../cart/controllers/cart_controller.dart';


class ProductDetailsController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GetStorage box = GetStorage();
  var formkey = GlobalKey<FormState>();

  ProductModel? product;

  @override
  void onInit() {
    super.onInit();
    reviewsStream();
    // Retrieve the product from Get.arguments
    if (Get.arguments is ProductModel) {
      product = Get.arguments as ProductModel;
      // Save the product to Firestore if it's not already stored
      _storeProductToFirestore();
    }

    // Check GetStorage for a saved product
    if (product == null) {
      var storedProduct = box.read('product');
      if (storedProduct != null) {
        product = ProductModel.fromJson(storedProduct, '');
      }
    }

    // If the product is still null, retrieve from Firestore
    if (product == null) {
      _fetchProductFromFirestore();
      update();
    }

    if (product != null) {
      // Set favorite and cart status from GetStorage
      _setProductStatus();
    }
    update();
  }


  List<ReviewModel> reviews = []; // Change to ReviewModel

  Stream<List<ReviewModel>> reviewsStream() {
    if (product == null) return Stream.value([]);
    return FirebaseFirestore.instance
        .collection('products')
        .doc(product!.id)
        .collection('reviews')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => ReviewModel.fromDocument(doc)).toList());
  }

  void submitReview(double rating, String review) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String uid = user.uid;

      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

      String userName = '${userData['firstName']} ${userData['lastName']}';
      String userEmail = userData['email'];

      // Use SafeText to sanitize the review text
      String safeReview = SafeText.filterText( text: review);

      ReviewModel newReview = ReviewModel(
        productId: product!.id!,
        userId: uid,
        rating: rating,
        review: safeReview,
        timestamp: DateTime.now(),
        userName: userName,
        userEmail: userEmail,
      );

      await FirebaseFirestore.instance
          .collection('products')
          .doc(product!.id)
          .collection('reviews')
          .add(newReview.toJson());

      Get.snackbar('Review Submitted', 'Your review has been submitted successfully',
      backgroundColor: Colors.green);
      reviewsStream();
      update();
    }
  }

  void _storeProductToFirestore() {
    if (product != null && product!.id!.isNotEmpty) {
      var productRef = _firestore.collection('products').doc(product!.id);
      productRef.get().then((doc) {
        if (!doc.exists) {
          productRef.set(product!.toJson());
        }
      });
    }
  }

  void _fetchProductFromFirestore() {
    _firestore.collection('products').get().then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        var doc = snapshot.docs.first;
        product = ProductModel.fromJson(doc.data(), doc.id);
        // Cache the product locally
        box.write('product', product!.toJson());
        // Set favorite and cart status from GetStorage
        _setProductStatus();
        update();

      }
    });
  }

  void _setProductStatus() {
    product!.isFavorite = box.read('isFavorite${product!.id}') ?? false;
    product!.isCart = box.read('isCart${product!.id}') ?? false;
    update();
  }



  /// Check if the product is loaded
  bool get isProductLoaded => product != null;


  /// Called when a user presses on a product
  void onProductPressed() {
    if (isProductLoaded) {
      Get.toNamed('/product_details', arguments: product);
    }
    update();

  }

  /// Called when the favorite button is pressed
  void onFavoriteButtonPressed() {
    if (isProductLoaded) {
      String uid = _auth.currentUser?.uid ?? '';
      var favoritesRef = _firestore.collection('users').doc(uid).collection('favorites').doc(product!.id.toString());

      if (product!.isFavorite!) {
        product!.isFavorite = false;
        box.write('isFavorite${product!.id}', false);
        favoritesRef.delete();
      } else {
        product!.isFavorite = true;
        box.write('isFavorite${product!.id}', true);
        favoritesRef.set(product!.toJson());
      }
      update(['FavoriteButton']);
    }
  }

  /// Called when the add-to-cart button is pressed
  void onAddToCartPressed() {
    if (isProductLoaded) {
      String uid = _auth.currentUser?.uid ?? '';
      if (!product!.isCart!) {
        product!.isCart = true;
        product!.quantity = 1; // Set initial quantity to 1
        box.write('isCart${product!.id}', true);
        _firestore.collection('users').doc(uid).collection('cart').doc(product!.id.toString()).set({
          'quantity': 1,
          ...product!.toJson(),
        });
        Get.find<CartController>().refreshTotal();
        update();
        Get.snackbar(
          "Added To Cart",
          "",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );
        Get.back();
      }
      else{
        product!.isCart = true;
        product!.quantity = 1; // Set initial quantity to 1
        box.write('isCart${product!.id}', true);
        _firestore.collection('users').doc(uid).collection('cart').doc(product!.id.toString()).set({
          'quantity': 1,
          ...product!.toJson(),
        });
        Get.find<CartController>().refreshTotal();
        update();
        Get.snackbar(
          "Already in Cart",
          "",
          backgroundColor: Colors.black87,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );
      }
    }
  }

  /// Called when deleting from cart
  void onDeletePressed(int productId) {
    var product = DummyHelper.products.firstWhere((p) => p.id == productId);
    String uid = _auth.currentUser?.uid ?? '';
    box.write('isCart${product.id}', false);
    _firestore.collection('users').doc(uid).collection('cart').doc(productId.toString()).delete();
  }

  /// Change the selected size
  String? selectedSize;

  void changeSelectedSize(String size) {
    if (selectedSize == null || size != selectedSize) {
      selectedSize = size;
      update(['Size']);
    }
  }
}
