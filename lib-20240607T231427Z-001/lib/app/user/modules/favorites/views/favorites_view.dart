import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../data/models/product_model.dart';
import '../../../components/app_bar.dart';
import '../../../components/bottom_navigation_bar.dart';
import '../../../components/drawer.dart';
import '../../../components/footer.dart';
import '../../../components/no_data.dart';
import '../../../components/product_item.dart';
import '../../../components/screen_title.dart';
import '../controllers/favorites_controller.dart';

class FavoritesView extends GetView<FavoritesController> {
  FavoritesView({Key? key}) : super(key: key);
  final FavoritesController _controller = Get.put(FavoritesController());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isPhone = screenWidth < 700;
    _controller.getFavoriteProducts();

    final bottomNavigationBarController = BottomNavigationBarController(selectedIndex: 1);

    return Scaffold(
      appBar: ResponsiveAppBar(selectedIndex: 1),
      drawer: DefaultDrawer(),
      bottomNavigationBar: isPhone && screenHeight > 200
          ? bottomNavigationBarController.buildBottomNavigationBar()
          : null, // Conditionally show/hide bottom navigation bar
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                30.verticalSpace,
                const ScreenTitle(
                  title: 'Favorites',
                  dividerEndIndent: 200,
                ),
                20.verticalSpace,
                StreamBuilder<List<ProductModel>>(
                  stream: _controller.favoriteProductsStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error loading favorites'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const NoData(text: 'No Products in Favorite Yet!');
                    } else {
                      final favoriteProducts = snapshot.data!;
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: isPhone ? 2 : 4, // Adjusted crossAxisCount
                          crossAxisSpacing: 15.w,
                          mainAxisSpacing: 15.h,
                          mainAxisExtent: 260.h,
                        ),
                        shrinkWrap: true,
                        primary: false,
                        itemCount: favoriteProducts.length,
                        itemBuilder: (context, index) => Stack(
                          children: [
                            ProductItem(
                              product: favoriteProducts[index],
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          10.verticalSpace,
          if (!isPhone) FooterSection(),
        ],
      ),
    );
  }
}
