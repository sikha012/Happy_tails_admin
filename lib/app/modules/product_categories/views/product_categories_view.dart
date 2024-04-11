import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_admin/app/components/customs/custom_button.dart';
import 'package:happy_admin/app/components/customs/custom_progress_indicator.dart';
import 'package:happy_admin/app/utils/constants.dart';
import '../controllers/product_categories_controller.dart';

class ProductCategoriesView extends GetView<ProductCategoriesController> {
  const ProductCategoriesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductCategoriesController());
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      appBar: AppBar(
        title: const Text('Product Categories'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
              label: "Add Category",
              onPressed: () {
                controller.showAddProductCategoryDialog();
              },
            ),
          ),
        ],
      ),
      body: GetBuilder<ProductCategoriesController>(
        builder: (_) => Obx(
          () => controller.isLoading.value
              ? const Center(
                  child: CustomCircularProgressIndicator(),
                )
              : controller.productCategories.isEmpty
                  ? const Center(
                      child: Text(
                        "No product categories found...",
                        style: TextStyle(fontSize: 17.5),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView(
                        children: [
                          Text(
                            "Manage Product Categories",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          const SizedBox(height: 24),
                          DataTable(
                            columns: const [
                              DataColumn(
                                label: Text(
                                  'Product Category ID',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Product Category Name',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Actions',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                            rows: controller.productCategories.map((category) {
                              return DataRow(cells: [
                                DataCell(Text(
                                    category.productcategoryId.toString())),
                                DataCell(
                                    Text(category.productcategoryName ?? '')),
                                DataCell(
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () {
                                          controller
                                              .showEditProductCategoryDialog(
                                                  category);
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          controller
                                              .showDeleteConfirmation(category);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ]);
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
        ),
      ),
    );
  }
}
