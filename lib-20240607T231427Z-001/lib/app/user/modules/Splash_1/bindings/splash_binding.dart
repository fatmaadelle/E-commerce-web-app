import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class Splash_1Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Splash_1Controller>(
      () => Splash_1Controller(),
    );
  }
}
