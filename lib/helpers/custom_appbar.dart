import 'package:flutter/material.dart';
import 'colors.dart';
import 'custom_text.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  final Size preferredSize;
  final String text;
  MyAppBar({
    Key? key,
    required this.text,
  })  : preferredSize = Size.fromHeight(56.0),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: primary_color,
      centerTitle: true,
      title: CustomText(
        text: text,
        color: Colors.white,
        fontWeight: FontWeight.w500,
        size: 20,
      ),
      iconTheme: IconThemeData(color: Colors.white),
    );
  }
}
