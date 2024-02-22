import 'package:get/get.dart';

import '../controllers/pet_categories_controller.dart';

class PetCategoriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PetCategoriesController>(
      () => PetCategoriesController(),
    );
  }
}
