import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_admin/app/components/customs/custom_button.dart';
import 'package:happy_admin/app/components/customs/custom_snackbar.dart';
import 'package:happy_admin/app/components/customs/custom_textfield.dart';
import 'package:happy_admin/app/data/models/petCategory.dart';
import 'package:happy_admin/app/data/models/product.dart';
import 'package:happy_admin/app/data/models/productCategory.dart';
import 'package:happy_admin/app/data/models/seller.dart';
import 'package:happy_admin/app/data/provider/api_provider.dart';
import 'package:happy_admin/app/utils/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class ProductsController extends GetxController {
  final count = 0.obs;
  var isLoading = false.obs;
  ApiProvider apiProvider = ApiProvider();
  List<Product> products = [];

  GlobalKey<FormState> productUploadKey = GlobalKey<FormState>();

  List<PetCategory> petCategories = [];
  List<ProductCategory> productCategories = [];
  List<Seller> sellers = [];

  var selectedPetCategory = Rx<PetCategory?>(null);
  var selectedProductCategory = Rx<ProductCategory?>(null);
  var selectedSeller = Rx<Seller?>(null);

  var selectedImagePath = ''.obs;
  var selectedImageBytes = Rx<Uint8List?>(null);

  var sortColumnIndex = 0.obs;
  var isAscending = true.obs;

  final TextEditingController productNameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController stockQuantityController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController petCategoryController = TextEditingController();
  final TextEditingController productCategoryController =
      TextEditingController();
  final TextEditingController sellerController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getAllProducts();
    getAllPetCategories();
    getAllProductCategories();
    getAllSellers();
  }

  void getAllProducts() async {
    isLoading.value = true;
    try {
      products = await apiProvider.getAllProducts();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
    update();
  }

  void getAllPetCategories() async {
    isLoading.value = true;
    try {
      petCategories = await apiProvider.getAllPetCategories();
      if (petCategories.isNotEmpty) {
        selectedPetCategory.value = petCategories.first;
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
    update();
  }

  void getAllProductCategories() async {
    isLoading.value = true;
    try {
      productCategories = await apiProvider.getAllProductCategories();
      if (productCategories.isNotEmpty) {
        selectedProductCategory.value = productCategories.first;
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
    update();
  }

  void getAllSellers() async {
    isLoading.value = true;
    try {
      sellers = await apiProvider.getAllSellers();
      if (sellers.isNotEmpty) {
        selectedSeller.value = sellers.first;
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
    update();
  }

  Future<dynamic> uploadProduct() async {
    final String fileName = path.basename(selectedImagePath.value);
    debugPrint(fileName);
    isLoading.value = true;
    if (productUploadKey.currentState!.validate()) {
      try {
        int? price = int.tryParse(priceController.text);
        int? stockQuantity = int.tryParse(stockQuantityController.text);
        var response = await apiProvider.uploadProduct(
          productName: productNameController.text,
          price: price ?? 0,
          stockQuantity: stockQuantity ?? 0,
          description: descriptionController.text,
          fileName: fileName,
          imageBytes: selectedImageBytes.value,
          petCategory: selectedPetCategory.value?.petcategoryId ?? 0,
          productCategory:
              selectedProductCategory.value?.productcategoryId ?? 0,
          seller: selectedSeller.value?.sellerId ?? 0,
        );
        isLoading.value = false;
        CustomSnackbar.successSnackbar(
            context: Get.context,
            title: "Success",
            message: "Product uploaded sucessfully");
        products = await apiProvider.getAllProducts();
        debugPrint(products.toString());
        update();
        return response;
      } catch (e) {
        isLoading.value = false;
        update();
        debugPrint("Error in uploadProduct: $e");
        rethrow;
      }
    } else {
      CustomSnackbar.errorSnackbar(
        context: Get.context,
        title: "Error",
        message: "Missing values in the formfield",
      );
    }
  }

  void sortProducts(int columnIndex, bool ascending) {
    products.sort((a, b) {
      int compareResult = 0;
      switch (columnIndex) {
        case 0: // Product ID
          compareResult = (a.productId ?? 0).compareTo(b.productId ?? 0);
          break;
        case 1: // Product Name
          compareResult = (a.productName ?? "").compareTo(b.productName ?? "");
          break;
        case 2: // Price
          compareResult = (a.productPrice ?? 0).compareTo(b.productPrice ?? 0);
          break;
        case 3: // Stock Quantity
          compareResult = (a.productstockQuantity ?? 0)
              .compareTo(b.productstockQuantity ?? 0);
          break;
        case 4: // Description
          compareResult = (a.productDescription ?? "")
              .compareTo(b.productDescription ?? "");
          break;
        case 5: // Image (Assuming you want to sort by image URL)
          compareResult =
              (a.productImage ?? "").compareTo(b.productImage ?? "");
          break;
        case 6: // Pet Category
          compareResult =
              (a.petcategoryName ?? "").compareTo(b.petcategoryName ?? "");
          break;
        case 7: // Product Category
          compareResult = (a.productcategoryName ?? "")
              .compareTo(b.productcategoryName ?? "");
          break;
        case 8: // Seller Name
          compareResult = (a.sellerName ?? "").compareTo(b.sellerName ?? "");
          break;
        default:
          throw Exception('Invalid column index for sorting');
      }
      return ascending ? compareResult : -compareResult;
    });

    // Update the sort state
    sortColumnIndex.value = columnIndex;
    isAscending.value = ascending;
    update(); // Triggers a UI update
  }

  void showAddProductDialog(
      BuildContext context, ProductsController controller) {
    // Image picker instance
    final ImagePicker picker = ImagePicker();

    // Dialog content
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Constants.backgroundColor,
          title: const Text(
            'Add Product',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: Form(
              key: controller.productUploadKey,
              child: ListBody(
                children: <Widget>[
                  CustomTextfield(
                    controller: controller.productNameController,
                    label: 'Product Name',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextfield(
                    controller: controller.priceController,
                    label: 'Price',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextfield(
                    controller: controller.stockQuantityController,
                    label: 'Stock Quantity',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextfield(
                    controller: controller.descriptionController,
                    label: 'Description',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => controller.selectedImageBytes.value != null
                        ? Image.memory(
                            controller.selectedImageBytes.value!,
                            width: 100,
                            height: 100,
                          )
                        : const Text(
                            "No image selected",
                            textAlign: TextAlign.center,
                          ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    label: 'Pick Image',
                    disableBorder: true,
                    onPressed: () async {
                      final XFile? image =
                          await picker.pickImage(source: ImageSource.gallery);
                      if (image != null) {
                        selectedImagePath.value = image.name;
                        final Uint8List imageBytes = await image.readAsBytes();
                        selectedImageBytes.value = imageBytes;
                        controller.imageController.text = image.path;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Pet Category"),
                  Obx(
                    () => DropdownButton<PetCategory>(
                      value: selectedPetCategory.value,
                      onChanged: (PetCategory? newValue) {
                        selectedPetCategory.value = newValue!;
                        update(); // Make sure to call update to refresh the UI
                      },
                      items: petCategories.map<DropdownMenuItem<PetCategory>>(
                          (PetCategory value) {
                        return DropdownMenuItem<PetCategory>(
                          value: value,
                          child: Text(value.petcategoryName ?? ""),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Product Category"),
                  Obx(
                    () => DropdownButton<ProductCategory>(
                      value: selectedProductCategory.value,
                      onChanged: (ProductCategory? newValue) {
                        selectedProductCategory.value = newValue!;
                        update(); // Make sure to call update to refresh the UI
                      },
                      items: productCategories
                          .map<DropdownMenuItem<ProductCategory>>(
                              (ProductCategory value) {
                        return DropdownMenuItem<ProductCategory>(
                          value: value,
                          child: Text(value.productcategoryName ?? ""),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Seller",
                  ),
                  Obx(
                    () => DropdownButton<Seller>(
                      value: selectedSeller.value,
                      onChanged: (Seller? newValue) {
                        selectedSeller.value = newValue!;
                        update(); // Make sure to call update to refresh the UI
                      },
                      items:
                          sellers.map<DropdownMenuItem<Seller>>((Seller value) {
                        return DropdownMenuItem<Seller>(
                          value: value,
                          child: Text(value.sellerName ?? ""),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            CustomButton(
              width: 75,
              disableBorder: true,
              label: "Cancel",
              onPressed: () {
                Get.back();
              },
            ),
            CustomButton(
              label: "Add",
              onPressed: () {
                controller.uploadProduct().then((result) {
                  // Handle success
                  debugPrint(result.toString());
                  Get.back(); // Close the dialog
                }).catchError((error) {
                  // Handle error
                  debugPrint("Error uploading product: $error");
                });
              },
            ),

            // TextButton(
            //   child: Text('Add'),
            //   onPressed: () {
            //     // Here, you would collect the data from the controllers
            //     // and the selected dropdown values, then call your method to
            //     // add the product to your backend or local storage.
            //     Navigator.of(context).pop();
            //   },
            // ),
          ],
        );
      },
    );
  }

  // void sortProducts(int columnIndex, bool ascending) {
  //   if (columnIndex == 0) {
  //     // Assuming 0 is for Product ID
  //     products.sort((a, b) {
  //       final int aValue = a.productId ?? 0;
  //       final int bValue = b.productId ?? 0;
  //       return ascending ? aValue.compareTo(bValue) : bValue.compareTo(aValue);
  //     });
  //   }
  //   // Implement similar logic for other columns based on columnIndex
  //   // Update the sort state
  //   sortColumnIndex.value = columnIndex;
  //   isAscending.value = ascending;
  //   update(); // Triggers a UI update
  // }

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
