import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;

  OtpScreen({required this.verificationId});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController otpController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  void _verifyOTP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? phone = prefs.getString('phone');

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: widget.verificationId,
      smsCode: otpController.text,
    );

    try {
      await _auth.signInWithCredential(credential);
      // Successfully signed in
      // Navigate to the next screen
    } catch (e) {
      print('Failed to sign in: $e');
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
            Image.asset('assets/illustration_otp.png'), // Add your image asset here
            SizedBox(height: 20),
            Text(
              'Masukan kode OTP',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text('Kode verifikasi telah terkirim melalui SMS'),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _otpTextField(context),
                _otpTextField(context),
                _otpTextField(context),
                _otpTextField(context),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _verifyOTP,
              child: Text('Verifikasi'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _otpTextField(BuildContext context) {
    return Container(
      width: 40,
      child: TextField(
        controller: otpController,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
