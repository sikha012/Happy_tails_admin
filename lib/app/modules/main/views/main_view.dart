import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:happy_admin/app/components/side_menu.dart';

import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<MainController>(
        builder: (controller) => Obx(
          () => SafeArea(
            child: Row(
              children: [
                Expanded(
                  // Default flex 1 -> takes 1/6 part of the screen
                  // child: SideDrawer(),
                  child: ListView(
                    children: [
                      DrawerHeader(
                        child: Image.asset(
                          'assets/images/theAppLogo.png',
                        ),
                      ),
                      DwrListTile(
                        title: "Dashboard",
                        svgName: 'dashboard.svg',
                        onTap: () {
                          controller.index.value = 0;
                          debugPrint(controller.index.value.toString());
                        },
                        selected: controller.index.value == 0,
                      ),
                      DwrListTile(
                        title: "User Profiles",
                        svgName: 'profiles.svg',
                        onTap: () {
                          controller.index.value = 1;
                          debugPrint(controller.index.value.toString());
                        },
                        selected: controller.index.value == 1,
                      ),
                      DwrListTile(
                        title: "Pet Categories",
                        svgName: 'petCategories.svg',
                        onTap: () {
                          controller.index.value = 2;
                          debugPrint(controller.index.value.toString());
                        },
                        selected: controller.index.value == 2,
                      ),
                      // DwrListTile(
                      //   title: "Pet Profiles",
                      //   svgName: 'petProfiles.svg',
                      //   onTap: () {
                      //     controller.index.value = 3;
                      //     debugPrint(controller.index.value.toString());
                      //   },
                      //   selected: controller.index.value == 3,
                      // ),
                      DwrListTile(
                        title: "Product Categories",
                        svgName: 'productCategories.svg',
                        onTap: () {
                          controller.index.value = 3;
                          debugPrint(controller.index.value.toString());
                        },
                        selected: controller.index.value == 3,
                      ),
                      // DwrListTile(
                      //   title: "Product Sellers",
                      //   svgName: 'sellers.svg',
                      //   onTap: () {
                      //     controller.index.value = 5;
                      //     debugPrint(controller.index.value.toString());
                      //   },
                      //   selected: controller.index.value == 5,
                      // ),
                      DwrListTile(
                        title: "Products",
                        svgName: 'products.svg',
                        onTap: () {
                          controller.index.value = 4;
                          debugPrint(controller.index.value.toString());
                        },
                        selected: controller.index.value == 4,
                      ),
                      DwrListTile(
                        title: "Transactions",
                        svgName: 'transactions.svg',
                        onTap: () {
                          controller.index.value = 5;
                          debugPrint(controller.index.value.toString());
                        },
                        selected: controller.index.value == 5,
                      ),
                      DwrListTile(
                        title: "Orders",
                        svgName: 'productCategories.svg',
                        onTap: () {
                          controller.index.value = 6;
                          debugPrint(controller.index.value.toString());
                        },
                        selected: controller.index.value == 6,
                      ),
                      DwrListTile(
                        title: "Log Out",
                        svgName: 'logOut.svg',
                        onTap: () {
                          controller.index.value = 7;
                          debugPrint(controller.index.value.toString());
                        },
                        selected: controller.index.value == 7,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  // Takes 5/6 part of the screen
                  flex: 5,
                  child: controller.pages[controller.index.value],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
