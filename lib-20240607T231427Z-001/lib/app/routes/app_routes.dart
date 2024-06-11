part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const SPLASH = _Paths.SPLASH;
  static const SPLASH_FAVORITES = _Paths.SPLASH_FAVORITES;
  static const SPLASH_CART = _Paths.SPLASH_CART;
  static const SPLASH_PROFILE = _Paths.SPLASH_PROFILE;
  static const BASE = _Paths.BASE;
  static const HOME = _Paths.HOME;
  static const FAVORITES = _Paths.FAVORITES;
  static const CART = _Paths.CART;
  static const NOTIFICATIONS = _Paths.NOTIFICATIONS;
  static const SETTINGS = _Paths.SETTINGS;
  static const PRODUCT_DETAILS = _Paths.PRODUCT_DETAILS;
  static const LOGIN = _Paths.LOGIN;
  static const PROFILE = _Paths.PROFILE;
  static const REGISTER = _Paths.REGISTER;
  static const FORGOTTEN = _Paths.FORGOTTEN;
  static const ABOUTUS = _Paths.ABOUTUS;
  static const CONTACTUS = _Paths.CONTACTUS;
  static const PRODUCTMANGE = _Paths.PRODUCTMANAGE;
  static const PAYMENT = _Paths.PAYMENT;
  static const ORDERS = _Paths.ORDERS;
}

abstract class _Paths {
  _Paths._();
  static const SPLASH = '/splash';
  static const SPLASH_FAVORITES = '/splash_favorites';
  static const SPLASH_CART = '/splash_cart';
  static const SPLASH_PROFILE = '/splash_profile';

  static const BASE = '/base';
  static const HOME = '/home';
  static const FAVORITES = '/favorites';
  static const CART = '/cart';
  static const NOTIFICATIONS = '/notifications';
  static const SETTINGS = '/settings';
  static const PRODUCT_DETAILS = '/product-details';
  static const LOGIN = '/login';
  static const PROFILE = '/profile';
  static const REGISTER = '/register';
  static const FORGOTTEN = '/forgotten';
  static const ORDERS = '/orders';
  static const ABOUTUS = '/about_us';
  static const CONTACTUS = '/contact_us';
  static const PRODUCTMANAGE = '/product_management';
  static const PAYMENT = '/payment';
}
