import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class PointDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Navigate back
          },
        ),
        title: Text(
          'Tikom Points',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline, color: Colors.black),
            onPressed: () {
              // Help action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildPointsSummary(),
              SizedBox(height: 16),
              buildPointsHistoryHeader(),
              SizedBox(height: 8),
              buildPointsHistory(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPointsSummary() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 30, 83, 66),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Tikom Points',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '25',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 32),
                ),
              ),
              Icon(Icons.qr_code, color: Colors.white, size: 32),
            ],
          ),
          SizedBox(height: 8),
          Text(
            '100 points = \$1.00. You can use these points as payment.',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPointsHistoryHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Points History',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        GestureDetector(
          onTap: () {
            // View All action
          },
          child: Text(
            'View All',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(color: Color.fromARGB(255, 30, 83, 66), fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPointsHistory() {
    return Column(
      children: [
        buildPointsHistoryItem('You earn points', '+25', 'Dec 22, 2023 - 09:41:45 AM'),
        buildPointsHistoryItem('You use points', '-200', 'Dec 22, 2023 - 09:41:20 AM'),
        buildPointsHistoryItem('You earn points', '+50', 'Dec 19, 2023 - 19:20:49 PM'),
        buildPointsHistoryItem('You earn points', '+100', 'Dec 18, 2023 - 20:46:53 PM'),
        buildPointsHistoryItem('You earn points', '+50', 'Dec 17, 2023 - 10:07:38 AM'),
        buildPointsHistoryItem('You use points', '-100', 'Dec 14, 2023 - 16:44:57 PM'),
        buildPointsHistoryItem('You earn points', '+25', 'Dec 14, 2023 - 15:24:45 PM'),
      ],
    );
  }

  Widget buildPointsHistoryItem(String title, String points, String date) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              Text(
                date,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),
            ],
          ),
          Text(
            points,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
