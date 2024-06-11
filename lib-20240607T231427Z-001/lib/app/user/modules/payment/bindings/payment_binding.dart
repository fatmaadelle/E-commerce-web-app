import 'package:ecommerce_app/app/user/modules/payment/controller/payment_controller.dart';
import 'package:get/get.dart';



class PaymentBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentController>(
          () => PaymentController(),
    );
  }
}
