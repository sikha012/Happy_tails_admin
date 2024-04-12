import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:happy_admin/app/components/customs/custom_progress_indicator.dart';
import 'package:happy_admin/app/utils/constants.dart';
import 'package:intl/intl.dart';
import '../controllers/transactions_controller.dart';

class TransactionsView extends GetView<TransactionsController> {
  const TransactionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(TransactionsController());
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: GetBuilder<TransactionsController>(
        builder: (context) => Container(
          padding: const EdgeInsets.all(10),
          child: Obx(
            () => Container(
              padding: const EdgeInsets.all(20),
              child: controller.isLoading.value
                  ? const Center(
                      child: CustomCircularProgressIndicator(),
                    )
                  : controller.payments.isEmpty
                      ? const Center(
                          child: Text(
                            "No transactions found...",
                            style: TextStyle(
                              fontSize: 17.5,
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            Expanded(
                              child: Scrollbar(
                                interactive: true,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: SizedBox(
                                    width: Get.width * 0.77,
                                    child: DataTable2(
                                      columnSpacing: 12,
                                      horizontalMargin: 12,
                                      minWidth: 600,
                                      columns: [
                                        const DataColumn2(
                                          label: Text(
                                            'Payment ID',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          size: ColumnSize.L,
                                        ),
                                        const DataColumn2(
                                          label: Text(
                                            'Ordered By',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          size: ColumnSize.L,
                                        ),
                                        const DataColumn2(
                                          label: Text(
                                            'Order ID',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          size: ColumnSize.L,
                                        ),
                                        const DataColumn2(
                                          label: Text(
                                            'Grand Total',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          size: ColumnSize.L,
                                        ),
                                        const DataColumn2(
                                          label: Text(
                                            'Order Date',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          size: ColumnSize.L,
                                        ),
                                        const DataColumn2(
                                          label: Text(
                                            'Order Status',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          size: ColumnSize.L,
                                        ),
                                        const DataColumn2(
                                          label: Text(
                                            'Payment Token',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          size: ColumnSize.L,
                                        ),
                                      ],
                                      rows: List<DataRow>.generate(
                                        controller.payments.length,
                                        (index) => DataRow(
                                          cells: [
                                            DataCell(Text(controller
                                                .payments[index].paymentId
                                                .toString())),
                                            DataCell(Text(controller
                                                    .payments[index].userName ??
                                                '')),
                                            DataCell(Text(controller
                                                .payments[index].orderId
                                                .toString())),
                                            DataCell(Text(controller
                                                .payments[index].grandTotal
                                                .toString())),
                                            DataCell(
                                              Text(
                                                controller.payments[index]
                                                            .orderDate !=
                                                        null
                                                    ? DateFormat('yyyy-MM-dd')
                                                        .format(controller
                                                            .payments[index]
                                                            .orderDate!)
                                                    : '',
                                              ),
                                            ),
                                            DataCell(Text(controller
                                                    .payments[index]
                                                    .orderStatus ??
                                                '')),
                                            DataCell(Text(controller
                                                    .payments[index]
                                                    .paymentToken ??
                                                '')),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
            ),
          ),
        ),
      ),
    );
  }
}
