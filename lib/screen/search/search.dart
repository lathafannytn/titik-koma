import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final String textToDisplay = "INI Search!"; // Ganti dengan teks yang ingin Anda panggil

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
