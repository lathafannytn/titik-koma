// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tikom/ui/screen/events/view_ticket.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TicketsScreen(),
    );
  }
}

class TicketsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Tickets',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ListView(
        children: [
          TicketCard(
            event: 'Dance party at the top of the town - 2022',
            location: 'New York',
            imageUrl: 'https://via.placeholder.com/150',
            status: 'Paid',
          ),
          TicketCard(
            event: 'Festival event at kudasan - 2022',
            location: 'California',
            imageUrl: 'https://via.placeholder.com/150',
            status: 'Paid',
          ),
          TicketCard(
            event: 'Party with friends at night - 2022',
            location: 'Miami',
            imageUrl: 'https://via.placeholder.com/150',
            status: 'Paid',
          ),
          TicketCard(
            event: 'Dance party at the top of the town - 2022',
            location: 'New York',
            imageUrl: 'https://via.placeholder.com/150',
            status: 'Paid',
          ),
        ],
      ),
    );
  }
}

class TicketCard extends StatelessWidget {
  final String event;
  final String location;
  final String imageUrl;
  final String status;

  TicketCard({
    required this.event,
    required this.location,
    required this.imageUrl,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.network(imageUrl,
                    width: 80, height: 80, fit: BoxFit.cover),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(Icons.location_on, size: 14),
                          SizedBox(width: 5),
                          Text(location),
                        ],
                      ),
                    ],
                  ),
                ),
                Text(
                  status,
                  style: GoogleFonts.poppins(
                    color: Colors.pink,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewTicketPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.pink,
                  ),
                  child: Text('View Ticket'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
