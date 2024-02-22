import 'package:get/get.dart';

import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/log_out/bindings/log_out_binding.dart';
import '../modules/log_out/views/log_out_view.dart';
import '../modules/main/bindings/main_binding.dart';
import '../modules/main/views/main_view.dart';
import '../modules/pet_categories/bindings/pet_categories_binding.dart';
import '../modules/pet_categories/views/pet_categories_view.dart';
import '../modules/pet_profiles/bindings/pet_profiles_binding.dart';
import '../modules/pet_profiles/views/pet_profiles_view.dart';
import '../modules/product_categories/bindings/product_categories_binding.dart';
import '../modules/product_categories/views/product_categories_view.dart';
import '../modules/product_sellers/bindings/product_sellers_binding.dart';
import '../modules/product_sellers/views/product_sellers_view.dart';
import '../modules/products/bindings/products_binding.dart';
import '../modules/products/views/products_view.dart';
import '../modules/transactions/bindings/transactions_binding.dart';
import '../modules/transactions/views/transactions_view.dart';
import '../modules/user_profiles/bindings/user_profiles_binding.dart';
import '../modules/user_profiles/views/user_profiles_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.MAIN;

  static final routes = [
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.USER_PROFILES,
      page: () => const UserProfilesView(),
      binding: UserProfilesBinding(),
    ),
    GetPage(
      name: _Paths.PET_CATEGORIES,
      page: () => const PetCategoriesView(),
      binding: PetCategoriesBinding(),
    ),
    GetPage(
      name: _Paths.PET_PROFILES,
      page: () => const PetProfilesView(),
      binding: PetProfilesBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_CATEGORIES,
      page: () => const ProductCategoriesView(),
      binding: ProductCategoriesBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_SELLERS,
      page: () => const ProductSellersView(),
      binding: ProductSellersBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCTS,
      page: () => const ProductsView(),
      binding: ProductsBinding(),
    ),
    GetPage(
      name: _Paths.TRANSACTIONS,
      page: () => const TransactionsView(),
      binding: TransactionsBinding(),
    ),
    GetPage(
      name: _Paths.MAIN,
      page: () => const MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: _Paths.LOG_OUT,
      page: () => const LogOutView(),
      binding: LogOutBinding(),
    ),
  ];
}
