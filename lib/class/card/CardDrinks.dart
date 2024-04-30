import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardDrinks extends StatelessWidget {
  final String packageName;
  final String description;
  final String price;
  final String imageUrl;

  const CardDrinks({
    Key? key,
    required this.packageName,
    required this.description,
    required this.price,
    this.imageUrl = 'assets/images/drinks_only.jpg',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Stack(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  child: Image.asset(
                    imageUrl,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          packageName,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Text(
                          description,
                          style: GoogleFonts.poppins(fontSize: 14),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    '\nSTART FROM\n', // Use \n to create a new line
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: price, // Main price
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              right: 8, // Right margin within the card
              bottom: 8, // Bottom margin within the card
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.brown,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_forward,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
