import 'package:flutter/material.dart';
import 'package:tikom/class/constant.dart';

class CustomTextfield extends StatelessWidget {
  final IconData icon;
  final bool obscureText;
  final String hintText;
  final IconButton? suffixIcon;

  const CustomTextfield({
    Key? key,
    required this.icon,
    required this.obscureText,
    required this.hintText,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      style: TextStyle(
        color: Constants.blackColor,
      ),
      decoration: InputDecoration(
        border: InputBorder.none, // Menghapus border
        prefixIcon: Icon(icon, color: Constants.blackColor.withOpacity(0.3)),
        suffixIcon: suffixIcon,
        hintText: hintText,
      ),
      cursorColor: Constants.blackColor.withOpacity(0.5),
    );
  }
}
