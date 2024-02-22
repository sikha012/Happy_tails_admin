import 'package:get/get.dart';

import '../controllers/user_profiles_controller.dart';

class UserProfilesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserProfilesController>(
      () => UserProfilesController(),
    );
  }
}
