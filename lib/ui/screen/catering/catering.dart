// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tikom/class/card/CardFull.dart';
import 'package:tikom/ui/screen/catering/card_catering.dart';

class CateringScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Full Service',
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
              CateringCard(
                packageName: 'Pop-Up Cold',
                description: 'Cold beverages only, with barista',
                price: '350.000',
                imageUrl: 'assets/images/full_service.jpg',
              ),
              CateringCard(
                packageName: 'Pop-Up Cafe',
                description: 'Hot & Cold beverages, with barista & Machine',
                price: '500.000',
                imageUrl: 'assets/images/full_service.jpg',
              ),
            ],
          ),
        ),
      ),
    );
  }
}