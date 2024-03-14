import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final String title;
  const CustomAppBar({super.key, this.height = 50, required this.title});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Theme.of(context).splashColor,
        title: Text(title),
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(height),
            child: Divider(
              color: Theme.of(context).shadowColor,
              thickness: 0.2,
            )));
  }
}
