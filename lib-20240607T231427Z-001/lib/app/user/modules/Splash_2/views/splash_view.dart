import 'package:ecommerce_app/app/user/modules/Splash_2/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../utils/constants.dart';

class Splash_2View extends GetView<Splash_2Controller> {
  const Splash_2View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(Splash_2Controller());
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    Constants.logo,
                    width: 700.w,
                    height: 500.h,
                  ).animate().fade().slideY(
                      duration: const Duration(milliseconds: 500),
                      begin: 1,
                      curve: Curves.easeInSine
                  ),
                ),
                Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[900]!),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
