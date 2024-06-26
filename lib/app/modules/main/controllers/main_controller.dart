import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_admin/app/modules/dashboard/views/dashboard_view.dart';
import 'package:happy_admin/app/modules/log_out/views/log_out_view.dart';
import 'package:happy_admin/app/modules/orders/controllers/orders_controller.dart';
import 'package:happy_admin/app/modules/orders/views/orders_view.dart';
import 'package:happy_admin/app/modules/pet_categories/views/pet_categories_view.dart';
import 'package:happy_admin/app/modules/pet_profiles/controllers/pet_profiles_controller.dart';
import 'package:happy_admin/app/modules/product_categories/views/product_categories_view.dart';
import 'package:happy_admin/app/modules/products/controllers/products_controller.dart';
import 'package:happy_admin/app/modules/products/views/products_view.dart';
import 'package:happy_admin/app/modules/transactions/controllers/transactions_controller.dart';
import 'package:happy_admin/app/modules/transactions/views/transactions_view.dart';
import 'package:happy_admin/app/modules/user_profiles/controllers/user_profiles_controller.dart';
import 'package:happy_admin/app/modules/user_profiles/views/user_profiles_view.dart';

class MainController extends GetxController {
  final GlobalKey<NavigatorState> navigationKey = GlobalKey();

  // Future<dynamic> navigateTo(String routeName) {
  //   return navigationKey.currentState!.pushNamed(routeName);
  // }

  // goBack() => navigationKey.currentState!.pop();

  RxInt index = 0.obs;

  var pages = const [
    DashboardView(),
    UserProfilesView(),
    PetCategoriesView(),
    // PetProfilesView(),
    ProductCategoriesView(),
    // ProductSellersView(),
    ProductsView(),
    TransactionsView(),
    OrdersView(),
    LogOutView(),
  ];

  UserProfilesController userController = UserProfilesController();
  TransactionsController transactionController = TransactionsController();
  ProductsController productController = ProductsController();
  OrdersController ordersController = OrdersController();

  final count = 0.obs;
  @override
  void onInit() async {
    super.onInit();
    userController = Get.put(UserProfilesController());
    productController = Get.put(ProductsController());
    transactionController = Get.put(TransactionsController());
    ordersController = Get.put(OrdersController());
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
