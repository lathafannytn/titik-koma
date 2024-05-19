import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextfield extends StatelessWidget {
  final bool obscureText;
  final String hintText;
  final IconData icon;
  final Widget? suffixIcon;
  final TextStyle? hintStyle; 
  final TextEditingController controller; 

  const CustomTextfield({
    Key? key,
    required this.obscureText,
    required this.hintText,
    required this.icon,
    required this.controller, 
    this.suffixIcon,
    this.hintStyle, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller, 
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hintText,
        hintStyle: hintStyle,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(color: Color.fromARGB(255, 19, 78, 70)),
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
