import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_admin/app/data/models/pet_category.dart';
import 'package:happy_admin/app/data/provider/pet_category_services.dart';

class PetCategoriesController extends GetxController {
  var isLoading = false.obs;
  PetCategoryService apiProvider = PetCategoryService();
  List<PetCategory> petCategories = [];

  final TextEditingController petCategoryNameController =
      TextEditingController();
  GlobalKey<FormState> petCategoryFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    getAllPetCategories();
  }

  void getAllPetCategories() async {
    isLoading.value = true;
    try {
      petCategories = await apiProvider.getAllPetCategories();
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

  void showAddPetCategoryDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Add Pet Category'),
        content: Form(
          key: petCategoryFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: petCategoryNameController,
                decoration:
                    const InputDecoration(labelText: 'Pet Category Name'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a name for the pet category';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => addPetCategory(),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  Future<void> addPetCategory() async {
    if (petCategoryFormKey.currentState?.validate() ?? false) {
      isLoading.value = true;
      try {
        await apiProvider.createPetCategory({
          'petCategoryName': petCategoryNameController.text,
        }).then((value) {
          petCategories.add(value);
          Get.back();
          petCategoryNameController.clear();
          getAllPetCategories();
          Get.snackbar("Success", "Pet category added successfully",
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

  void showEditPetCategoryDialog(PetCategory petCategory) {
    petCategoryNameController.text = petCategory.petcategoryName ?? '';
    Get.dialog(
      AlertDialog(
        title: const Text('Edit Pet Category'),
        content: TextFormField(
          controller: petCategoryNameController,
          decoration: const InputDecoration(labelText: 'Pet Category Name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => updatePetCategory(petCategory),
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  Future<void> updatePetCategory(PetCategory petCategory) async {
    isLoading.value = true;
    try {
      await apiProvider.updatePetCategory(petCategory.petcategoryId.toString(),
          {'petCategoryName': petCategoryNameController.text}).then((value) {
        petCategory.petcategoryName = petCategoryNameController.text;
        Get.back(); // Close the dialog
        petCategoryNameController.clear();
        getAllPetCategories();
        Get.snackbar("Success", "Pet category updated successfully",
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

  void showDeleteConfirmation(PetCategory petCategory) {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete Pet Category'),
        content: Text(
            'Are you sure you want to delete ${petCategory.petcategoryName}?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () =>
                deletePetCategory(petCategory.petcategoryId.toString()),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  Future<void> deletePetCategory(String id) async {
    isLoading.value = true;
    try {
      await apiProvider.deletePetCategory(id).then((value) {
        petCategories
            .removeWhere((category) => category.petcategoryId.toString() == id);
        getAllPetCategories();
        Get.back(); // Close the confirmation dialog
        Get.snackbar("Success", "Pet category deleted successfully",
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
    petCategoryNameController.dispose();
    super.onClose();
  }
}
