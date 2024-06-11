import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String? id;
  List<String>? image;
  String? name;
  int? quantity;
  double? price;
  double? rating;
  String? reviews;
  String? size;
  bool? isFavorite;
  bool? isCart;
  String? description;
  String? source;
  double? rate;
  double? discount;

  ProductModel({
    this.id,
    this.image,
    this.name,
    this.quantity,
    this.price,
    this.rating,
    this.reviews,
    this.size,
    this.isFavorite = false,
    this.isCart = false,
    this.description,
    this.source,
    this.rate,
    this.discount,
  });

  void setImage(String imageUrl) {
    image = [imageUrl];
  }

  factory ProductModel.fromJson(Map<String, dynamic> json, String documentId) {
    return ProductModel(
      id: documentId,
      image: json['image'] is List ? (json['image'] as List).cast<String>() : [json['image'] as String],
      name: json['name'],
      quantity: json.containsKey('quantity') ? json['quantity'] : null,
      price: json['price'],
      rating: json.containsKey('rating') ? json['rating'] : null,
      reviews: json.containsKey('reviews') ? json['reviews'] : null,
      description: json['description'],
      size: json['size'],
      isFavorite: json.containsKey('isFavorite') ? json['isFavorite'] : false,
      isCart: json.containsKey('isCart') ? json['isCart'] : false,
      source: json['source'],
      discount: json.containsKey('discount') ? json['discount'] : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'quantity': quantity,
      'price': price,
      'rating': rating,
      'reviews': reviews,
      'size': size ?? "M",
      'isFavorite': isFavorite ?? false,
      'isCart': isCart ?? false,
      'source': source,
      'description': description,
      'discount': discount,
    };
  }

  ProductModel copyWith({
    String? id,
    List<String>? image,
    String? name,
    int? quantity,
    double? price,
    double? rating,
    String? reviews,
    String? size,
    bool? isFavorite,
    bool? isCart,
    String? source,
    String? description,
    double? discount,
  }) {
    return ProductModel(
      id: id ?? this.id,
      image: image ?? this.image,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      reviews: reviews ?? this.reviews,
      size: size ?? this.size,
      isFavorite: isFavorite ?? this.isFavorite,
      isCart: isCart ?? this.isCart,
      source: source ?? this.source,
      description: description ?? this.description,
      discount: discount ?? this.discount,
    );
  }

  Future<bool> checkIfFavorite(String userId) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(id)
        .get();
    return doc.exists;
  }

  Future<bool> checkIfInCart(String userId) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('cart')
        .doc(id)
        .get();
    return doc.exists;
  }

  // Search function
  static Future<List<ProductModel>> searchByName(String name) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('product')
        .get();

    List<ProductModel> products = querySnapshot.docs.map((doc) {
      return ProductModel.fromJson(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();

    List<ProductModel> filteredProducts = products.where((product) {
      return product.name!.toLowerCase().contains(name.toLowerCase());
    }).toList();

    return filteredProducts;
  }


  }


