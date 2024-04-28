import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DrinksMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Drinks Menu',
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16), // Padding around GridView
        child: GridView.count(
          crossAxisCount: 2, // Two cards per row
          crossAxisSpacing: 10, // Horizontal space between cards
          mainAxisSpacing: 40, // Vertical space between cards
          childAspectRatio: 0.85, // Aspect ratio of each card
          children: List.generate(4, (index) => DrinkMenuCard()), // Generating 4 cards as an example
        ),
      ),
    );
  }
}

class DrinkMenuCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topLeft,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(),
                Text(
                  'LATTE',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '\$20.000',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
          Positioned(
            right: -15,
            top: -50,
            child: Image.asset(
              'assets/images/menu_latte.png',
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            right: 10,
            bottom: 10,
            child: FloatingActionButton(
              onPressed: () => print('Add to cart'),
              child: Icon(Icons.add, color: Colors.white),
              backgroundColor: Colors.green,
              mini: true,
            ),
          ),
        ],
      ),
    );
  }
}
