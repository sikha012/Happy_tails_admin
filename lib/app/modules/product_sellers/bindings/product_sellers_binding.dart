import 'package:get/get.dart';

import '../controllers/product_sellers_controller.dart';

class ProductSellersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductSellersController>(
      () => ProductSellersController(),
    );
  }
}
