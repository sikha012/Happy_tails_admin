import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_admin/app/utils/constants.dart';

class FullScreenDialogLoader {
  static void showDialog() {
    Get.dialog(
      PopScope(
        child: const Center(
          child: CircularProgressIndicator(),
        ),
        onPopInvoked: (didPop) => Future.value(false),
        // onWillPop: () => Future.value(false),
      ),
      barrierDismissible: false,
      barrierColor: Constants.backgroundColor,
      useSafeArea: true,
    );
  }

  static void cancelDialog() {
    if (Get.isDialogOpen!) Get.back();
  }
}

class CustomCircularProgressIndicator extends StatelessWidget {
  final double size;
  final Color color;
  final double strokeWidth;

  const CustomCircularProgressIndicator({
    Key? key,
    this.size = 50.0, // Default size
    this.color = Constants.primaryColor, // Default color
    this.strokeWidth = 4.0, // Default stroke width
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(color),
          strokeWidth: strokeWidth,
        ),
      ),
    );
  }
}
