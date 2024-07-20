import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsAndConditionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Terms and Conditions', 
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          )
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Kopi Titik Koma Cafe',
                style: GoogleFonts.poppins(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                '1. Introduction',
                style: GoogleFonts.poppins(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Welcome to Kopi Titik Koma Cafe. These are the terms and conditions governing your use of our website and services. By accessing or using our services, you agree to be bound by these terms.',
                style: GoogleFonts.poppins(
                  fontSize: 14.0,
                ),
              ),
              SizedBox(height: 20),
              Text(
                '2. Intellectual Property Rights',
                style: GoogleFonts.poppins(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Other than the content you own, under these Terms, Kopi Titik Koma Cafe and/or its licensors own all the intellectual property rights and materials contained in this Website.',
                style: GoogleFonts.poppins(
                  fontSize: 14.0,
                ),
              ),
              SizedBox(height: 20),
              Text(
                '3. Restrictions',
                style: GoogleFonts.poppins(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'You are specifically restricted from all of the following:\n'
                '• Publishing any Website material in any other media.\n'
                '• Selling, sublicensing and/or otherwise commercializing any Website material.\n'
                '• Publicly performing and/or showing any Website material.\n'
                '• Using this Website in any way that is or may be damaging to this Website.\n'
                '• Using this Website in any way that impacts user access to this Website.\n'
                '• Using this Website contrary to applicable laws and regulations, or in any way may cause harm to the Website, or to any person or business entity.',
                style: GoogleFonts.poppins(
                  fontSize: 14.0,
                ),
              ),
              SizedBox(height: 20),
              Text(
                '4. Your Privacy',
                style: GoogleFonts.poppins(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Please read our Privacy Policy.',
                style: GoogleFonts.poppins(
                  fontSize: 14.0,
                ),
              ),
              SizedBox(height: 20),
              Text(
                '5. No warranties',
                style: GoogleFonts.poppins(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'This Website is provided "as is," with all faults, and Kopi Titik Koma Cafe express no representations or warranties, of any kind related to this Website or the materials contained on this Website.',
                style: GoogleFonts.poppins(
                  fontSize: 14.0,
                ),
              ),
              SizedBox(height: 20),
              Text(
                '6. Limitation of liability',
                style: GoogleFonts.poppins(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'In no event shall Kopi Titik Koma Cafe, nor any of its officers, directors and employees, shall be held liable for anything arising out of or in any way connected with your use of this Website whether such liability is under contract.  Kopi Titik Koma Cafe, including its officers, directors and employees shall not be held liable for any indirect, consequential or special liability arising out of or in any way related to your use of this Website.',
                style: GoogleFonts.poppins(
                  fontSize: 14.0,
                ),
              ),
              SizedBox(height: 20),
              Text(
                '7. Indemnification',
                style: GoogleFonts.poppins(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'You hereby indemnify to the fullest extent Kopi Titik Koma Cafe from and against any and/or all liabilities, costs, demands, causes of action, damages and expenses arising in any way related to your breach of any of the provisions of these Terms.',
                style: GoogleFonts.poppins(
                  fontSize: 14.0,
                ),
              ),
              SizedBox(height: 20),
              Text(
                '8. Severability',
                style: GoogleFonts.poppins(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'If any provision of these Terms is found to be invalid under any applicable law, such provisions shall be deleted without affecting the remaining provisions herein.',
                style: GoogleFonts.poppins(
                  fontSize: 14.0,
                ),
              ),
              SizedBox(height: 20),
              Text(
                '9. Variation of Terms',
                style: GoogleFonts.poppins(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Kopi Titik Koma Cafe is permitted to revise these Terms at any time as it sees fit, and by using this Website you are expected to review these Terms on a regular basis.',
                style: GoogleFonts.poppins(
                  fontSize: 14.0,
                ),
              ),
              SizedBox(height: 20),
              Text(
                '10. Assignment',
                style: GoogleFonts.poppins(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'The Kopi Titik Koma Cafe is allowed to assign, transfer, and subcontract its rights and/or obligations under these Terms without any notification. However, you are not allowed to assign, transfer, or subcontract any of your rights and/or obligations under these Terms.',
                style: GoogleFonts.poppins(
                  fontSize: 14.0,
                ),
              ),
              SizedBox(height: 20),
              Text(
                '11. Entire Agreement',
                style: GoogleFonts.poppins(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'These Terms constitute the entire agreement between Kopi Titik Koma Cafe and you in relation to your use of this Website, and supersede all prior agreements and understandings.',
                style: GoogleFonts.poppins(
                  fontSize: 14.0,
                ),
              ),
              SizedBox(height: 20),
              Text(
                '12. Governing Law & Jurisdiction',
                style: GoogleFonts.poppins(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'These Terms will be governed by and interpreted in accordance with the laws of the State of Indonesia, and you submit to the non-exclusive jurisdiction of the state and federal courts located in Indonesia for the resolution of any disputes.',
                style: GoogleFonts.poppins(
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
