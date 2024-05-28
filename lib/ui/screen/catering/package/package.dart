import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'card_package.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Package Bundling',
      theme: ThemeData(
        primarySwatch: Colors.green,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: PackageScreen(),
    );
  }
}

class PackageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Package Bundling'),
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: [
          PackageCard(
            packageName: 'Package A',
            description: 'for 200 pax\n5.000.000',
          ),
          PackageCard(
            packageName: 'Package B',
            description: 'for 300 pax\n7.500.000',
          ),
          PackageCard(
            packageName: 'Package C',
            description: 'for 400 pax\n9.000.000',
          ),
          PackageCard(
            packageName: 'Package D',
            description: 'for 500 pax\n11.500.000',
          ),
        ],
      ),
      // bottomNavigationBar: BottomAppBar(
      //   child: Padding(
      //     padding: const EdgeInsets.all(16.0),
      //     child: ElevatedButton(
      //       onPressed: () {},
      //       child: Text('Add - 5.000.000'),
      //       style: ElevatedButton.styleFrom(
      //         primary: Colors.green,
      //         padding: EdgeInsets.symmetric(vertical: 16),
      //         textStyle: TextStyle(fontSize: 18),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
