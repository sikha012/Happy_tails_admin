import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/user_profiles_controller.dart';

class UserProfilesView extends GetView<UserProfilesController> {
  const UserProfilesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Padding(
      //       padding: EdgeInsets.symmetric(
      //         horizontal: 10,
      //         vertical: 10,
      //       ),
      //       child: Row(
      //         children: [
      //           Expanded(
      //             child: Text(
      //               "User Profiles",
      //               style: TextStyle(
      //                 fontSize: 20,
      //                 color: Colors.grey,
      //               ),
      //             ),
      //           ),
      //           Expanded(
      //             flex: 5,
      //             child: CustomTextfield(
      //               controller: TextEditingController(),
      //               label: "Search",
      //               suffixIcon: Icon(
      //                 CupertinoIcons.search,
      //                 color: Constants.tertiaryColor,
      //               ),
      //               textStyle: TextStyle(
      //                 fontSize: 10,
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: DataTable2(
          columnSpacing: 12,
          horizontalMargin: 12,
          minWidth: 600,
          columns: [
            DataColumn2(
              label: Text('User'),
              size: ColumnSize.L,
            ),
            DataColumn(
              label: Text('Email'),
            ),
            DataColumn(
              label: Text('Contact'),
            ),
            DataColumn(
              label: Text('Location'),
            ),
            DataColumn(
              label: Text('User Type'),
              numeric: true,
            ),
          ],
          rows: List<DataRow>.generate(
            10,
            (index) => DataRow(
              cells: [
                DataCell(
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage(
                          'assets/images/theAppLogo.png',
                        ),
                      ),
                      Text('A'),
                    ],
                  ),
                ),
                DataCell(Text('B')),
                DataCell(Text('C')),
                DataCell(Text('D')),
                DataCell(Text('S'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
