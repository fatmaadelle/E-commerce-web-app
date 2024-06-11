import 'package:get/get.dart';

import '../controllers/register_controllers.dart';


class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(
          () => RegisterController(),
    );
  }
}
