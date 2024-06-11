import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class OrdersController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getOrders() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return _firestore.collection('users').doc(uid).collection('orders').orderBy('orderDate', descending: true).snapshots();
  }

  Future<void> deleteOrder(String orderId) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    await _firestore.collection('users').doc(uid).collection('orders').doc(orderId).delete();

    update();
  }

  Future<String> getOrderStatus(String orderId) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final orderDoc = await _firestore.collection('users').doc(uid).collection('orders').doc(orderId).get();
    if (orderDoc.exists) {
      final orderData = orderDoc.data() as Map<String, dynamic>;
      final orderStatus = orderData['orderStatus'] as String;
      return orderStatus;
    } else {
      return 'unknown';
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getOrderData(String uid, String orderId) {
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('orders')
        .doc(orderId)
        .snapshots();
  }
  Future<void> deleteOrderAdmin(String orderId) async {
    try {
      await _firestore.collection('orders').doc(orderId).delete();
    } catch (e) {
      // Handle any errors here
      print('Error deleting order (admin): $e');
    }
  }
  void fetchOrderData(String uid, String orderId) {
    getOrderData(uid, orderId).listen((snapshot) {
      if (snapshot.exists) {
        final orderData = snapshot.data();
        // Process the order data as needed
        print('Order location: ${orderData?['location']}');
        // Add any other processing logic here
      } else {
        print('Order not found.');
      }
    });
  }

  // Function to get product image URL
  Future<String?> getProductImageURL(String productId) async {
    final productDoc = await _firestore.collection('products').doc(productId).get();
    if (productDoc.exists) {
      final productData = productDoc.data() as Map<String, dynamic>;
      return productData['image'][0] as String?;
    }
    return null;
  }
}