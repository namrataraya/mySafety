import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? size;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;

  const CustomText(
      {this.color,
      this.size,
      this.fontWeight,
      required this.text,
      this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? Colors.black,
        fontSize: size ?? 16,
        fontWeight: fontWeight ?? FontWeight.normal,
      ),
      textAlign: textAlign,
      maxLines: 15,
      overflow: TextOverflow.ellipsis,
      softWrap: true,
    );
  }
}
