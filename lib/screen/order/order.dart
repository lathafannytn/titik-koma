import 'package:flutter/material.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({Key? key}) : super(key: key);

  @override
  _OrderWidgetState createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  final String textToDisplay = "Hello, World!"; // Ganti dengan teks yang ingin Anda panggil

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          textToDisplay,
          style: TextStyle(
            fontSize: 24.0, // Sesuaikan ukuran teks
            fontWeight: FontWeight.bold, // Sesuaikan gaya teks
          ),
        ),
      ),
    );
  }
}
