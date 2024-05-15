import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextfield extends StatelessWidget {
  final bool obscureText;
  final String hintText;
  final IconData icon;
  final Widget? suffixIcon;
  final TextStyle? hintStyle; // Tambahkan properti hintStyle
  final TextEditingController controller; // Tambahkan properti controller

  const CustomTextfield({
    Key? key,
    required this.obscureText,
    required this.hintText,
    required this.icon,
    required this.controller, // Tambahkan properti controller
    this.suffixIcon,
    this.hintStyle, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller, // Gunakan properti controller di sini
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hintText,
        hintStyle: hintStyle, // Gunakan properti hintStyle di sini
        border: OutlineInputBorder(),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
