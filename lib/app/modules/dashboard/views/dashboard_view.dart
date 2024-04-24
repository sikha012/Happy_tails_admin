// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_admin/app/components/line_chart_view.dart';
import 'package:happy_admin/app/components/pie_chart_view.dart';
import 'package:happy_admin/app/components/stats_card.dart';
import 'package:happy_admin/app/modules/main/controllers/main_controller.dart';
import 'package:happy_admin/app/utils/constants.dart';
import 'package:intl/intl.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userController = Get.find<MainController>().userController;
    var transactionController =
        Get.find<MainController>().transactionController;
    var productController = Get.find<MainController>().productController;
    var ordersController = Get.find<MainController>().ordersController;

    // int totalTransactions = 0;
    // for (PaymentModel pay in transactionController.payments) {
    //   totalTransactions += pay.grandTotal!;
    // }
    Get.put(DashboardController());

    List<int> lastSixMonthsSales =
        transactionController.getSalesDataForLastSixMonths();

    // while (lastSixMonthsSales.length < 6) {
    //   lastSixMonthsSales.insert(0, 0);
    // }
    debugPrint('lastSixMonthsSales length: ${lastSixMonthsSales.length}');
    debugPrint('lastSixMonthsSales: $lastSixMonthsSales');

    final months = List<DropdownMenuItem<int>>.generate(12, (int index) {
      return DropdownMenuItem<int>(
        value: index + 1,
        child: Text(DateFormat('MMMM').format(DateTime(0, index + 1))),
      );
    });

    // Observables for selected month and year
    final selectedMonth = Rx<int>(DateTime.now().month);
    final selectedYear = Rx<int>(DateTime.now().year);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: <Widget>[
          // IconButton(
          //   icon: const Icon(Icons.search),
          //   onPressed: () {},
          // ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 30, 0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.account_circle),
                  onPressed: () {},
                ),
                Text(
                  "Admin",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: GetBuilder<DashboardController>(
        builder: (controller) => SingleChildScrollView(
          child: Obx(
            () {
              final topProducts =
                  ordersController.getTopSellingProductsForMonth(
                      selectedYear.value, selectedMonth.value);

              return Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      StatisticCard(
                        title: 'Total Users',
                        currentValue:
                            userController.getUserCountForCurrentMonth(),
                        previousValue:
                            userController.getUserCountForPreviousMonth(),
                        icon: Icons.person,
                        iconColor: Colors.blue,
                        linkText: 'See all users',
                        onLinkTap: () {
                          Get.find<MainController>().index.value = 1;
                        },
                      ),
                      StatisticCard(
                        title: 'Total Transactions',
                        currentValue:
                            transactionController.getTotalForCurrentMonth(),
                        previousValue:
                            transactionController.getTotalForPreviousMonth(),
                        icon: Icons.monetization_on,
                        iconColor: Colors.green,
                        linkText: 'See all transactions',
                        onLinkTap: () {
                          Get.find<MainController>().index.value = 5;
                        },
                      ),
                      StatisticCard(
                        title: 'Total Active Products',
                        currentValue:
                            productController.getActiveProductsCount(),
                        previousValue: 0,
                        disablePreviousValue: true,
                        replacementValue:
                            'Total products: ${productController.products.length}',
                        icon: Icons.shopping_basket,
                        iconColor: Colors.amber,
                        linkText: 'See all products',
                        onLinkTap: () {
                          Get.find<MainController>().index.value = 4;
                        },
                      ),
                      StatisticCard(
                        title: 'Total Orders',
                        currentValue:
                            ordersController.getCurrentMonthOrdersCount(),
                        previousValue:
                            ordersController.getPreviousMonthOrdersCount(),
                        icon: Icons.receipt,
                        iconColor: Colors.red,
                        linkText: 'See all orders',
                        onLinkTap: () {
                          Get.find<MainController>().index.value = 6;
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Container for dropdowns and top products list
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          margin:
                              const EdgeInsets.only(left: 25.0, right: 12.5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Top Sold Products for ${DateFormat('MMMM').format(DateTime(0, selectedMonth.value))} of ${selectedYear.value}",
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        DropdownButton<int>(
                                          value: selectedMonth.value,
                                          icon: Icon(
                                            Icons.arrow_drop_down,
                                          ),
                                          style: TextStyle(
                                            color: Colors.grey.shade600,
                                          ),
                                          items: months,
                                          onChanged: (int? newValue) {
                                            if (newValue != null) {
                                              selectedMonth.value = newValue;
                                            }
                                          },
                                        ),
                                        SizedBox(width: 10),
                                        DropdownButton<int>(
                                          value: selectedYear.value,
                                          icon: Icon(
                                            Icons.arrow_drop_down,
                                          ),
                                          style: TextStyle(
                                            color: Colors.grey.shade600,
                                          ),
                                          items: List.generate(5, (index) {
                                            int year =
                                                DateTime.now().year - index;
                                            return DropdownMenuItem<int>(
                                                value: year,
                                                child: Text("$year"));
                                          }),
                                          onChanged: (int? newValue) {
                                            if (newValue != null) {
                                              selectedYear.value = newValue;
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              topProducts.isNotEmpty
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: topProducts.length,
                                      itemBuilder: (context, index) {
                                        final product = topProducts[index];
                                        return ListTile(
                                          leading: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              getProductImage(
                                                  product['productImage']),
                                              width: 50,
                                              height: 50,
                                            ),
                                          ),
                                          title: Text(
                                            product['productName'],
                                            style: TextStyle(
                                              color: Colors.grey.shade700,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          subtitle: Row(
                                            children: [
                                              Text(
                                                'Quantity sold: ',
                                                style: TextStyle(
                                                  color: Colors.grey.shade600,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                '${product['quantitySold']}',
                                                style: TextStyle(
                                                  color: Colors.grey.shade600,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    )
                                  : Center(
                                      child: Text(
                                        "No products sold for this month...",
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),

                      // Container for the Pie Chart
                      Expanded(
                        child: Container(
                          height: 550,
                          padding: const EdgeInsets.all(8.0),
                          margin:
                              const EdgeInsets.only(left: 12.5, right: 25.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: PieChartScreen(
                            ratio: MediaQuery.of(context).size.aspectRatio,
                            title: "Product Distribution by Category",
                            categoryDistribution: productController
                                .getProductDistributionByCategory(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
