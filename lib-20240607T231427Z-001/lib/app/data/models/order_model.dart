import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  double total;
  String? status;
  String? acceptanceStatus;
  String address;
  String phoneNumber;
  List<dynamic> products;
  final DateTime orderDate;
  final double totalPrice;
  final String userId; // Added property for user ID
  late final String userName; // Added property for user name
  late final String userEmail; // Added property for user email
  String? paymentMethod;
  final String orderId;

  OrderModel({
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.total,
    this.status ,
    this.acceptanceStatus  ,
    this.address = '',
    this.phoneNumber = '',
    this.products = const [],
    required this.orderDate,
    required this.totalPrice,
    this.paymentMethod,
    required this. orderId,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      userId: map['userId'],
      userName: map['userName'],
      userEmail: map['userEmail'],
      orderId: map['orderId'],
      total: map['total'],
      status: map['status'],
      acceptanceStatus: map['acceptanceStatus'],
      address: map['shippingAddress'],
      phoneNumber: map['phoneNumber'],
      products: map['products'],
      orderDate: (map['orderDate'] as Timestamp).toDate(),
      totalPrice: map['totalPrice'],
      paymentMethod: map['paymentMethod'], // Added payment method
    );
  }

  factory OrderModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final List<dynamic> products = data['products'] ?? [];

    return OrderModel(
      userId: data['userId'] ?? '',
      userName: data['userName'] ?? '',
      userEmail: data['userEmail'] ?? '',
      orderId: doc.id, // Set orderId to document ID
      total: (data['total'] ?? 0.0).toDouble(),
      status: data['status'] ?? 'Pending',
      acceptanceStatus: data['acceptanceStatus'],
      address: data['address'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      products: products,
      orderDate: (data['orderDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      totalPrice: (data['totalPrice'] ?? 0.0).toDouble(),
      paymentMethod: data['paymentMethod'], // Added payment method
    );
  }
}