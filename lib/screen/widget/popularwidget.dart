// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tikom/screen/service/drinks_only/drinks_only.dart';
import 'package:tikom/screen/service/full_service/full_service.dart';

class PopularWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0),
          child: Row(
            children: [
              serviceCard(context, "drinks_only.jpg", "Drinks Only", "Pilihan tepat untuk setiap momen keluarga"),
              serviceCard(context, "full_service.jpg", "Full Service", "Pilihan lengkap untuk setiap kebutuhan"),
            ],
          ),
        ),
      ),
    );
  }

  Widget serviceCard(BuildContext context, String imagePath, String serviceName, String description) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => serviceName == "Drinks Only" ? DrinksOnlyPage() : FullServicePage()),
        );
      },
      child: Container(
        width: 250.0,
        height: 150.0,
        margin: EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2.0,
              blurRadius: 3.0,
              offset: Offset(0, 1.0),
            )
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                child: Image.asset("assets/images/$imagePath", fit: BoxFit.cover),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(left: 10.0, top: 8.0, bottom: 8.0, right: 5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      serviceName,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        description,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.normal,
                          fontSize: 10,
                        ),
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
