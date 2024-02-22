import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pet_profiles_controller.dart';

class PetProfilesView extends GetView<PetProfilesController> {
  const PetProfilesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PetProfilesView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PetProfilesView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
