import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../utils/constants.dart';
import '../controllers/splash_controller.dart';

class Splash_3View extends GetView<Splash_3Controller> {
  const Splash_3View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(Splash_3Controller());
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
