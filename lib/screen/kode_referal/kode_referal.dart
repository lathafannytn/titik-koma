import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class KodeReferralPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Kode Referral',
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
      ),
      body: SingleChildScrollView(
        // Use SingleChildScrollView to avoid overflow when keyboard appears or screen size is small
        padding: EdgeInsets.all(20.0), // Padding around the content
        child: Column(
          crossAxisAlignment: CrossAxisAlignment
              .center, // Aligns all children to the center horizontally
          children: <Widget>[
            Text(
              "Diskon 50% untuk kamu!",
              style: GoogleFonts.poppins(
                fontSize: 24, // Larger font size for importance
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center, // Center text alignment
            ),
            SizedBox(height: 20), // Space between elements
            Text(
              "Dapatkan voucher diskon 50% setiap kali temanmu bergabung melalui kode referralmu.",
              style: GoogleFonts.poppins(
                fontSize: 16, // Moderate font size for readability
                color: Colors.black,
              ),
              textAlign: TextAlign.center, // Center text alignment
            ),
            SizedBox(height: 30), // Space before the image
            Image.asset(
              'assets/logos/logo_tikom_bulat_hijau_hitam.png', // Assuming you have a logo image in your assets
              height: 100, // Fixed height for the image
            ),
            SizedBox(
              height: 20,
            ),
            Image.asset(
              'assets/logos/logo_tikom_hijau_hitam.png', // Assuming you have a logo image in your assets
              height: 120, // Fixed height for the image
            ),
            SizedBox(height: 20), // Space after the image
            Text(
              "Bagikan kode referralmu",
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center, // Center text alignment
            ),
            SizedBox(
              height: 15,
            ),
            //CopyableTextWithIcon(),
            Container(
              width: 200.0,
              height: 50.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: Colors.grey[200],
                border: Border.all(
                  color: Colors.black,
                  width: 2.0,
                ),
              ),
              child: Center(
                child: Text(
                  'F0019B',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold, fontSize: 24.0),
                ),
              ),
            ),
            SizedBox(height: 100,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(68, 208, 145, 1.0), // Background color
                onPrimary: Colors.white, // Text color
                minimumSize: Size(double.infinity, 50), // Set the button's size
                shape: RoundedRectangleBorder(
                  // This creates the rounded corners
                  borderRadius: BorderRadius.circular(
                      30), // Adjust the border radius here
                ),
              ),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: 'F0019B'));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Kode telah disalin!"),
                  ),
                );
              },
              child: Text(
                'Bagikan Kode',
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// class CopyableTextWithIcon extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Row(
//         mainAxisSize: MainAxisSize.min, // Ensures the Row takes only as much width as needed
//         children: <Widget>[
//           Text(
//             'F0019B',
//             style: GoogleFonts.poppins(
//               fontWeight: FontWeight.bold,
//               fontSize: 24.0,
//             ),
//           ),
//           SizedBox(width: 10), // Space between text and icon
//           InkWell(
//             onTap: () {
//               Clipboard.setData(ClipboardData(text: 'F0019B')).then((_) {
//                 // Optionally show a toast or some feedback
//                 Fluttertoast.showToast(
//                   msg: "Code copied to clipboard",
//                   toastLength: Toast.LENGTH_SHORT,
//                   gravity: ToastGravity.CENTER,
//                   timeInSecForIosWeb: 1,
//                   backgroundColor: Colors.grey[800],
//                   textColor: Colors.white,
//                   fontSize: 16.0,
//                 );
//               });
//             },
//             child: Icon(
//               Icons.content_copy, // Clipboard icon
//               color: Colors.black,
//               size: 24.0,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
