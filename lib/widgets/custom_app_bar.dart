import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_smart_app/services/assets_manager.dart';
import 'package:shop_smart_app/widgets/custom_app_bar_title.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: SvgPicture.asset(
          AssetsManager.smartLogo,
          width: 100,
          height: 100,
        ),
      ),
      // centerTitle: true,
      title: CustomAppBarTitle(),
      centerTitle: true,
    );
  }
}
