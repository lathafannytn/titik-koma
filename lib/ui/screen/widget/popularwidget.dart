import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tikom/ui/screen/catering/catering.dart';
import 'package:tikom/ui/screen/service/drinks_only/drinks_only.dart';
import 'package:tikom/ui/screen/service/full_service/full_service.dart';

class PopularWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: serviceLink(context, "Drinks Only",
                      "assets/images/icon_drinks.png", DrinksOnlyPage()),
                ),
                Container(
                  color: Colors.grey[200],
                  width: 1,
                  height: 70,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                ),
                Expanded(
                  child: serviceLink(context, "Full Service",
                      "assets/images/icon_full.png", CateringScreen()),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget serviceLink(
      BuildContext context, String serviceName, String imagePath, Widget page) {
    return InkWell(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => page)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, width: 60, height: 60),
          SizedBox(height: 8),
          Text(
            serviceName,
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
