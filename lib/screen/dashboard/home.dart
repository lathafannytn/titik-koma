// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tikom/screen/widget/appwidget.dart';
import 'package:tikom/screen/widget/callcenterwidget.dart';
import 'package:tikom/screen/widget/popularwidget.dart';
import 'package:tikom/screen/widget/promowidget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          AppWidget(),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 15.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Color(0xFFF3F3F3),
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2.0,
                          blurRadius: 5.0,
                          offset: Offset(0, 1.0),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "What would you like to have?",
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            CupertinoIcons.search,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                    width:
                        10), // Spacer untuk memberikan jarak antara TextFormField dan InkWell
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(68, 208, 145, 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Icon(
                      Icons.filter_list,
                      color: Colors.black,
                      size: 28.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 20.0,
              left: 10.0,
            ),
            child: Text(
              "Lets find your best favorite service!",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30.0,
              ),
            ),
          ),
          PromoWidget(),
          Padding(
            padding: EdgeInsets.only(
              top: 20.0,
              left: 10.0,
              right: 10.0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    "Popular",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    // Tambahkan aksi yang diinginkan saat teks diklik
                  },
                  child: Text(
                    "see all",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13.0,
                      color: Colors.orange,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 10.0,
              right: 10.0,
            ),
            child: Text(
              "See the most popular service on order",
              style: TextStyle(
                fontSize: 10.0,
              ),
            ),
          ),
          PopularWidget(),
          CallCenterWidget(),
        ],
      ),
    );
  }
}
