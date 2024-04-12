// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PopularWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: Container(
                width: 400.0, // Atur lebar kotak
                height: 200.0, // Atur tinggi kotak
                padding: EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2.0,
                        blurRadius: 5.0,
                        offset: Offset(0, 1.0),
                      )
                    ]),
                child: Image.asset("assets/images/promo.png"),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: Container(
                width: 400.0, // Atur lebar kotak
                height: 200.0, // Atur tinggi kotak
                padding: EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2.0,
                        blurRadius: 5.0,
                        offset: Offset(0, 1.0),
                      )
                    ]),
                child: Image.asset("assets/images/promo.png"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
