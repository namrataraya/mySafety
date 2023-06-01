import 'package:flutter/material.dart';
import 'package:my_safety/helpers/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final TextInputAction textInputAction;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool? enabled;
  final InputBorder? disabledBorder;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;

  CustomTextFormField(
      {required this.textInputAction,
      this.keyboardType,
      required this.obscureText,
      this.disabledBorder,
      this.enabled,
      this.controller,
      this.prefixIcon,
      this.validator,
      });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      textInputAction: textInputAction,
      cursorColor: primary_color,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.only(left: 10, top: 4, bottom: 4, right: 4),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: border_color),
        ),
        disabledBorder: disabledBorder,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: border_color),
        ),
        prefixIcon: prefixIcon,
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
      enabled: enabled,
    );
  }
}
