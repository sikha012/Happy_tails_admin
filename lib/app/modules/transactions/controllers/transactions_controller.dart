import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_admin/app/data/models/payment_model.dart';
import 'package:happy_admin/app/data/provider/api_provider.dart';

class TransactionsController extends GetxController {
  final count = 0.obs;
  var isLoading = false.obs;
  var payments = <PaymentModel>[].obs;
  ApiProvider apiProvider = ApiProvider();

  @override
  void onInit() {
    super.onInit();
    getAllPayments();
  }

  void getAllPayments() async {
    isLoading(true);
    try {
      final fetchedPayments = await apiProvider.getAllPayments();
      payments.assignAll(fetchedPayments);
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch payments: $e",
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }

  List<int> getSalesDataForLastSixMonths() {
    List<int> salesData = [];
    final now = DateTime.now();

    for (int i = 5; i >= 0; i--) {
      DateTime month = DateTime(now.year, now.month - i);
      int total = payments
          .where((pay) =>
              pay.orderDate!.year == month.year &&
              pay.orderDate!.month == month.month)
          .fold(0, (sum, current) => sum + (current.grandTotal ?? 0));
      int sum = 0;
      for (PaymentModel pay in payments) {
        if (pay.orderDate!.year == month.year &&
            pay.orderDate!.month == month.month) {
          debugPrint("grand total in month $month: ${pay.grandTotal}");
          sum += pay.grandTotal!;
        }
      }
      salesData.add(total);
    }

    return salesData;
  }

  int getTotalForMonth(int year, int month) {
    return payments
        .where((pay) =>
            pay.orderDate!.year == year && pay.orderDate!.month == month)
        .fold(0, (sum, current) => sum + (current.grandTotal ?? 0));
  }

  int getTotalForCurrentMonth() {
    final now = DateTime.now();
    return getTotalForMonth(now.year, now.month);
  }

  int getTotalForPreviousMonth() {
    final now = DateTime.now();
    final previousMonth = now.month == 1 ? 12 : now.month - 1;
    final year = now.month == 1 ? now.year - 1 : now.year;
    return getTotalForMonth(year, previousMonth);
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
