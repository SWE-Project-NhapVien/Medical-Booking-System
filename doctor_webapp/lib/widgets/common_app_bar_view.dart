import 'package:doctor_webapp/utils/color_palette.dart';
import 'package:flutter/material.dart';

class CommonAppBarView extends StatelessWidget implements PreferredSizeWidget {
  final IconData iconData;
  final String title;
  final VoidCallback onBackClick;
  final bool isWeb;

  const CommonAppBarView({
    super.key,
    required this.iconData,
    required this.title,
    required this.onBackClick,
    this.isWeb = true, // Default for web
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorPalette.mediumBlue,
      elevation: 0,
      toolbarHeight: isWeb ? 70 : 56,
      leading: IconButton(
        icon: Icon(iconData, color: ColorPalette.whiteColor),
        onPressed: onBackClick,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: ColorPalette.whiteColor,
          fontWeight: FontWeight.bold,
          fontSize: isWeb ? 22 : 18, // Larger font size for web
        ),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: IconButton(
            icon: Icon(
              Icons.settings,
              color: ColorPalette.whiteColor,
            ),
            onPressed: () {
              // Placeholder for settings action
            },
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(isWeb ? 70 : 56);
}
