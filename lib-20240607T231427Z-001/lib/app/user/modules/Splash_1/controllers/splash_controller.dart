import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';


class Splash_1Controller extends GetxController {

  @override
  void onInit() async {
    await Future.delayed(const Duration(seconds: 2));
    Get.offNamed(Routes.FAVORITES);
    super.onInit();
  }

}
