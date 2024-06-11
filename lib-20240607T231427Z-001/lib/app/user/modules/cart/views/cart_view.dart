import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../data/models/product_model.dart';
import '../../../components/app_bar.dart';
import '../../../components/bottom_navigation_bar.dart';
import '../../../components/custom_button.dart';
import '../../../components/drawer.dart';
import '../../../components/footer.dart';
import '../../../components/no_data.dart';
import '../../../components/screen_title.dart';
import '../controllers/cart_controller.dart';
import 'widgets/cart_item.dart';

class CartView extends GetView<CartController> {
  CartView({Key? key}) : super(key: key);
  final CartController _controller = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: ResponsiveAppBar(selectedIndex: 2),
      drawer: DefaultDrawer(),
      body: GetBuilder<CartController>(
        init: controller,
        builder: (_) => ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  SizedBox(height: 30.h),
                  ScreenTitle(
                    title: 'Cart',
                    dividerEndIndent: 280.w,
                  ),
                  SizedBox(height: 20.h),
                  StreamBuilder<List<ProductModel>>(
                    stream: _controller.getCartProductsStream(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator(); // Placeholder for loading state
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}'); // Placeholder for error state
                      } else {
                        final cartProducts = snapshot.data ?? [];
                        return cartProducts.isEmpty
                            ? NoData(text: 'No Products in Your Cart Yet!')
                            : ListView.builder(
                          itemCount: cartProducts.length,
                          itemBuilder: (context, index) => CartItem(
                            product: cartProducts[index],
                          ),
                          shrinkWrap: true,
                          primary: false,
                        );
                      }
                    },
                  ),
                  SizedBox(height: 30.h),
                  Visibility(
                    visible: controller.products.isNotEmpty,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Total:',
                              style: theme.textTheme.bodyText2?.copyWith(
                                  fontSize: 18.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 10.h),
                            Obx(() => Text(
                              '\$${controller.total.toStringAsFixed(2)}', // Listen to total changes
                              style: theme.textTheme.bodyText1?.copyWith(
                                decoration: TextDecoration.underline,
                                decorationColor: theme.primaryColor.withOpacity(1),
                                decorationThickness: 1,
                                color: Colors.transparent,
                                shadows: [
                                  Shadow(
                                    color: theme.textTheme.headline1!.color!,
                                    offset: Offset(0, 5),
                                  ),
                                ],
                              ),
                            )
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Visibility(
                    visible: controller.products.isNotEmpty,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: CustomButton(
                        text: 'Purchase Now',
                        onPressed: () => controller.onPurchaseNowPressed(),
                        fontSize: 16.sp,
                        radius: 12.r,
                        verticalPadding: 12.h,
                        hasShadow: true,
                        shadowColor: theme.primaryColor,
                        shadowOpacity: 0.3,
                        shadowBlurRadius: 4,
                        shadowSpreadRadius: 0,
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
            if (screenWidth > 700) FooterSection(),
            SizedBox(width: 0,)
          ],
        ),
      ),
      bottomNavigationBar: screenWidth < 700 && screenHeight > 200 ? _buildBottomNavigationBar() : null,
    );
  }

  Widget _buildBottomNavigationBar() {
    final BottomNavigationBarController _bottomNavigationBarController = BottomNavigationBarController(selectedIndex: 2);
    return _bottomNavigationBarController.buildBottomNavigationBar();
  }
}