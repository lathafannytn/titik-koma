// ignore_for_file: prefer_const_constructors, prefer_const_declarations

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';

class KodeReferralPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Kode Referral',
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
      body: SingleChildScrollView(
        // Use SingleChildScrollView to avoid overflow when keyboard appears or screen size is small
        padding: EdgeInsets.all(20.0), // Padding around the content
        child: Column(
          crossAxisAlignment: CrossAxisAlignment
              .center, // Aligns all children to the center horizontally
          children: <Widget>[
            Text(
              "Diskon 50% untuk kamu!",
              style: GoogleFonts.poppins(
                fontSize: 24, // Larger font size for importance
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center, // Center text alignment
            ),
            SizedBox(height: 20), // Space between elements
            Text(
              "Dapatkan voucher diskon 50% setiap kali temanmu bergabung melalui kode referralmu.",
              style: GoogleFonts.poppins(
                fontSize: 16, // Moderate font size for readability
                color: Colors.black,
              ),
              textAlign: TextAlign.center, // Center text alignment
            ),
            SizedBox(height: 30), // Space before the image
            Image.asset(
              'assets/logos/logo_tikom_bulat_hijau_hitam.png', // Assuming you have a logo image in your assets
              height: 100, // Fixed height for the image
            ),
            SizedBox(
              height: 20,
            ),
            Image.asset(
              'assets/logos/logo_tikom_hijau_hitam.png', // Assuming you have a logo image in your assets
              height: 120, // Fixed height for the image
            ),
            SizedBox(height: 20), // Space after the image
            Text(
              "Bagikan kode referralmu",
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center, // Center text alignment
            ),
            SizedBox(
              height: 15,
            ),
            //CopyableTextWithIcon(),
            Container(
              width: 200.0,
              height: 50.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: Colors.grey[200],
                border: Border.all(
                  color: Colors.black,
                  width: 2.0,
                ),
              ),
              child: Center(
                child: Text(
                  'F0019B',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold, fontSize: 24.0),
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(68, 208, 145, 1.0), // Background color
                onPrimary: Colors.white, // Text color
                minimumSize: Size(double.infinity, 50), // Set the button's size
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Rounded corners
                ),
              ),
              onPressed: () {
                final String referralMessage =
                    'Use my referral code F0019B to get 50% off when you sign up!';
                Share.share(referralMessage);
              },
              child: Text(
                'Bagikan Kode',
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
