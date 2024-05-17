import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tikom/screen/auth/otp.dart';
import 'package:tikom/screen/auth/signup.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  void _sendOTP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('phone', phoneController.text);

    var userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('phone', isEqualTo: '+62${phoneController.text}')
        .get();

    if (userSnapshot.docs.isEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SignUpScreen(phone: phoneController.text)),
      );
    } else {
      await _auth.verifyPhoneNumber(
        phoneNumber: '+62${phoneController.text}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpScreen(verificationId: verificationId),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/illustration.png'), // Add your image asset here
            SizedBox(height: 20),
            Text(
              'Selamat Datang',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text('Masuk atau Daftarkan akun COFFEE kamu'),
            SizedBox(height: 20),
            Row(
              children: <Widget>[
                Text('+62'),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: 'Nomor Telepon',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _sendOTP,
              child: Text('Lanjutkan'),
            ),
          ],
        ),
      ),
    );
  }
}
