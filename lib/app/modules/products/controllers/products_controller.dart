import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_admin/app/components/customs/custom_button.dart';
import 'package:happy_admin/app/components/customs/custom_snackbar.dart';
import 'package:happy_admin/app/components/customs/custom_textfield.dart';
import 'package:happy_admin/app/data/models/pet_category.dart';
import 'package:happy_admin/app/data/models/product.dart';
import 'package:happy_admin/app/data/models/product_category.dart';
import 'package:happy_admin/app/data/models/seller.dart';
import 'package:happy_admin/app/data/provider/api_provider.dart';
import 'package:happy_admin/app/modules/main/controllers/main_controller.dart';
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

  void disposeControllers() {
    productNameController.clear();
    priceController.clear();
    stockQuantityController.clear();
    descriptionController.clear();

    selectedPetCategory.value = petCategories[0];
    selectedProductCategory.value = productCategories[0];
    selectedSeller.value = sellers[0];

    selectedImagePath = ''.obs;
    selectedImageBytes.value = null;
  }

  Future<dynamic> uploadProduct() async {
    final String fileName = path.basename(selectedImagePath.value);
    debugPrint(fileName);
    isLoading.value = true;
    if (productUploadKey.currentState!.validate()) {
      try {
        int? price = int.tryParse(priceController.text);
        int? stockQuantity = int.tryParse(stockQuantityController.text);
        await apiProvider
            .uploadProduct(
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
        )
            .then((value) {
          Get.snackbar(
            "Success",
            value,
            backgroundColor: Colors.green,
            colorText: Colors.white,
            duration: const Duration(seconds: 2),
          );
          getAllProducts();
          update();
          Get.back();
          Get.find<MainController>().update();
          isLoading.value = false;
          disposeControllers();
        }).onError((error, stackTrace) {
          Get.snackbar(
            "Error",
            error.toString(),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 500),
            colorText: Colors.white,
          );
          // CustomSnackbar.errorSnackbar(
          //   context: Get.context,
          //   title: "Error",
          //   message: error.toString(),
          // );
          isLoading.value = false;
          update();
        });
      } catch (e) {
        isLoading.value = false;
        CustomSnackbar.errorSnackbar(
          context: Get.context,
          title: "Error",
          message: "Something went wrong...",
        );
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

    sortColumnIndex.value = columnIndex;
    isAscending.value = ascending;
    update();
  }

  Future<dynamic> updateProduct(Product product) async {
    try {
      String? fileName;
      Uint8List? imageBytes;

      // If a new image is selected, prepare file name and image bytes
      if (selectedImagePath.value != '') {
        fileName = path.basename(selectedImagePath.value);
        imageBytes = selectedImageBytes.value;
      }

      isLoading.value = true;
      final int? price = int.tryParse(priceController.text);
      final int? stockQuantity = int.tryParse(stockQuantityController.text);
      await apiProvider
          .updateProduct(
        productId: product.productId ?? 0,
        productName: productNameController.text,
        price: price ?? 0,
        stockQuantity: stockQuantity ?? 0,
        description: descriptionController.text,
        fileName: fileName ?? product.productImage?.split('-')[1],
        previousFile: product.productImage?.split('/')[1],
        imageBytes: imageBytes,
        petCategory: selectedPetCategory.value?.petcategoryId ?? 0,
        productCategory: selectedProductCategory.value?.productcategoryId ?? 0,
        seller: selectedSeller.value?.sellerId ?? 0,
      )
          .then((value) {
        // Handle success
        Get.snackbar(
          "Success",
          value,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
        getAllProducts();
        update();
        Get.back();
        Get.find<MainController>().update();
        isLoading.value = false;
        disposeControllers();
      }).onError((error, stackTrace) {
        // Handle errors
        Get.snackbar(
          "Error",
          error.toString(),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 500),
          colorText: Colors.white,
        );
        isLoading.value = false;
        update();
      });
    } catch (e) {
      isLoading.value = false;
      update();
      debugPrint("Error in updateProduct: $e");
      rethrow;
    }
  }

  void showAddProductDialog() {
    final ImagePicker picker = ImagePicker();
    Get.dialog(
      AlertDialog(
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
            key: productUploadKey,
            child: ListBody(
              children: <Widget>[
                CustomTextfield(
                  controller: productNameController,
                  label: 'Product Name',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextfield(
                  controller: priceController,
                  label: 'Price',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextfield(
                  controller: stockQuantityController,
                  label: 'Stock Quantity',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextfield(
                  controller: descriptionController,
                  label: 'Description',
                ),
                const SizedBox(
                  height: 10,
                ),
                Obx(
                  () => selectedImageBytes.value != null
                      ? Image.memory(
                          selectedImageBytes.value!,
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
                      update();
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
                      update();
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
                      update();
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
              disposeControllers();
            },
          ),
          CustomButton(
            label: "Add",
            onPressed: () {
              uploadProduct();
            },
          ),
        ],
      ),
    );
  }

  void showEditProductDialog(Product product) {
    final ImagePicker picker = ImagePicker();

    productNameController.text = product.productName ?? '';
    priceController.text = product.productPrice.toString();
    stockQuantityController.text = product.productstockQuantity.toString();
    descriptionController.text = product.productDescription ?? '';

    int selectedPetCategoryIndex = petCategories.indexWhere(
      (element) => element.petcategoryId == product.petcategoryId,
    );
    if (selectedPetCategoryIndex != -1) {
      selectedPetCategory.value = petCategories[selectedPetCategoryIndex];
    }

    int selectedProductCategoryIndex = productCategories.indexWhere(
      (element) => element.productcategoryId == product.productcategoryId,
    );
    if (selectedProductCategoryIndex != -1) {
      selectedProductCategory.value =
          productCategories[selectedProductCategoryIndex];
    }

    int selectedSellerIndex = sellers.indexWhere(
      (element) => element.sellerId == product.sellerId,
    );
    if (selectedSellerIndex != -1) {
      selectedSeller.value = sellers[selectedSellerIndex];
    }

    Get.dialog(
      AlertDialog(
        backgroundColor: Constants.backgroundColor,
        title: Text(
          'Update ${product.productName}',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        content: SingleChildScrollView(
          child: Form(
            key: productUploadKey,
            child: ListBody(
              children: <Widget>[
                CustomTextfield(
                  controller: productNameController,
                  label: 'Product Name',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextfield(
                  controller: priceController,
                  label: 'Price',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextfield(
                  controller: stockQuantityController,
                  label: 'Stock Quantity',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextfield(
                  controller: descriptionController,
                  label: 'Description',
                ),
                const SizedBox(
                  height: 10,
                ),
                Obx(
                  () => selectedImageBytes.value != null
                      ? Image.memory(
                          selectedImageBytes.value!,
                          width: 100,
                          height: 100,
                        )
                      : Image.network(
                          getProductImage(product.productImage),
                          width: 100,
                          height: 100,
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
                      update();
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
                      update();
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
                      update();
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
              disposeControllers();
            },
          ),
          CustomButton(
            label: "Update",
            onPressed: () {
              updateProduct(product);
            },
          ),
        ],
      ),
    );
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
