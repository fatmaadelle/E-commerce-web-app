import 'package:ecommerce_app/app/user/modules/product_details/views/widgets/review_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import '../../../../../utils/constants.dart';
import '../../../../data/models/review_model.dart';
import '../../../../routes/app_pages.dart';
import '../../../components/app_bar.dart';
import '../../../components/bottom_navigation_bar.dart';
import '../../../components/custom_button.dart';
import '../../../components/drawer.dart';
import '../../../components/rounded_button.dart';
import '../controllers/product_details_controller.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

bool isAuthenticated() {
  final User? currentUser = FirebaseAuth.instance.currentUser;
  return currentUser != null;
}

class ProductDetailsView extends GetView<ProductDetailsController> {
  ProductDetailsView({Key? key}) : super(key: key);
  ProductDetailsController Controller = Get.put(ProductDetailsController());
  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: ResponsiveAppBar(selectedIndex: 8,),
      drawer: DefaultDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 450.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFEDF1FA),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.r),
                    bottomRight: Radius.circular(30.r),
                  ),
                ),
                child: Stack(
                  children: [
                    ImageSlideshow(
                      width: double.infinity,
                      height: 450.h,
                      initialPage: 0,
                      indicatorColor: Colors.blue,
                      indicatorBackgroundColor: Colors.grey,
                      children: [
                        for (var image in controller.product?.image ?? [])
                          Image.network(image, fit: BoxFit.contain),
                      ],
                      onPageChanged: (value) {
                        // Do something when page changes
                      },
                      autoPlayInterval: 3000,
                      isLoop: true,
                    ),
                    Positioned(
                      top: 30.h,
                      left: 20.w,
                      right: 20.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GetBuilder<ProductDetailsController>(
                            id: 'FavoriteButton',
                            builder: (_) => StreamBuilder<DocumentSnapshot>(
                              stream: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).collection('favorites').doc(controller.product?.id).snapshots(),
                              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  return Text('Something went wrong');
                                }

                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                }

                                bool isFavorite = snapshot.data?.exists ?? false;
                                return RoundedButton(
                                  onPressed: () {if(isAuthenticated()){
                                    controller.onFavoriteButtonPressed();}
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
                                  child: SvgPicture.asset(
                                    isFavorite ? Constants.favFilledIcon : Constants.favOutlinedIcon,
                                    width: 10.w,
                                    height: 10.h,
                                    color: isFavorite ? null : Color(0xFF40DF9F),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      controller.product?.name ?? '',
                      style: theme.textTheme.bodyText1,
                    ),
                    Spacer(),
                    Text(
                      '\$${controller.product?.price ?? ''}',
                      style: theme.textTheme.headline1,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Container(
                      decoration:BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(
                            color: Colors.transparent
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      width: MediaQuery.sizeOf(context).width*0.9,
                      height: MediaQuery.sizeOf(context).width>700?250:150,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            "${controller.product?.description}",
                            style: TextStyle(fontWeight: FontWeight.bold,
                                color: Colors.black
                            ),
                          ),
                        ),
                      )
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.all( 30.w),
                child: CustomButton(
                  text: 'Add to Cart',
                  onPressed: () {
                    if(isAuthenticated()){
                    controller.onAddToCartPressed();
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
              SizedBox(height: 10.h),
              StreamBuilder<List<ReviewModel>>(
                stream: Controller.reviewsStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No reviews yet',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 40
                    ),));
                  }
                  List<ReviewModel> reviews = snapshot.data!;
                  return Column(
                    children: [
                      Center(child: Text("Reviews :",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 50,
                            color: Colors.black
                        ),
                      ),),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: reviews.length,
                        itemBuilder: (context, index) {
                          ReviewModel review = reviews[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(width: 2, color: Colors.grey),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.6),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(child: Image.network("https://firebasestorage.googleapis.com/v0/b/market-f41cc.appspot.com/o/avatar.jpg?alt=media&token=1ab76c48-b042-4c83-bccb-26def12b9cc7"),
                                          radius: screenWidth>800?40:25,),
                                          SizedBox(width: 10,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(review.userName),
                                              Text(
                                              review.userEmail,
                                                style: TextStyle(fontSize: 10.sp, color: Colors.grey),
                                              ),                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        DateFormat('dd-MMM-yyyy').format(review.timestamp),
                                        style: TextStyle(fontSize: 10.sp, color: Colors.grey),
                                      ),
                                      SizedBox(height: 20,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          RatingBar.builder(
                                            initialRating: review.rating,
                                            minRating: 0,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemSize: 20,
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: Colors.yellow[700],
                                            ),
                                            onRatingUpdate: (_) {},
                                            ignoreGestures: true,
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            review.review,
                                            style: TextStyle(fontSize: 16.sp),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: ReviewForm(
                  onSubmit: (rating, review) {
                    controller.submitReview(rating, review);
                  },
                ),
              ),
            ],
          ),
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