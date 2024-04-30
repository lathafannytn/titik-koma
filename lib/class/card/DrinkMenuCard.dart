import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DrinkMenuCard extends StatelessWidget {
  final String name;
  final String price;
  final String imagePath;

  DrinkMenuCard(
      {required this.name, required this.price, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    int priceValue = int.tryParse(price) ?? 0;
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
                  name,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '\$${priceValue.toString()}',
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
            right: 5,
            top: -50,
            child: Image.asset(
              imagePath,
              width: 90,
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
