import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/app/data/models/product_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../app/data/models/product_model.dart';
import 'drawer.dart';

class ProductTable extends StatefulWidget {
  const ProductTable({Key? key}) : super(key: key);

  @override
  _ProductTableState createState() => _ProductTableState();
}

class _ProductTableState extends State<ProductTable> {
  final List<ProductModel> _productData = [];
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.black,
          title: Center(
            child: Text(
              "Products Management",
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          automaticallyImplyLeading: false, // Disable the default back arrow
        ),
        floatingActionButton:  Container(
          width: 200,
          child: FloatingActionButton(
            backgroundColor: Colors.black,
            onPressed: () {
              _addProductData();
              },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Add New Product'
              ,style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),),
              SizedBox(width: 5,),
              FaIcon(FontAwesomeIcons.add,color: Colors.white,)
            ],
          )
            ,),
        ),
        body:Row(
          children: [
            Container(
              width: 250,
              child: defaultDrawer(),),
      SizedBox(width: 15,),
      Expanded(
                child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _productData.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        product: _productData[index],
                        onEdit: (editedProduct) {
                          setState(() {
                            _productData[index] = editedProduct;
                          });
                        },
                        onDelete: (productId) {
                          _deleteProductFromFirestore(productId);
                        },
                      );
                    },
                  ),
                ),
                      ],
                    ),
              ),
            ]),

        );

  }

  void _addProductData() async {
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    final descriptionController = TextEditingController();
    final categoryController = TextEditingController();
    final discountController = TextEditingController();
    List<XFile>? selectedImages;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Product'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(hintText: 'Name'),
                ),
                TextField(
                  controller: priceController,
                  decoration: InputDecoration(hintText: 'Price'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(hintText: 'Description'),
                ),
                TextField(
                  controller: categoryController,
                  decoration: InputDecoration(hintText: 'Category'),
                ),
                TextField(
                  controller: discountController,
                  decoration: InputDecoration(hintText: 'Discount'),
                ),
                ElevatedButton(
                  child: Text('Select Images'),
                  onPressed: () async {
                    selectedImages = await _picker.pickMultiImage();
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _disposeControllers(nameController, priceController, descriptionController, categoryController, discountController);
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (_validateInput(priceController.text, discountController.text)) {
                  try {
                    await _addProductToFirestore(nameController.text, double.parse(priceController.text), descriptionController.text, double.parse(discountController.text), selectedImages!);
                    _disposeControllers(nameController, priceController, descriptionController, categoryController, discountController);
                    Navigator.pop(context);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('An error occurred. Please try again.')),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Invalid input. Enter valid numbers.')),
                  );
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> fetchAllProducts() async {
    // Fetch products from DummyHelper

    // Fetch products from Firestore
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection('product').get();
    List<ProductModel> firestoreProducts = querySnapshot.docs.map((doc) {
      final json = doc.data();
      final documentId = doc.id;
      return ProductModel.fromJson(json, documentId);
    }).toList();

    // Combine products from both sources
    List<ProductModel> allProducts = [...firestoreProducts];

    // Sort products by name
    allProducts.sort((a, b) => a.name!.compareTo(b.name!));

    // Update the state with the fetched products
    if (mounted) {
      setState(() {
        _productData.clear();
        _productData.addAll(allProducts);
      });
    }
  }

  bool _validateInput(String price, String discount) {
    final numberRegex = RegExp(r'^-?(\d+\.?\d*|\.\d+)$');
    return numberRegex.hasMatch(price) && numberRegex.hasMatch(discount);
  }

  Future<List<String>> _uploadImages(List<XFile>? selectedImages) async {
    List<String> imagePaths = [];
    if (selectedImages != null) {
      for (var imageFile in selectedImages) {
        var ref = FirebaseStorage.instance.ref().child("images/${DateTime.now().toString()}");
        var imageData = await imageFile.readAsBytes();
        var uploadTask = ref.putData(imageData);
        var downloadUrl = await (await uploadTask).ref.getDownloadURL();
        imagePaths.add(downloadUrl);
      }
    }
    return imagePaths;
  }

  Future<void> _addProductToFirestore(String name, double price, String description, double discount, List<XFile> selectedImages) async {
    // Create a new document reference in the 'product' collection
    DocumentReference newProductDoc = FirebaseFirestore.instance.collection('product').doc();

    // Upload images and get their URLs
    List<String> imagePaths = await _uploadImages(selectedImages);

    // Create a new ProductModel with the generated document ID
    ProductModel product = ProductModel(
      id: newProductDoc.id,
      name: name,
      price: price,
      description: description,
      discount: discount,
      image: imagePaths,
    );

    // Add the product to Firestore using the generated document ID
    await newProductDoc.set(product.toJson());

    // Add the product to the local state
    if (mounted) {
      setState(() {
        _productData.add(product);
      });
    }
  }

  void _disposeControllers(TextEditingController nameController, TextEditingController priceController, TextEditingController descriptionController, TextEditingController categoryController, TextEditingController discountController) {
    nameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    categoryController.dispose();
    discountController.dispose();
  }

  Future<void> _deleteProductFromFirestore(String productId) async {
    try {
      // Delete the product document from Firestore
      await FirebaseFirestore.instance.collection('product').doc(productId).delete();

      // Remove the product from the local state
      setState(() {
        _productData.removeWhere((product) => product.id == productId);
      });
    } catch (e) {
      // Handle any errors that occur during deletion
      print('Error deleting product: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred while deleting the product. Please try again.')),
      );
    }
  }
}

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final Function(ProductModel) onEdit;
  final Function(String) onDelete;

  ProductCard({required this.product, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(elevation: 50,
      child: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(product.name ?? '', style: TextStyle(fontWeight: FontWeight.bold,
              color: Colors.white)),
              Text('\$${product.price?.toStringAsFixed(2)}',style: TextStyle(
                color: Colors.white
              ),
              ),
              Text(product.description ?? '',style: TextStyle(
                  color: Colors.white
              ),),
              if (product.discount != null && product.discount! > 0) Text('Discount: ${product.discount}%',style: TextStyle(
          color: Colors.white
              ),
              ),
              if (product.image != null && product.image!.isNotEmpty)
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: product.image!.length,
                    itemBuilder: (context, index) {
                      final imageUrl = product.image![index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Image.network(
                          imageUrl,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[300],
                              child: Center(
                                child: Text('Image not available',style: TextStyle(
              color: Colors.white
              ),),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit,
                    color: Colors.blue[800],),
                    onPressed: () => _showEditDialog(context, product, onEdit),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete,
                    color: Colors.red[700],),
                    onPressed: () => onDelete(product.id!),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context, ProductModel product, Function(ProductModel) onEdit) {
    final nameController = TextEditingController(text: product.name);
    final priceController = TextEditingController(text: product.price?.toString());
    final descriptionController = TextEditingController(text: product.description);
    final discountController = TextEditingController(text: product.discount?.toString());

    List<XFile>? selectedImages;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Product'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(hintText: 'Name'),
                ),
                TextField(
                  controller: priceController,
                  decoration: InputDecoration(hintText: 'Price'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(hintText: 'Description'),
                ),
                TextField(
                  controller: discountController,
                  decoration: InputDecoration(hintText: 'Discount'),
                ),
                ElevatedButton(
                  child: Text('Select Images'),
                  onPressed: () async {
                    selectedImages = await ImagePicker().pickMultiImage();
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                nameController.dispose();
                priceController.dispose();
                descriptionController.dispose();
                discountController.dispose();
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                double? price = double.tryParse(priceController.text);
                double? discount = double.tryParse(discountController.text);

                if (price != null) {
                  List<String> imagePaths = [];
                  if (selectedImages != null) {
                    for (var image in selectedImages!) {
                      var ref = FirebaseStorage.instance.ref().child("images/${DateTime.now().toString()}");
                      var imageData = await image.readAsBytes();
                      var uploadTask = ref.putData(imageData);
                      var downloadUrl = await (await uploadTask).ref.getDownloadURL();
                      imagePaths.add(downloadUrl);
                    }
                  }

                  product = product.copyWith(
                    name: nameController.text,
                    price: price,
                    description: descriptionController.text,
                    discount: discount,
                    image: imagePaths,
                  );

                  onEdit(product);

                  // Update the product in Firebase Firestore
                  await FirebaseFirestore.instance.collection('product').doc(product.id).set(product.toJson());

                  // Clear controllers
                  nameController.dispose();
                  priceController.dispose();
                  descriptionController.dispose();
                  discountController.dispose();

                  // Close the dialog
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Invalid input. Enter valid numbers.')),
                  );
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
