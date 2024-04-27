import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tikom/screen/kode_referal/kode_referal.dart';

class ReveralWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Which are interesting?",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              ReveralCard(
                imagePath: "assets/images/kode_referal.jpg", // Example image path
                title: "50% OFF",
                description: "Yuk, ajak teman kamu download Aplikasi Event & Catering Kopi Titikoma",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => KodeReferralPage()),
                  );
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}

class ReveralCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final VoidCallback onTap;

  const ReveralCard({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // Add onTap functionality
      child: Card(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.symmetric(horizontal: 24.0), // Horizontal padding for screen fit
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Image.asset(
              imagePath,
              width: MediaQuery.of(context).size.width - 48, // Subtract horizontal padding
              height: 200, // Adjust height accordingly
              fit: BoxFit.cover,
            ),
            Container(
              padding: EdgeInsets.all(10),
              color: Colors.black54, // Semi-transparent black overlay for text visibility
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    description,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


