import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../../utils/constants.dart';
import '../../../../../data/models/product_model.dart';
import '../../controllers/cart_controller.dart';

class CartItem extends GetView<CartController> {
  final ProductModel product;
  const CartItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Padding(
      padding: EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0,
                right: 20.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25.r),
                  child: AspectRatio(
                    aspectRatio: 1 ,
                    child: Image.network(
                      product.image![0], // Assuming product.image is an asset path
                      fit: BoxFit.contain,
                      height: 200,
                      width: 150,
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5.h),
                  Text(
                    product.name!,
                    style: theme.textTheme.displayMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5.h),
                  Text('Size: ${product.size}', style: theme.textTheme.bodyMedium?.copyWith(fontSize: 16.sp)),
                  SizedBox(height: 5.h),
                  Text('\$${product.price}', style: theme.textTheme.displayLarge?.copyWith(
                    fontSize: 18.sp,
                  ),),
                  SizedBox(height: 10.h),
                  GetBuilder<CartController>(
                    id: 'ProductQuantity',
                    builder: (controller) {
                      return FutureBuilder<DocumentSnapshot>(
                        future: controller.getProductQuantityFromCart(product.id!),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.hasData && snapshot.data!.exists) {
                            var productQuantity = snapshot.data!['quantity'].toString();
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () => controller.onDecreasePressed(product.id!), // Decrease button should decrease the quantity
                                  child: SvgPicture.asset(Constants.decreaseIcon),
                                ),
                                SizedBox(width: 10.w),
                                Text(productQuantity, style: theme.textTheme.displaySmall),
                                SizedBox(width: 10.h),
                                GestureDetector(
                                  onTap: () => controller.onIncreasePressed(product.id!), // Increase button should increase the quantity
                                  child: SvgPicture.asset(Constants.increaseIcon),
                                ),
                              ],
                            );
                          } else {
                            return Text('Product not found');
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () => controller.onDeletePressed(product.id!),
                      customBorder: CircleBorder(),
                      child: Container(
                        padding: EdgeInsets.all(10.r),
                        child: FaIcon(
                          FontAwesomeIcons.trash,
                          color: Colors.red[800],
                          size: 25,
                        )
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}