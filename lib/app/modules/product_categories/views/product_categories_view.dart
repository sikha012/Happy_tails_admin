import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/product_categories_controller.dart';

class ProductCategoriesView extends GetView<ProductCategoriesController> {
  const ProductCategoriesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProductCategoriesView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ProductCategoriesView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
