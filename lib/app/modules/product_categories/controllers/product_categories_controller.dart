import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_admin/app/data/models/product_category.dart';
import 'package:happy_admin/app/data/provider/product_category_services.dart';

class ProductCategoriesController extends GetxController {
  var isLoading = false.obs;
  ProductCategoryServices apiProvider = ProductCategoryServices();
  List<ProductCategory> productCategories = [];

  final TextEditingController productCategoryNameController =
      TextEditingController();
  GlobalKey<FormState> productCategoryFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    getAllProductCategories();
  }

  void getAllProductCategories() async {
    isLoading.value = true;
    try {
      productCategories = await apiProvider.getAllProductCategories();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString(),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
          colorText: Colors.white);
    }
    update();
  }

  void showAddProductCategoryDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Add Product Category'),
        content: Form(
          key: productCategoryFormKey,
          child: TextFormField(
            controller: productCategoryNameController,
            decoration:
                const InputDecoration(labelText: 'Product Category Name'),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter a name for the product category';
              }
              return null;
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (productCategoryFormKey.currentState?.validate() ?? false) {
                addProductCategory();
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  Future<void> addProductCategory() async {
    if (productCategoryFormKey.currentState?.validate() ?? false) {
      isLoading.value = true;
      try {
        await apiProvider.createProductCategory({
          'productCategoryName': productCategoryNameController.text,
        }).then((value) {
          productCategories.add(value);
          Get.back(); // Close the dialog
          productCategoryNameController.clear();
          getAllProductCategories();
          Get.snackbar("Success", "Product category added successfully",
              backgroundColor: Colors.green,
              colorText: Colors.white,
              duration: const Duration(seconds: 2));
        });
      } catch (e) {
        Get.snackbar("Error", e.toString(),
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: const Duration(seconds: 3));
      } finally {
        isLoading.value = false;
      }
    }
  }

  void showEditProductCategoryDialog(ProductCategory productCategory) {
    productCategoryNameController.text =
        productCategory.productcategoryName ?? '';
    Get.dialog(
      AlertDialog(
        title: const Text('Edit Product Category'),
        content: TextFormField(
          controller: productCategoryNameController,
          decoration: const InputDecoration(labelText: 'Product Category Name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => updateProductCategory(productCategory),
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  Future<void> updateProductCategory(ProductCategory productCategory) async {
    isLoading.value = true;
    try {
      await apiProvider
          .updateProductCategory(productCategory.productcategoryId.toString(), {
        'productCategoryName': productCategoryNameController.text,
      }).then((value) {
        productCategory.productcategoryName =
            productCategoryNameController.text;
        Get.back(); // Close the dialog
        productCategoryNameController.clear();
        getAllProductCategories();
        Get.snackbar("Success", "Product category updated successfully",
            backgroundColor: Colors.green,
            colorText: Colors.white,
            duration: const Duration(seconds: 2));
      });
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3));
    } finally {
      isLoading.value = false;
    }
  }

  void showDeleteConfirmation(ProductCategory productCategory) {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete Product Category'),
        content: Text(
            'Are you sure you want to delete ${productCategory.productcategoryName}?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => deleteProductCategory(
                productCategory.productcategoryId.toString()),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  Future<void> deleteProductCategory(String id) async {
    isLoading.value = true;
    try {
      await apiProvider.deleteProductCategory(id).then((value) {
        productCategories.removeWhere(
            (category) => category.productcategoryId.toString() == id);
        getAllProductCategories();
        Get.back(); // Close the confirmation dialog
        Get.snackbar("Success", "Product category deleted successfully",
            backgroundColor: Colors.green,
            colorText: Colors.white,
            duration: const Duration(seconds: 2));
      });
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3));
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    productCategoryNameController.dispose();
    super.onClose();
  }
}
