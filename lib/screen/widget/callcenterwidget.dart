import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CallCenterWidget extends StatelessWidget {
  final String phoneNumber = '+6281703367870'; // Phone number with country code

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      child: GestureDetector(
        onTap: () => _launchURL('https://wa.me/$phoneNumber'),
        child: Container(
          width: double.infinity,
          height: 100.0,
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
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "CALL CENTER:",
                    style:
                        TextStyle(fontWeight: FontWeight.w900, fontSize: 20.0),
                  ),
                  Row(
                    children: [
                      Text(" "),
                      Image.asset(
                        "assets/images/whatsapp.png",
                        width: 30.0,
                        height: 30.0,
                      ),
                      SizedBox(width: 5.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(" "),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: phoneNumber,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 20.0,
                                      color: Colors.black),
                                ),
                                TextSpan(
                                  text: ' (Only Chat)',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }
}
