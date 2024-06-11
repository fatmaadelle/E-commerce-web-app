  import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
  import 'package:flutter_screenutil/flutter_screenutil.dart';
  import 'package:flutter_svg/svg.dart';
  import 'package:get/get.dart';
  import '../../../utils/constants.dart';
  import '../../data/models/product_model.dart';
  import '../../routes/app_pages.dart';
  import '../modules/home/controllers/home_controller.dart';


  bool isAuthenticated() {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    return currentUser != null;
  }
  class ProductItem extends StatelessWidget {
    final ProductModel product;

    const ProductItem({Key? key, required this.product}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      final theme = Theme.of(context);

      return GestureDetector(
        onTap: () => Get.toNamed(Routes.PRODUCT_DETAILS, arguments: product),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Stack(
              children: [
                // Product Image with Animation
                Hero(
                  tag: 'product_image_${product.id}',
                  child: GestureDetector(
                    onTap: () => Get.toNamed(Routes.PRODUCT_DETAILS, arguments: product),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: product.image != null && product.image!.isNotEmpty
                          ? Image.network(
                        product.image![0], // Fetch the image URL from Firebase Storage
                        height: 260.h,
                        width: double.infinity,
                        fit: BoxFit.contain,
                      )
                          : Container(), // Add a placeholder widget here when the image list is null or empty
                    ),
                  ),
                ),
                // Product Details
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.8),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Name
                        Text(
                          product.name!,
                          style: theme.textTheme.headline6!.copyWith(color: Colors.white),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 5),
                        // Product Price
                        Text(
                          '\$${product.price}',
                          style: theme.textTheme.subtitle1!.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                // Favorite Button
                // Favorite Button
                // Favorite Button
                Positioned(
                  top: 20,
                  right: 20,
                  child: GetBuilder<HomeController>(
                    id: 'FavoriteButton',
                    builder: (controller) {
                      final productDoc = controller.products.firstWhere(
                            (product) => product.id == this.product.id,
                        orElse: () => ProductModel(), // Return default instance if no element is found
                      );
                      // Check if productDoc is null before accessing its properties
                      if (productDoc.id == null) {
                        return SizedBox(); // or any fallback widget
                      }
                      return GestureDetector(
                        onTap: () { if (isAuthenticated()) {
                          controller.onFavoriteButtonPressed(
                              productId: productDoc.id!);
                        }
                        else{
                          Get.snackbar(
                            "Must Be Loggedin First",
                            "",
                            backgroundColor: Colors.black,
                            colorText: Colors.white,
                            duration: Duration(seconds: 2),
                          );
                          Get.offNamed(Routes.LOGIN);
                        }
                      },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 20.r,
                            backgroundColor: Colors.white,
                            child: Container(
                              height: 15.h,
                              width: 15.w,
                              child: SvgPicture.asset(
                                controller.isProductInFavorites(productDoc.id!)
                                    ? Constants.favFilledIcon // Icon when the product is in favorites
                                    : Constants.favOutlinedIcon, // Icon when the product is not in favorites
                                color: productDoc.isFavorite! ? null : theme.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Cart Button
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: GetBuilder<HomeController>(
                    id: "CartButton",
                    builder: (HomeController controller) {
                      final productDoc = controller.products.firstWhere(
                            (product) => product.id == this.product.id,
                        orElse: () => ProductModel(), // Return null if no element is found
                      );
                      return GestureDetector(
                        onTap: () { if (isAuthenticated()) {
                          controller.onCartButtonPressed(
                              productId: productDoc.id!);
                        }
                        else{
                          Get.snackbar(
                            "Must Be Loggedin First",
                            "",
                            backgroundColor: Colors.black,
                            colorText: Colors.white,
                            duration: Duration(seconds: 2),
                          );
                          Get.offNamed(Routes.LOGIN);
                        }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.white,
                            child: IconButton(
                              icon: Icon(
                                controller.isProductInCart(productDoc.id!)
                                    ? Icons.shopping_cart
                                    : Icons.add_shopping_cart,
                                color: productDoc.isCart! ? Colors.indigo[900] : Colors.black,
                              ),
                              onPressed: () =>
                                  controller.onCartButtonPressed(productId: product.id!),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }