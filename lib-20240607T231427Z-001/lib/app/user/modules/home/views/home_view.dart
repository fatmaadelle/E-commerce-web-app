import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import '../../../../../utils/constants.dart';
import '../../../../data/models/product_model.dart';
import '../../../components/app_bar.dart';
import '../../../components/bottom_navigation_bar.dart';
import '../../../components/drawer.dart';
import '../../../components/footer.dart';
import '../../../components/product_item.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  final BottomNavigationBarController _bottomNavigationBarController =
  BottomNavigationBarController(selectedIndex: 0);
  HomeView({Key? key}) : super(key: key);

  final HomeController _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: ResponsiveAppBar(selectedIndex: 0),
      drawer: DefaultDrawer(),
      body: StreamBuilder<List<ProductModel>>(
        stream: _controller.getProductStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final products = snapshot.data!;
            return ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: screenWidth,
                          height:screenWidth >1200? screenHeight * 0.5 :screenWidth>700? screenHeight *0.40: screenHeight *0.30,
                          child: ImageSlideshow(
                            indicatorColor: Colors.indigo[900],
                            indicatorBackgroundColor: Colors.grey,
                            indicatorRadius: 5,
                            width: screenWidth,
                            height: screenHeight ,
                            initialPage: 0,
                            autoPlayInterval: 5000,
                            isLoop: true,
                            children: [
                              MaterialButton(
                                onPressed: () {
                                  print(1);
                                },
                                child: Image.asset(
                                  Constants.home_slide_show1,
                                  fit:BoxFit.fill,
                                  width: screenWidth,
                                  height: screenHeight * 0.5,
                                ),
                              ),
                              MaterialButton(
                                onPressed: () {
                                  print(2);
                                },
                                child: Image.asset(
                                  Constants.home_slide_show2,
                                  fit: BoxFit.fill,
                                  width: screenWidth,
                                  height: screenHeight * 0.5,
                                ),
                              ),
                              MaterialButton(
                                onPressed: () {
                                  print(3);
                                },
                                child: Image.asset(
                                  Constants.home_slide_show3,
                                  fit: BoxFit.fill,
                                  width: screenWidth,
                                  height: screenHeight * 0.5,
                                ),
                              ),
                              MaterialButton(
                                onPressed: () {
                                  print(4);
                                },
                                child: Image.asset(
                                  Constants.home_slide_show4,
                                  fit: BoxFit.fill,
                                  width: screenWidth,
                                  height: screenHeight * 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Products",
                          style: context.theme.textTheme.displayLarge?.copyWith(
                            fontSize: 30.sp,
                          ),
                        ),
                        Divider(
                          thickness: 3,
                          endIndent: screenWidth * 0.2,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: screenWidth < 700 ? 2 : 4,
                          crossAxisSpacing: 2.w,
                          mainAxisSpacing: 15.h,
                          mainAxisExtent: 260.h,
                        ),
                        shrinkWrap: true,
                        primary: false,
                        itemCount: products.length,
                        itemBuilder: (context, index) => ProductItem(
                          product: products[index],
                        ),
                      ),
                    ),
                    FooterSection(),
                  ],
                ),
              ],
            );
          }
        },
      ),
      bottomNavigationBar:
      screenWidth < 700 && screenHeight > 200 ? _bottomNavigationBarController.buildBottomNavigationBar() : null,
    );
  }
}