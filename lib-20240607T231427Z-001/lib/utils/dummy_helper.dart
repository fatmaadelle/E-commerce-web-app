import '../app/data/models/product_model.dart';
import 'constants.dart';

class DummyHelper {
  const DummyHelper._();

  static List<ProductModel> products = [
    ProductModel(
      id: "1",
      image: [Constants.product1, Constants.product1, Constants.product1],
      name: 'The Basic Tee',
      quantity: 0,
      price: 25.99,
      rating: 4.5,
      reviews: '1.2k reviews',
      size: 'M',
      isFavorite: false,
      isCart: false,
      source: 'local', // Source is 'local' for DummyHelper products
      description: "fdsfhsfhbsufdsfhsdiufgsuyifgjdsy7fgsduyfgsdyftwe7yfgewy7grfew67tfgrweyufgwe67fgwfsdyfgshfgsduyfgtds"
    ),
    ProductModel(
      id: "2",
      image: [Constants.product2, Constants.product2, Constants.product2],
      name: 'The Statement Skirt',
      quantity: 0,
      price: 79.99,
      rating: 4.4,
      reviews: '10k reviews',
      size: 'M',
      isFavorite: false,
      isCart: false,
      source: 'local',
        description: "fdsfhsfhbsufdsfhsdiufgsuyifgjdsy7fgsduyfgsdyftwe7yfgewy7grfew67tfgrweyufgwe67fgwfsdyfgshfgsduyfgtds"

    ),
    ProductModel(
      id: "3",
      image: [Constants.product3, Constants.product3, Constants.product3],
      name: 'The Luxe Sweater',
      quantity: 0,
      price: 129.99,
      rating: 4.3,
      reviews: '22k reviews',
      size: 'M',
      isFavorite: false,
      isCart: false,
      source: 'local',
        description: "fdsfhsfhbsufdsfhsdiufgsuyifgjdsy7fgsduyfgsdyftwe7yfgewy7grfew67tfgrweyufgwe67fgwfsdyfgshfgsduyfgtds"

    ),
    ProductModel(
      id: "4",
      image: [Constants.product4, Constants.product4, Constants.product4],
      name: 'The Statement Top',
      quantity: 0,
      price: 59.99,
      rating: 4.2,
      reviews: '3.4k reviews',
      size: 'M',
      isFavorite: false,
      isCart: false,
      source: 'local',
        description: "fdsfhsfhbsufdsfhsdiufgsuyifgjdsy7fgsduyfgsdyftwe7yfgewy7grfew67tfgrweyufgwe67fgwfsdyfgshfgsduyfgtds"

    ),
    ProductModel(
      id: "5",
      image: [Constants.product5, Constants.product5, Constants.product5],
      name: 'The Casual Tank',
      quantity: 0,
      price: 39.99,
      rating: 4.1,
      reviews: '2.6k reviews',
      size: 'M',
      isFavorite: false,
      isCart: false,
      source: 'local',
        description: "fdsfhsfhbsufdsfhsdiufgsuyifgjdsy7fgsduyfgsdyftwe7yfgewy7grfew67tfgrweyufgwe67fgwfsdyfgshfgsduyfgtds"

    ),
    ProductModel(
      id: "6",
      image: [Constants.product1, Constants.product1, Constants.product1],
      name: 'The Denim Jean',
      quantity: 0,
      price: 59.99,
      rating: 4.0,
      reviews: '5.8k reviews',
      size: 'M',
      isFavorite: false,
      isCart: false,
      source: 'local',
        description: "fdsfhsfhbsufdsfhsdiufgsuyifgjdsy7fgsduyfgsdyftwe7yfgewy7grfew67tfgrweyufgwe67fgwfsdyfgshfgsduyfgtds"
,

    ),
    // Add more products as needed
  ];
}