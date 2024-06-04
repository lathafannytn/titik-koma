// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListNotif extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notification',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Text(
              'Today',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            NotificationItem(
              icon: Icons.local_offer,
              title: 'Get 30% Off on Dance Event!',
              description: 'Special promotion only valid today',
            ),
            NotificationItem(
              icon: Icons.lock,
              title: 'Password Update Successful',
              description: 'Your password update successfully',
            ),
            SizedBox(height: 20),
            Text(
              'Yesterday',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            NotificationItem(
              icon: Icons.person,
              title: 'Account Setup Successful!',
              description: 'Your account has been created',
            ),
            NotificationItem(
              icon: Icons.card_giftcard,
              title: 'Redeem your gift cart',
              description: 'You have got one gift card',
            ),
            NotificationItem(
              icon: Icons.credit_card,
              title: 'Debit card added successfully',
              description: 'Your debit card added successfully',
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  NotificationItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.pink,
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          description,
          style: GoogleFonts.poppins(),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ListNotif(),
  ));
}
