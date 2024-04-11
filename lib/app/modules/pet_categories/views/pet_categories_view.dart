import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_admin/app/components/customs/custom_button.dart';
import 'package:happy_admin/app/components/customs/custom_progress_indicator.dart';
import 'package:happy_admin/app/utils/constants.dart';
import '../controllers/pet_categories_controller.dart';

class PetCategoriesView extends GetView<PetCategoriesController> {
  const PetCategoriesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PetCategoriesController());
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      appBar: AppBar(
        title: const Text('Pet Categories'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
              label: "Add Pet Category",
              onPressed: () {
                controller.showAddPetCategoryDialog();
              },
            ),
          ),
        ],
      ),
      body: GetBuilder<PetCategoriesController>(
        builder: (_) => Obx(
          () => controller.isLoading.value
              ? const Center(
                  child: CustomCircularProgressIndicator(),
                )
              : controller.petCategories.isEmpty
                  ? const Center(
                      child: Text(
                        "No pet categories found...",
                        style: TextStyle(fontSize: 17.5),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView(
                        children: [
                          Text(
                            "Manage Pet Categories",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          const SizedBox(height: 24),
                          DataTable(
                            columns: const [
                              DataColumn(
                                label: Text(
                                  'Pet Category ID',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Pet Category Name',
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
                            rows: controller.petCategories.map((category) {
                              return DataRow(cells: [
                                DataCell(
                                    Text(category.petcategoryId.toString())),
                                DataCell(Text(category.petcategoryName ?? '')),
                                DataCell(
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () {
                                          controller.showEditPetCategoryDialog(
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
