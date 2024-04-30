import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardFull extends StatelessWidget {
  final String packageName;
  final String description;
  final String imageUrl; // Assuming you might pass an image URL

  const CardFull({
    Key? key,
    required this.packageName,
    required this.description,
    this.imageUrl = 'assets/images/full_service.jpg', // Default image if none provided
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Rounded corners for the card
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0), // Padding inside the card
        child: Stack(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.horizontal(left: Radius.circular(10)), // Rounded corners on the left side
                  child: Image.asset(
                    imageUrl,
                    width: 100, // Fixed width for the image
                    height: 100, // Fixed height for the image
                    fit: BoxFit.cover, // Cover fit to maintain aspect ratio
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          packageName,
                          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          description,
                          style: GoogleFonts.poppins(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              right: 8, 
              bottom: 8, 
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
