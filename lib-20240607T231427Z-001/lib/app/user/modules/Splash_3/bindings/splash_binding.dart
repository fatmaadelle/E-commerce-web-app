import 'package:ecommerce_app/app/user/modules/Splash_3/controllers/splash_controller.dart';
import 'package:get/get.dart';


class Splash_3Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Splash_3Controller>(
      () => Splash_3Controller(),
    );
  }
}
