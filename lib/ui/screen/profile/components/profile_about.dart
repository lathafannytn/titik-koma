import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileAbout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 16.0),
              Text(
                'Titik Koma',
                style: GoogleFonts.poppins(
                    fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                'Designed and built with love by Fanny in Indonesia',
                style: GoogleFonts.poppins(fontSize: 16.0),
              ),
              SizedBox(height: 32.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 32.0,
                    backgroundImage:
                        NetworkImage('https://i.imgur.com/avatar.png'),
                  ),
                  SizedBox(width: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Fanny',
                        style: GoogleFonts.poppins(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Developer & Designer',
                        style: GoogleFonts.poppins(fontSize: 16.0),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 32.0),
              Text(
                'Version 1.0.0',
                style: GoogleFonts.poppins(fontSize: 16.0),
              ),
              Text(
                '© 2023-2024 Titik Koma',
                style: GoogleFonts.poppins(fontSize: 16.0),
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Back to Home', style: GoogleFonts.poppins()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
