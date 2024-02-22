import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:happy_admin/app/utils/constants.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            DrawerHeader(
              child: Image.asset('assets/images/theAppLogo.png'),
            ),
            DwrListTile(
              title: "Dashboard",
              svgName: 'dashboard.svg',
              onTap: () {},
            ),
            DwrListTile(
              title: "User Profiles",
              svgName: 'profiles.svg',
              onTap: () {},
            ),
            DwrListTile(
              title: "Pet Categories",
              svgName: 'petCategories.svg',
              onTap: () {},
            ),
            DwrListTile(
              title: "Pet Profiles",
              svgName: 'petProfiles.svg',
              onTap: () {},
            ),
            DwrListTile(
              title: "Product Categories",
              svgName: 'productCategories.svg',
              onTap: () {},
            ),
            DwrListTile(
              title: "Product Sellers",
              svgName: 'sellers.svg',
              onTap: () {},
            ),
            DwrListTile(
              title: "Products",
              svgName: 'products.svg',
              onTap: () {},
            ),
            DwrListTile(
              title: "Transactions",
              svgName: 'transactions.svg',
              onTap: () {},
            ),
            DwrListTile(
              title: "Log Out",
              svgName: 'logOut.svg',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class DwrListTile extends StatelessWidget {
  final String title;
  final String svgName;
  final VoidCallback onTap;
  final bool? selected;
  final Color? iconColor;
  final Color? selectedTextColor;
  final Color? unselectedTextColor;

  const DwrListTile({
    super.key,
    required this.title,
    required this.svgName,
    required this.onTap,
    this.selected,
    this.iconColor,
    this.selectedTextColor = Constants.backgroundColor,
    this.unselectedTextColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      selected: selected ?? false,
      selectedColor: selectedTextColor,
      focusColor: selectedTextColor,
      hoverColor: Colors.lightBlue.shade100,
      splashColor: Colors.lightBlue.shade200,
      selectedTileColor: Constants.primaryColor,
      horizontalTitleGap: 10,
      leading: SvgPicture.asset(
        'assets/svgs/$svgName',
        height: 20,
        color: iconColor ??
            ((selected ?? false)
                ? selectedTextColor
                : unselectedTextColor), // Specify the color you want to apply
        colorBlendMode: BlendMode.srcIn,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: (selected ?? false) ? selectedTextColor : unselectedTextColor,
        ),
      ),
    );
  }
}
