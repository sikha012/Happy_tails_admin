import 'package:get/get.dart';

import '../controllers/log_out_controller.dart';

class LogOutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LogOutController>(
      () => LogOutController(),
    );
  }
}
