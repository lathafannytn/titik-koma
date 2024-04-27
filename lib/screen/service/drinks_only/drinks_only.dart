// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tikom/class/CardDrinks.dart';

class DrinksOnlyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Package Bundling',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CardDrinks(
                packageName: 'Package 1',
                description: 'This is a description of Package 1.',
                price: '\$10.00',
              ),
              CardDrinks(
                packageName: 'Package 2',
                description: 'This is a description of Package 2.',
                price: '\$15.00',
              ),
              CardDrinks(
                packageName: 'Package 3',
                description: 'This is a description of Package 3.',
                price: '\$20.00',
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text('Custom Package'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
