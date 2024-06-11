import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/models/product_model.dart';
import '../../../../routes/app_pages.dart';
import '../../home/controllers/home_controller.dart';

class CartController extends GetxController {
  // Firestore reference
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Firebase Auth reference
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Rx variables
  var quantity = 0.obs;
  var total = 0.0.obs;

  // StreamController for total price
  var _totalController = StreamController<double>.broadcast();

  // Get instance of HomeController
  final HomeController _homeController = Get.put(HomeController());

  // Use the same product list as HomeController
  List<ProductModel> get products => _homeController.products;

  @override
  void onReady() {
    super.onReady();
    getCartProductsStream();
    refreshTotal();
  }

  /// When the user presses on the purchase now button
  void onPurchaseNowPressed() {
    if (total.value == 0) {
      Get.snackbar(
        "Add Products to Your Cart First!",
        "",
        backgroundColor: Colors.black,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );
      Get.offNamed(Routes.HOME);
    } else {
      Get.snackbar(
        "Go to Payment",
        "",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 1),
      );
      Get.offNamed(Routes.PAYMENT);
    }
  }
  /// When the user presses on the increase button
  void onIncreasePressed(String productId) async {
    var product = products.firstWhere((p) => p.id == productId);
    int currentQuantity = 1;

    DocumentSnapshot documentSnapshot = await _firestore
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .collection('cart')
        .doc(productId)
        .get();

    if (documentSnapshot.exists) {
      currentQuantity = documentSnapshot['quantity'] as int;
      currentQuantity++;
      await _firestore
          .collection('users')
          .doc(_auth.currentUser?.uid)
          .collection('cart')
          .doc(productId)
          .update({'quantity': currentQuantity});
      product.quantity = currentQuantity;
      _updateProductAndTotal(productId, currentQuantity);
      total.value += product.price!;
    }
    refreshTotal();
  }

  /// When the user presses on the decrease button
  void onDecreasePressed(String productId) async {
    var product = products.firstWhere((p) => p.id == productId);
    int currentQuantity = 1;

    DocumentSnapshot documentSnapshot = await _firestore
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .collection('cart')
        .doc(productId)
        .get();

    if (documentSnapshot.exists) {
      currentQuantity = documentSnapshot['quantity'] as int;
      currentQuantity--;
      if (currentQuantity == 0) {
        onDeletePressed(productId);
      } else {
        await _firestore
            .collection('users')
            .doc(_auth.currentUser?.uid)
            .collection('cart')
            .doc(productId)
            .update({'quantity': currentQuantity});
        product.quantity = currentQuantity;
        _updateProductAndTotal(productId, currentQuantity);
        total.value -= product.price!;
      }
    }
    refreshTotal();
  }

  /// When the user presses on the delete icon
  void onDeletePressed(String productId) {
    String uid = _auth.currentUser?.uid ?? '';
    if (uid.isNotEmpty) {
      _firestore.collection('users').doc(uid).collection('cart').doc(productId).delete();
      products.removeWhere((p) => p.id == productId);
      getCartProductsStream();
      _firestore.collection('users').doc(uid).update({'total': total.value});
      refreshTotal();
    }
  }

  /// Get the cart products from the product list
  Stream<List<ProductModel>> getCartProductsStream() {
    String uid = _auth.currentUser?.uid ?? '';
    if (uid.isNotEmpty) {
      return _firestore
          .collection('users')
          .doc(uid)
          .collection('cart')
          .snapshots()
          .map((snapshot) {
        List<ProductModel> cartProducts = snapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          int quantity = data['quantity'] as int;
          return ProductModel.fromJson(data, doc.id)..quantity = quantity;
        }).toList();
        return _homeController.products.where((homeProduct) =>
            cartProducts.any((cartProduct) => cartProduct.id == homeProduct.id)).toList();
      });
    } else {
      return Stream.value([]);
    }
  }

  Future<DocumentSnapshot> getProductQuantityFromCart(String productId) {
    return _firestore
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .collection('cart')
        .doc(productId)
        .get();
  }

  /// Update the product quantity and total price in the database
  void _updateProductAndTotal(String productId, int quantity) {
    String uid = _auth.currentUser?.uid ?? '';
    if (uid.isNotEmpty) {
      _firestore.collection('users').doc(uid).collection('cart').doc(productId).update({'quantity': quantity});
      _firestore.collection('users').doc(uid).update({'total': total.value});
    }
    refreshTotal();
  }

  Future<void> createOrder({String? paymentMethod}) async {
    User? user = _auth.currentUser;
    if (user != null) {
      String uid = user.uid;

      DocumentSnapshot userDoc = await _firestore.collection('users').doc(uid).get();
      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

      String userName = '${userData['firstName']} ${userData['lastName']}';
      String userEmail = userData['email'];
      String phoneNumber = userData['phoneNumber'];
      String address = userData['address'];

      QuerySnapshot cartSnapshot = await _firestore.collection('users').doc(uid).collection('cart').get();

      List<Map<String, dynamic>> orderData = cartSnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        double totalPrice = data['quantity'] * data['price'];
        return {
          'quantity': data['quantity'],
          'price': data['price'],
          'totalPrice': totalPrice,
          'size': data['size'],
          'productName': data['name'],
          'productId': data['id'],
        };
      }).toList();

      double totalOrderPrice = orderData.fold(0, (prev, product) => prev + product['totalPrice']);

      DocumentReference orderRef = _firestore.collection('orders').doc();
      await orderRef.set({
        'userId': uid,
        'userName': userName,
        'userEmail': userEmail,
        'orderId': orderRef.id,
        'orderStatus': 'Pending',
        'acceptanceStatus': 'Pending',
        'products': orderData,
        'total': totalOrderPrice,
        'paymentMethod': paymentMethod,
        'orderDate': Timestamp.now(),
        'phoneNumber': phoneNumber,
        'address': address,
      });

      await _firestore.collection('users').doc(uid).collection('orders').doc(orderRef.id).set({
        'userId': uid,
        'userName': userName,
        'userEmail': userEmail,
        'orderId': orderRef.id,
        'orderStatus': 'Pending',
        'acceptanceStatus': 'Pending',
        'products': orderData,
        'total': totalOrderPrice,
        'paymentMethod': paymentMethod,
        'orderDate': Timestamp.now(),
        'phoneNumber': phoneNumber,
        'address': address,
      });

      await _clearCart();
      refreshTotal();

    }
    refreshTotal();

  }

  Future<void> _clearCart() async {
    User? user = _auth.currentUser;
    if (user != null) {
      String uid = user.uid;
      await _firestore.collection('users').doc(uid).collection('cart').get().then((snapshot) {
        for (DocumentSnapshot doc in snapshot.docs) {
          doc.reference.delete();
        }
      });
    }
  }

  void refreshTotal() {
    String uid = _auth.currentUser?.uid ?? '';
    if (uid.isNotEmpty) {
      _firestore.collection('users').doc(uid).collection('cart').get().then((querySnapshot) {
        double totalPrice = querySnapshot.docs.fold<double>(
            0,
                (previousValue, doc) => previousValue + (doc.data()['price'] ?? 0) * (doc.data()['quantity'] ?? 1));
        total.value = totalPrice;
        quantity.value = querySnapshot.docs.fold<int>(
            0, (previousValue, doc) => previousValue + ((doc.data()['quantity'] ?? 1) as int));
        _totalController.sink.add(total.value);
      });
    }
  }

  void clearCart() {
    String uid = _auth.currentUser?.uid ?? '';
    if (uid.isNotEmpty) {
      _firestore.collection('users').doc(uid).collection('cart').get().then((snapshot) {
        for (DocumentSnapshot doc in snapshot.docs) {
          doc.reference.delete();
        }
      });
      products.clear();
      total.value = 0.0;
    }
  }
}
