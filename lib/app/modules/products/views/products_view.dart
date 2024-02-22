import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:happy_admin/app/components/customs/custom_button.dart';
import 'package:happy_admin/app/components/customs/custom_progress_indicator.dart';
import 'package:happy_admin/app/utils/constants.dart';

import '../controllers/products_controller.dart';

class ProductsView extends GetView<ProductsController> {
  const ProductsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductsController());
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: Obx(
        () => Container(
          padding: const EdgeInsets.all(20),
          child: controller.isLoading.value
              ? const Center(
                  child: CustomCircularProgressIndicator(),
                )
              : controller.products.isEmpty
                  ? const Center(
                      child: Text(
                        "No data found...",
                        style: TextStyle(
                          fontSize: 17.5,
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              const Text(
                                "Manage Products",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: CustomButton(
                                  label: "Add Product",
                                  onPressed: () {
                                    controller.showAddProductDialog(
                                        context, controller);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: Scrollbar(
                            controller: ScrollController(),
                            interactive: true,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                width: Get.width,
                                height: Get.height,
                                child: DataTable2(
                                  sortColumnIndex:
                                      controller.sortColumnIndex.value,
                                  sortAscending: controller.isAscending.value,
                                  sortArrowIcon: CupertinoIcons.sort_down,
                                  // border: TableBorder(
                                  //     horizontalInside: BorderSide(width: 1),
                                  //     verticalInside: BorderSide(width: 1)),
                                  dataRowHeight: 80,
                                  dividerThickness: 1.5,
                                  headingRowDecoration: const BoxDecoration(
                                    color: Colors.white,
                                    border: Border(
                                      bottom: BorderSide(width: 1),
                                    ),
                                  ),
                                  columnSpacing: 8,
                                  horizontalMargin: 10,
                                  minWidth: 600,
                                  columns: [
                                    DataColumn2(
                                      onSort: (columnIndex, ascending) {
                                        controller.sortProducts(
                                            columnIndex, ascending);
                                      },
                                      label: const Text(
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                          'Product ID'),
                                      size: ColumnSize.S,
                                    ),
                                    DataColumn2(
                                      onSort: (columnIndex, ascending) {
                                        controller.sortProducts(
                                            columnIndex, ascending);
                                      },
                                      label: const Text(
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                          'Product Name'),
                                      size: ColumnSize.L,
                                    ),
                                    DataColumn2(
                                      onSort: (columnIndex, ascending) {
                                        controller.sortProducts(
                                            columnIndex, ascending);
                                      },
                                      label: const Text(
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                          'Price'),
                                      size: ColumnSize.S,
                                    ),
                                    DataColumn2(
                                      onSort: (columnIndex, ascending) {
                                        controller.sortProducts(
                                            columnIndex, ascending);
                                      },
                                      label: const Text(
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                          'Stock Quantity'),
                                      size: ColumnSize.M,
                                    ),
                                    DataColumn2(
                                      onSort: (columnIndex, ascending) {
                                        controller.sortProducts(
                                            columnIndex, ascending);
                                      },
                                      label: const Text(
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                          'Category'),
                                      size: ColumnSize.M,
                                    ),
                                    DataColumn2(
                                      onSort: (columnIndex, ascending) {
                                        controller.sortProducts(
                                            columnIndex, ascending);
                                      },
                                      label: const Text(
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                          'Description'),
                                      size: ColumnSize.L,
                                    ),
                                    DataColumn2(
                                      onSort: (columnIndex, ascending) {
                                        controller.sortProducts(
                                            columnIndex, ascending);
                                      },
                                      label: const Text(
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                          'Image'),
                                      size: ColumnSize.L,
                                    ),
                                    DataColumn2(
                                      onSort: (columnIndex, ascending) {
                                        controller.sortProducts(
                                            columnIndex, ascending);
                                      },
                                      label: const Text(
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                          'Pet Category'),
                                      size: ColumnSize.M,
                                    ),
                                    DataColumn2(
                                      onSort: (columnIndex, ascending) {
                                        controller.sortProducts(
                                            columnIndex, ascending);
                                      },
                                      label: const Text(
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                          'Seller Name'),
                                      size: ColumnSize.M,
                                    ),
                                  ],
                                  rows: List<DataRow>.generate(
                                    growable: true,
                                    controller.products.length,
                                    (index) => DataRow(
                                      color: const MaterialStatePropertyAll(
                                        Colors.white,
                                      ),
                                      cells: [
                                        DataCell(
                                          Text(
                                            controller.products[index].productId
                                                .toString(),
                                          ),
                                        ),
                                        DataCell(
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 40,
                                                height: 40,
                                                child: Image.network(
                                                  fit: BoxFit.cover,
                                                  getProductImage(
                                                    controller.products[index]
                                                        .productImage,
                                                  ),
                                                ),
                                              ),
                                              // CircleAvatar(
                                              //   radius: 10,
                                              //   backgroundImage: NetworkImage(
                                              //     getProductImage(
                                              //         controller.products[index].productImage ??
                                              //             ''),
                                              //   ),
                                              // ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(controller.products[index]
                                                      .productName ??
                                                  ''),
                                            ],
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            controller
                                                .products[index].productPrice
                                                .toString(),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            controller.products[index]
                                                .productstockQuantity
                                                .toString(),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            controller.products[index]
                                                    .productcategoryName ??
                                                '-',
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            controller.products[index]
                                                    .productDescription ??
                                                '-',
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            controller.products[index]
                                                    .productImage ??
                                                '-',
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            controller.products[index]
                                                    .petcategoryName ??
                                                '-',
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            controller.products[index]
                                                    .sellerName ??
                                                '-',
                                          ),
                                        ),
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
    );
  }
}