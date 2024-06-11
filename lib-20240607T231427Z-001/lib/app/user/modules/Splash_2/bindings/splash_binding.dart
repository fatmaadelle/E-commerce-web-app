import 'package:get/get.dart';

import '../controllers/splash_controller.dart';


class Splash_2Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Splash_2Controller>(
      () => Splash_2Controller(),
    );
  }
}
