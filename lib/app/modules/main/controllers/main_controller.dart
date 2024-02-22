import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_admin/app/modules/dashboard/views/dashboard_view.dart';
import 'package:happy_admin/app/modules/log_out/views/log_out_view.dart';
import 'package:happy_admin/app/modules/pet_categories/views/pet_categories_view.dart';
import 'package:happy_admin/app/modules/pet_profiles/views/pet_profiles_view.dart';
import 'package:happy_admin/app/modules/product_categories/views/product_categories_view.dart';
import 'package:happy_admin/app/modules/product_sellers/views/product_sellers_view.dart';
import 'package:happy_admin/app/modules/products/views/products_view.dart';
import 'package:happy_admin/app/modules/transactions/views/transactions_view.dart';
import 'package:happy_admin/app/modules/user_profiles/views/user_profiles_view.dart';

class MainController extends GetxController {
  final GlobalKey<NavigatorState> navigationKey = GlobalKey();

  // Future<dynamic> navigateTo(String routeName) {
  //   return navigationKey.currentState!.pushNamed(routeName);
  // }

  // goBack() => navigationKey.currentState!.pop();

  RxInt index = 0.obs;

  var pages = const [
    UserProfilesView(),
    DashboardView(),
    PetCategoriesView(),
    PetProfilesView(),
    ProductCategoriesView(),
    ProductSellersView(),
    ProductsView(),
    TransactionsView(),
    LogOutView(),
  ];

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
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
