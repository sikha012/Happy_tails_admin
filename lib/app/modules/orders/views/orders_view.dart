import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_admin/app/components/customs/custom_progress_indicator.dart';
import 'package:happy_admin/app/utils/constants.dart';
import '../controllers/orders_controller.dart';
import 'package:intl/intl.dart';

class OrdersView extends GetView<OrdersController> {
  const OrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(OrdersController());
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: GetBuilder<OrdersController>(
        builder: (context) => Container(
          padding: const EdgeInsets.all(10),
          child: Obx(
            () => Container(
              padding: const EdgeInsets.all(20),
              child: controller.isLoading.value
                  ? const Center(
                      child: CustomCircularProgressIndicator(),
                    )
                  : controller.ordersToDeliver.isEmpty
                      ? const Center(
                          child: Text(
                            "No data found...",
                            style: TextStyle(
                              fontSize: 17.5,
                            ),
                          ),
                        )
                      : DataTable2(
                          columnSpacing: 12,
                          horizontalMargin: 12,
                          minWidth: 600,
                          columns: const [
                            DataColumn(label: Text('Order ID')),
                            DataColumn(label: Text('Product ID')),
                            DataColumn(label: Text('Product Name')),
                            DataColumn(label: Text('Quantity')),
                            DataColumn(label: Text('Line Total')),
                            DataColumn(label: Text('Status')),
                            DataColumn(label: Text('Order Date')),
                          ],
                          rows: controller.ordersToDeliver.map((order) {
                            return DataRow(cells: [
                              DataCell(Text(order.orderId?.toString() ?? '')),
                              DataCell(Text(order.productId?.toString() ?? '')),
                              DataCell(Text(order.productName ?? '')),
                              DataCell(Text(order.quantity?.toString() ?? '')),
                              DataCell(Text(order.lineTotal?.toString() ?? '')),
                              DataCell(DropdownButton<String>(
                                value: order.status,
                                onChanged: (newValue) {
                                  controller.updateOrderDeliveryStatus(
                                    orderDetailId: order.orderdetailId ?? 0,
                                    status: newValue ?? 'status',
                                    userFCM: order.token ?? 'token',
                                    productName: order.productName ?? 'product',
                                  );
                                },
                                items: controller.ordersDeliveryStatuses
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              )),
                              DataCell(Text(
                                  "${DateFormat('dd/MM/yyyy').format(order.orderDate ?? DateTime.now())}")),
                            ]);
                          }).toList(),
                        ),
            ),
          ),
        ),
      ),
    );
  }
}
