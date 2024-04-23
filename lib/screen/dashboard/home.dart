// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tikom/screen/widget/popularwidget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
   
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 140,
                  width: double.infinity,
                  child: Image.asset(
                    "assets/images/home.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                  alignment: Alignment.topLeft,
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "https://studiolorier.com/wp-content/uploads/2018/10/Profile-Round-Sander-Lorier.jpg")),
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(
                                          color: Colors.white,
                                          style: BorderStyle.solid,
                                          width: 2))),
                              SizedBox(
                                width: 10,
                              ),
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Hi, ',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Fanny',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                              alignment: Alignment.topRight,
                              child: Icon(
                                Icons.notifications_active,
                                color: Colors.white,
                                size: 30,
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/logos/logo_tikom_bulat_hijau_hitam.png',
                                        width: 20,
                                        height: 20,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(width: 10),
                                      RichText(
                                        text: TextSpan(
                                          style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              color: Colors.black),
                                          children: <TextSpan>[
                                            TextSpan(text: '100 '),
                                            TextSpan(
                                              text: 'poin',
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 50),
                                      Icon(
                                        Icons.discount,
                                        color:
                                            Color.fromRGBO(68, 208, 145, 1.0),
                                        size: 20,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        '8',
                                        style: GoogleFonts.poppins(
                                            fontSize: 15, color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  // InkWell(
                                  //   onTap: () {
                                  //     print('Icon tapped!');
                                  //   },
                                  //   child:
                                  //       Icon(Icons.arrow_forward_ios, size: 20),
                                  // ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Divider(
                                color: Colors.grey,
                                thickness: 1,
                              ),
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Tukarkan poinmu dengan rewards menarik",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      print('Icon tapped!');
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromRGBO(68, 208, 145, 1.0),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 10,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 8.0, left: 24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Lets find your best favorite service!",
                            style: GoogleFonts.poppins(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment
                          .start, // Align text to the start of your column
                      children: <Widget>[
                        Text(
                          "Popular",
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "See the most popular service on order",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    PopularWidget(),
                  ],
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
