import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart'; // Make sure this is imported if using Get.back()

// Assuming Iconsax is defined and properly imported if it's a custom icon set
// import 'path_to_iconsax.dart'; 

class TAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TAppBar({
    super.key,
    this.title,
    this.actions,
    this.leadingIcon,
    this.leadingOnPressed,
    this.showBackArrow = true,
  });

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: AppBar(
        automaticallyImplyLeading: false,
        title: title,
        leading: showBackArrow 
          ? IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back)) 
          : leadingIcon !=null? IconButton(onPressed: leadingOnPressed, icon: Icon(leadingIcon)
        ) : null,
        actions: actions,
        
      ),
    );
  }

  static double getAppBarHeight() {
    return kToolbarHeight;
  }

  @override
  Size get preferredSize => Size.fromHeight(getAppBarHeight());
}
