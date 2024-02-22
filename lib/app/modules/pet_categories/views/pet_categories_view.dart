import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pet_categories_controller.dart';

class PetCategoriesView extends GetView<PetCategoriesController> {
  const PetCategoriesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PetCategoriesView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PetCategoriesView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
