import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../utils/constant.dart';

class HelpCenterPage extends StatelessWidget {
  final String whatsappNumber = '+6282332238228';

  void _launchWhatsApp() async {
    final message = Uri.encodeComponent('Hello, I need assistance with the Tikom App.');
    final url = 'https://wa.me/$whatsappNumber?text=$message';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help Center', style: GoogleFonts.poppins()),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Center(
              child: Image.asset(
                'assets/logos/logo_tikom_bulat_hijau_hitam.png',
                height: 100.0,
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Image.asset(
                'assets/logos/logo_tikom_hijau_hitam.png',
                height: 40.0,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Need help? Contact us via WhatsApp or check our FAQs below.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Frequently Asked Questions',
              style: GoogleFonts.poppins(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ExpansionTile(
                      title: Text(
                        'How to use the app?',
                        style: GoogleFonts.poppins(
                          fontSize: 16.0,
                        ),
                      ),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Here you will find detailed instructions on how to use the app.',
                            style: GoogleFonts.poppins(
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ExpansionTile(
                      title: Text(
                        'My order has not been confirmed by the admin. I have already uploaded the payment proof.',
                        style: GoogleFonts.poppins(
                          fontSize: 16.0,
                        ),
                      ),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'If your order has not been confirmed yet, please wait a moment. If it is still not confirmed, please contact customer support via WhatsApp by clicking the button below.',
                            style: GoogleFonts.poppins(
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ExpansionTile(
                      title: Text(
                        'How to contact support?',
                        style: GoogleFonts.poppins(
                          fontSize: 16.0,
                        ),
                      ),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'You can contact support via WhatsApp by clicking the button below.',
                            style: GoogleFonts.poppins(
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        color: Colors.white,
        child: ElevatedButton(
          onPressed: _launchWhatsApp,
          style: ElevatedButton.styleFrom(
            primary: Constants.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.symmetric(vertical: 15),
            elevation: 0, // No shadow
          ),
          child: Text(
            'Contact us on WhatsApp',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }
}
