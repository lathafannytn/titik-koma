import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';
import 'package:flutter/services.dart';

import '../../../utils/constant.dart';

class KodeReferralPage extends StatefulWidget {
  final String code;

  const KodeReferralPage({super.key, required this.code});
  @override
  State<KodeReferralPage> createState() => _KodeReferralPageState();
}

class _KodeReferralPageState extends State<KodeReferralPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Tikom Rewards',
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
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline, color: Colors.black),
            onPressed: () {
              _showHelpDialog(context);
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Get a voucher discount every time your friend joins via your referral code.",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SvgPicture.asset(
                    'assets/icons/kode_ref.svg',
                    height: 250,
                    width: 250,
                  ),
                  SizedBox(height: 5),
                  Text(
                    "My Referral Code",
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.grey[200],
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.code, 
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            Clipboard.setData(ClipboardData(text: widget.code)); 
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Referral code copied to clipboard!"),
                              ),
                            );
                          },
                          child: Icon(Icons.copy, size: 20),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  
                  Container(
                    height: 200,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Container(
                            width: 150, 
                            padding: EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.green[100],
                                  child: Text(
                                    '1',
                                    style: GoogleFonts.poppins(
                                      color: Constants.primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Share your referral code with friends",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Container(
                            width: 200, 
                            padding: EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.green[100],
                                  child: Text(
                                    '2',
                                    style: GoogleFonts.poppins(
                                      color: Constants.primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Ask your friend to sign up with your referral code",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Container(
                            width: 200, 
                            padding: EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.green[100],
                                  child: Text(
                                    '3',
                                    style: GoogleFonts.poppins(
                                      color: Constants.primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Done! You'll receive a voucher.",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Constants.primaryColor,
                onPrimary: Colors.white,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                final String referralMessage =
                    'Use my referral code ${widget.code} to get voucher coffee when you sign up!';
                Share.share(referralMessage);
              },
              child: Text(
                'Share Referral Code',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          title: Text(
            'Referral Code',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          content: Text(
            'You can share your referral code with friends. When they sign up using your code, you both will receive rewards!',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "Close",
                style: GoogleFonts.poppins(
                  color: Constants.primaryColor,
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}
