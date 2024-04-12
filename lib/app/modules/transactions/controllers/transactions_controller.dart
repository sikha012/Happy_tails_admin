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
