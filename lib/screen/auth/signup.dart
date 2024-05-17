import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatelessWidget {
  final String phone;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();

  SignUpScreen({required this.phone});

  void _signUp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? phone = prefs.getString('phone');

    await FirebaseFirestore.instance.collection('users').add({
      'phone': phone,
      'username': usernameController.text,
      'birth_date': birthDateController.text,
    });
    // Navigate to login screen or next appropriate screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                hintText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: birthDateController,
              decoration: InputDecoration(
                hintText: 'Tanggal Lahir',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signUp,
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
