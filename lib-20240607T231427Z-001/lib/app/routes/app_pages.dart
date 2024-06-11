import 'package:ecommerce_app/app/user/modules/Splash_2/bindings/splash_binding.dart';
import 'package:ecommerce_app/app/user/modules/orders/bindings/orders_binding.dart';
import 'package:ecommerce_app/app/user/modules/orders/views/orders_view.dart';
import 'package:ecommerce_app/app/user/modules/payment/bindings/payment_binding.dart';
import 'package:ecommerce_app/app/user/modules/payment/views/payment_views.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import '../user/modules/Splash_1/bindings/splash_binding.dart';
import '../user/modules/Splash_1/views/splash_view.dart';
import '../user/modules/Splash_2/views/splash_view.dart';
import '../user/modules/Splash_3/bindings/splash_binding.dart';
import '../user/modules/Splash_3/views/splash_view.dart';
import '../user/modules/about_us/bindings/about_us_binding.dart';
import '../user/modules/about_us/views/about_us_view.dart';
import '../user/modules/cart/bindings/cart_binding.dart';
import '../user/modules/cart/views/cart_view.dart';
import '../user/modules/contact_us/bindings/contact_us_binding.dart';
import '../user/modules/contact_us/views/contact_us_view.dart';
import '../user/modules/favorites/bindings/favorites_binding.dart';
import '../user/modules/favorites/views/favorites_view.dart';
import '../user/modules/forgottenPassword/bindings/forgotten_password_binding.dart';
import '../user/modules/forgottenPassword/views/forgotten_password_view.dart';
import '../user/modules/home/bindings/home_binding.dart';
import '../user/modules/home/views/home_view.dart';
import '../user/modules/login/bindings/login_bindings.dart';
import '../user/modules/login/views/login.dart';
import '../user/modules/notifications/bindings/notifications_binding.dart';
import '../user/modules/notifications/views/notifications_view.dart';
import '../user/modules/product_details/bindings/product_details_binding.dart';
import '../user/modules/product_details/views/product_details_view.dart';
import '../user/modules/profile/bindings/profile_bindings.dart';
import '../user/modules/profile/views/profile_views.dart';
import '../user/modules/register/bindings/register_bindings.dart';
import '../user/modules/register/views/register_views.dart';
import '../user/modules/settings/bindings/settings_binding.dart';
import '../user/modules/settings/views/settings_view.dart';
import '../user/modules/splash/bindings/splash_binding.dart';
import '../user/modules/splash/views/splash_view.dart';
part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;
  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_FAVORITES,
      page: () => const Splash_1View(),
      binding: Splash_1Binding(),
    ),
    GetPage(
      name: _Paths.SPLASH_CART,
      page: () => const Splash_2View(),
      binding: Splash_2Binding(),
    ),
    GetPage(
      name: _Paths.SPLASH_PROFILE,
      page: () => const Splash_3View(),
      binding: Splash_3Binding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () =>  HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.FAVORITES,
      page: () =>  FavoritesView(),
      binding: FavoritesBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: _Paths.CART,
      page: () =>  CartView(),
      binding: CartBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: _Paths.NOTIFICATIONS,
      page: () => const NotificationsView(),
      binding: NotificationsBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_DETAILS,
      page: () =>   ProductDetailsView(),
      binding: ProductDetailsBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () =>  LoginView(),
      binding: LoginBinding(),
      transition: Transition.zoom,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () =>  RegisterView(),
      binding: RegisterBinding(),
      transition: Transition.zoom,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: _Paths.FORGOTTEN,
      page: () => ForgottenPasswordView(),
      binding: ForgottenPasswordBinding(),
      transition: Transition.zoom,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: _Paths.ABOUTUS,
      page: () => AboutUsView(),
      binding: AboutUsBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: _Paths.CONTACTUS,
      page: () => ContactUsView(),
      binding: ContactUsBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: _Paths.PAYMENT,
      page: () => PaymentView(),
      binding: PaymentBindings(),
    ),
    GetPage(
      name: _Paths.ORDERS,
      page: () => OrdersView(),
      binding: OrdersBinding(),
    ),
  ];
}
