import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../components/custom_button.dart';


bool isAuthenticated() {
  final User? currentUser = FirebaseAuth.instance.currentUser;
  return currentUser != null;
}
class ReviewForm extends StatefulWidget {
  final Function(double rating, String review) onSubmit;

  ReviewForm({required this.onSubmit});

  @override
  _ReviewFormState createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _reviewController = TextEditingController();
  double _rating = 0;

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Container(
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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Add Review:',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Rate:',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      height: 40.h,
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
                      child: RatingBar.builder(
                        initialRating: _rating,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.yellow[700],
                        ),
                        onRatingUpdate: (rating) {
                          setState(() {
                            _rating = rating;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
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
                  child: TextFormField(
                    controller: _reviewController,
                    decoration: InputDecoration(
                      labelText: 'Write Your Review Here',
                      enabled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    maxLines: 2,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your review';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.50,
                  child: CustomButton(
                    text: 'Submit Review',
                    onPressed: () {
                      if(isAuthenticated()) {
                        if (_formKey.currentState!.validate()) {
                          widget.onSubmit(_rating, _reviewController.text);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Review added',style: TextStyle(color: Colors.black),)),
                          );
                          setState(() {
                            _rating = 0;
                            _reviewController.clear();
                          });
                        }
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
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
