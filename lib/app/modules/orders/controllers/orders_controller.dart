import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_admin/app/data/models/order_detail-model.dart';
import 'package:happy_admin/app/data/provider/orders_services.dart';

class OrdersController extends GetxController {
  var isLoading = false.obs;
  OrderService orderService = OrderService();
  RxList<OrderDetailModel> ordersToDeliver = RxList<OrderDetailModel>();

  List<String> ordersDeliveryStatuses = [
    'Shipped',
    'On the way',
    'Delivered',
  ];

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getAllOrdersToDeliver();
  }

  void getAllOrdersToDeliver() async {
    isLoading.value = true;
    try {
      ordersToDeliver.value = await orderService.getOrdersToDeliver();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
    update();
  }

  void updateOrderDeliveryStatus({
    required int orderDetailId,
    required String status,
    required String userFCM,
    required String productName,
  }) async {
    try {
      await orderService
          .updateOrderDeliveryStatus(
        orderDetailId: orderDetailId,
        status: status,
        userFCM: userFCM,
        productName: productName,
      )
          .then((value) {
        Get.snackbar(
          "Success",
          value,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
        getAllOrdersToDeliver();
        update();
      }).onError((error, stackTrace) {
        Get.snackbar(
          "Error",
          error.toString(),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 500),
          colorText: Colors.white,
        );
        isLoading.value = false;
        update();
      });
    } catch (exp) {
      Get.snackbar(
        "Error in code",
        exp.toString(),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 500),
        colorText: Colors.white,
      );
      isLoading.value = false;
      update();
    }
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
