// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DrinksOnlyPage()),
                    );
                  },
                  child: Container(
                    width: 200.0, // Adjust the width of the box
                    height: 150.0, // Adjust the height of the box
                    padding: EdgeInsets.all(2.0),
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
                    child: Image.asset("assets/images/promo.png"),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FullServicePage()),
                    );
                  },
                  child: Container(
                    width: 200.0, // Adjust the width of the box
                    height: 150.0, // Adjust the height of the box
                    padding: EdgeInsets.all(2.0),
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
                    child: Image.asset("assets/images/promo.png"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
