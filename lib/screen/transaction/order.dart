import 'package:flutter/material.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final String textToDisplay = "Hello, World!"; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          textToDisplay,
          style: TextStyle(
            fontSize: 24.0, 
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
