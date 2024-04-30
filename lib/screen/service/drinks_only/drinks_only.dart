// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tikom/class/card/CardDrinks.dart';

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
                packageName: 'Package A',
                description: 'for 20 pax',
                price: '\Rp 350.000',
              ),
              CardDrinks(
                packageName: 'Package B',
                description: 'for 60 pax',
                price: '\Rp 950.000',
              ),
              CardDrinks(
                packageName: 'Package C',
                description: 'for 80 pax',
                price: '\Rp 1.200.000',
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
