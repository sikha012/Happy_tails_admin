import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_admin/app/components/customs/custom_button.dart';
import 'package:happy_admin/app/components/customs/custom_progress_indicator.dart';
import 'package:happy_admin/app/utils/constants.dart';
import '../controllers/user_profiles_controller.dart';

class UserProfilesView extends GetView<UserProfilesController> {
  const UserProfilesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(UserProfilesController());
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: GetBuilder<UserProfilesController>(
        builder: (_) => Container(
          padding: const EdgeInsets.all(10),
          child: Obx(
            () => Container(
              padding: const EdgeInsets.all(20),
              child: controller.isLoading.value
                  ? const Center(
                      child: CustomCircularProgressIndicator(),
                    )
                  : Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: controller.userNameController,
                                decoration: InputDecoration(
                                  hintText: 'Search by user name...',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  suffixIcon: const Icon(Icons.search),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              children: [
                                Text(
                                  'User Type',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey,
                                  ),
                                ),
                                DropdownButton<String>(
                                  value: controller.userType.value,
                                  onChanged: (newValue) {
                                    controller.userType.value = newValue!;
                                    controller.getUsersByFilter();
                                  },
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                  items: <String>['All', 'User', 'Seller']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: CustomButton(
                            onPressed: () {
                              controller.getUsersByFilter();
                            },
                            label: 'Search',
                          ),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: controller.users.isEmpty
                              ? const Center(
                                  child: Text(
                                    "No user data found...",
                                    style: TextStyle(
                                      fontSize: 17.5,
                                    ),
                                  ),
                                )
                              : SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: SizedBox(
                                    width: Get.width * 0.77,
                                    child: DataTable2(
                                      columnSpacing: 8,
                                      horizontalMargin: 10,
                                      minWidth: 600,
                                      columns: const [
                                        DataColumn(
                                          label: Text(
                                            'User ID',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            'User Name',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            'Email',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            'Contact',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            'Location',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            'User Type',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ),
                                      ],
                                      rows: List<DataRow>.generate(
                                        controller.users.length,
                                        (index) => DataRow(
                                          cells: [
                                            DataCell(Text(controller
                                                    .users[index].userId
                                                    ?.toString() ??
                                                '-')),
                                            DataCell(Text(controller
                                                    .users[index].userName ??
                                                '-')),
                                            DataCell(Text(controller
                                                    .users[index].userEmail ??
                                                '-')),
                                            DataCell(Text(controller
                                                    .users[index].userContact ??
                                                '-')),
                                            DataCell(Text(controller
                                                    .users[index]
                                                    .userLocation ??
                                                '-')),
                                            DataCell(Text(controller
                                                    .users[index].userType ??
                                                '-')),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
