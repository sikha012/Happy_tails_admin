import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_admin/app/data/models/order_detail_model.dart';
import 'package:happy_admin/app/data/provider/orders_services.dart';
import 'package:collection/collection.dart';

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

  List<Map<String, dynamic>> getTopSellingProductsForMonth(
      int year, int month) {
    final monthlyOrders = ordersToDeliver
        .where((order) =>
            order.orderDate != null &&
            order.orderDate!.year == year &&
            order.orderDate!.month == month)
        .toList();

    if (monthlyOrders.isEmpty) return [];

    var productSales = <int, int>{};
    for (var order in monthlyOrders) {
      if (order.productId != null && order.quantity != null) {
        productSales.update(
          order.productId!,
          (value) => value + order.quantity!,
          ifAbsent: () => order.quantity!,
        );
      }
    }

    // var sortedProducts = productSales.entries
    //     .map((entry) => {'productId': entry.key, 'quantitySold': entry.value})
    //     .toList();
    final sortedProducts = productSales.entries
        .map((entry) => {'productId': entry.key, 'quantitySold': entry.value})
        .sorted((a, b) => b['quantitySold']!.compareTo(a['quantitySold']!))
        .take(5)
        .toList();

    // Sort the products by sold quantity in descending order
    sortedProducts
        .sort((a, b) => b['quantitySold']!.compareTo(a['quantitySold']!));

    // Take top 5 products
    var topProducts = sortedProducts.take(5).toList();

    // Get details of top products
    List<Map<String, dynamic>> topProductDetails = [];
    for (var product in topProducts) {
      var productDetail = monthlyOrders
          .firstWhereOrNull((order) => order.productId == product['productId']);
      if (productDetail != null) {
        topProductDetails.add({
          'productName': productDetail.productName,
          'quantitySold': product['quantitySold'],
          'productImage': productDetail.productImage,
        });
      }
    }

    return topProductDetails;
  }

  int getCountOfOrdersForMonth(int year, int month) {
    return ordersToDeliver.where((order) {
      return order.orderDate != null &&
          order.orderDate!.year == year &&
          order.orderDate!.month == month;
    }).length;
  }

  int getCurrentMonthOrdersCount() {
    final now = DateTime.now();
    return getCountOfOrdersForMonth(now.year, now.month);
  }

  int getPreviousMonthOrdersCount() {
    final now = DateTime.now();
    final previousMonth = now.month == 1 ? 12 : now.month - 1;
    final year = now.month == 1 ? now.year - 1 : now.year;
    return getCountOfOrdersForMonth(year, previousMonth);
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
