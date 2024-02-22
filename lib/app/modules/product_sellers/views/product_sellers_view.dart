import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/product_sellers_controller.dart';

class ProductSellersView extends GetView<ProductSellersController> {
  const ProductSellersView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProductSellersView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ProductSellersView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
