import 'package:flutter/material.dart';
import 'package:uni_mindelo/utils/constants/colors.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool canBack;

  const CustomAppbar({Key? key, required this.title, required this.canBack})
      : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return canBack
        ? AppBar(
            backgroundColor: AppBarColor,
            title: Text(title),
            leading: IconButton(
                icon: Icon(Icons.arrow_back, color: PrimaryBlackAssentColor),
                onPressed: () => Navigator.of(context).pop()))
        : AppBar(
            automaticallyImplyLeading: true,
            backgroundColor: AppBarColor,
            title: Text(title),
          );
  }
}
