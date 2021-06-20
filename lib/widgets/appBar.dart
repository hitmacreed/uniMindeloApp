import 'package:flutter/material.dart';
import 'package:uni_mindelo/utils/colors.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppbar({Key? key, required this.title}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: AppBarColor,
        title: Text(title),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: PrimaryBlackAssentColor),
          onPressed: () => Navigator.pop(context, false),
        ));
  }
}
