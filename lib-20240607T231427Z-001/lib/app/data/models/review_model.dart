import 'package:cloud_firestore/cloud_firestore.dart';


class ReviewModel {
  String userId;
  String userName;
  String userEmail;
  String productId;
  double rating;
  String review;
  DateTime timestamp;

  ReviewModel({
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.productId,
    required this.rating,
    required this.review,
    required this.timestamp,
  });

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      userId: map['userId'],
      userName: map['userName'],
      userEmail: map['userEmail'],
      productId: map['productId'],
      rating: map['rating'].toDouble(),
      review: map['review'],
      timestamp: (map['timestamp'] as Timestamp).toDate(),
    );
  }

  factory ReviewModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return ReviewModel(
      userId: data['userId'] ?? '',
      userName: data['userName'] ?? '',
      userEmail: data['userEmail'] ?? '',
      productId: data['productId'] ?? '',
      rating: (data['rating'] ?? 0.0).toDouble(),
      review: data['review'] ?? '',
      timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'userName': userName,
    'userEmail': userEmail,
    'productId': productId,
    'rating': rating,
    'review': review,
    'timestamp': Timestamp.fromDate(timestamp),
  };
}
