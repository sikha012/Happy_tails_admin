import 'package:get/get.dart';
import 'package:happy_admin/app/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:happy_admin/app/data/provider/user_services.dart';

class UserProfilesController extends GetxController {
  var isLoading = false.obs;
  UserService userService = UserService();
  List<UserModel> users = <UserModel>[].obs;
  var userType = 'All'.obs;

  final TextEditingController userTypeController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getAllUsers();
  }

  void getAllUsers() async {
    isLoading.value = true;
    try {
      users = await userService.getAllUsers();
    } catch (e) {
      debugPrint('Error fetching users: $e');
    } finally {
      isLoading.value = false;
    }
    update();
  }

  void getUsersByFilter() async {
    isLoading.value = true;
    String? userTypeFilter = userType.value != 'All' ? userType.value : null;
    String? userName =
        userNameController.text.isNotEmpty ? userNameController.text : null;
    try {
      users = await userService.getUsersByFilter(
          userType: userTypeFilter, userName: userName);
    } catch (e) {
      debugPrint('Error fetching filtered users: $e');
    } finally {
      isLoading.value = false;
    }
    update();
  }

  void disposeControllers() {
    userTypeController.clear();
    userNameController.clear();
  }

  @override
  void onClose() {
    disposeControllers();
    super.onClose();
  }
}
