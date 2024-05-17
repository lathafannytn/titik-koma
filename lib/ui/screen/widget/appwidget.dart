// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 15.0,
        horizontal: 15.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // InkWell(
          //   onTap: () {},
          //   child: Container(
          //     padding: EdgeInsets.all(8.0),
          //     decoration: BoxDecoration(
          //         color: Colors.white,
          //         borderRadius: BorderRadius.circular(20),
          //         boxShadow: [
          //           BoxShadow(
          //             color: Colors.grey,
          //             spreadRadius: 1.0,
          //             blurRadius: 5.0,
          //             offset: Offset(0, 1),
          //           ),
          //         ]),
          //     child: Icon(CupertinoIcons.bars),
          //   ),
          // ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Hello, ',
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                TextSpan(
                  text: 'helmi',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                TextSpan(
                  text: '.',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),

          InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 1.0,
                      blurRadius: 5.0,
                      offset: Offset(0, 1),
                    ),
                  ]),
              child: Icon(Icons.notifications),
            ),
          ),
        ],
      ),
    );
  }
}
