// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tikom/data/blocs/sign_in_otp/sign_in_otp_bloc.dart';
import 'package:tikom/main.dart';

class OtpEmailScreen extends StatefulWidget {
  final String email;

  const OtpEmailScreen({super.key, required this.email});

  @override
  // ignore: library_private_types_in_public_api
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpEmailScreen> {
  List<TextEditingController> otpControllers =
      List.generate(6, (index) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());

  late SignInEmailOtpBloc _signInOtpBloc;

  void _verifyOTP() {
    String email = widget.email;
    String otp = otpControllers.map((controller) => controller.text).join();
    _signInOtpBloc.add(SignInButtonPressed(email: email, otp: otp));
  }

  @override
  void initState() {
    super.initState();
    _signInOtpBloc = SignInEmailOtpBloc();
    _setupFocusNodes();
  }

  void _setupFocusNodes() {
    for (int i = 0; i < 5; i++) {
      otpControllers[i].addListener(() {
        if (otpControllers[i].text.isNotEmpty) {
          FocusScope.of(context).requestFocus(focusNodes[i + 1]);
        }
      });
    }
    // For the last OTP field
    otpControllers[5].addListener(() {
      if (otpControllers[5].text.isNotEmpty) {
        FocusScope.of(context).unfocus(); // Hide the keyboard
        _verifyOTP(); // Verify OTP when the last field is filled
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _signInOtpBloc,
      child: BlocListener<SignInEmailOtpBloc, SignInEmailOtpState>(
        listener: (context, state) {
          if (state is SignInSuccess) {
            const snackBar = SnackBar(
              content: Text('Login Success'),
              backgroundColor: Colors.black,
              duration: Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Future.delayed(Duration(seconds: 2), () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => MyHomePage()));
            });
          } else if (state is SignInFailure) {
            final snackBar = SnackBar(
              content: Text('Login Failed: ${state.error}'),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Positioned(
                  top: -100,
                  left: -100,
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 178, 230, 214),
                    ),
                  ),
                ),
                Positioned(
                  top: -150,
                  right: -150,
                  child: Container(
                    width: 400,
                    height: 400,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 109, 205, 175),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                          height: 50), 
                      SizedBox(
                        width: 250, 
                        height: 250,
                        child: Image.asset('assets/asset/robot.png'),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'OTP Verification',
                        style: GoogleFonts.poppins(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'We will send you a one time password on this mobile number',
                        style: GoogleFonts.poppins(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 5),
                      Text(
                        widget.email,
                        style: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                            6, (index) => _otpTextField(context, index)),
                      ),
                      SizedBox(height: 20),
                      Text(
                        '05:00',
                        style: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      RichText(
                        text: TextSpan(
                          text: 'Did not send OTP? ',
                          style: GoogleFonts.poppins(
                              fontSize: 16, color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Send OTP',
                              style: GoogleFonts.poppins(
                                  fontSize: 16, color: Colors.blue),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Add your resend OTP logic here
                                },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _verifyOTP,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 100, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: const Text('Submit'),
                      ),
                      SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          // Navigate to Login screen
                        },
                        child: Text(
                          'You have an account? Login',
                          style: GoogleFonts.poppins(),
                        ),
                      ),
                      SizedBox(height: 20), // Spacer to move content down
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _otpTextField(BuildContext context, int index) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border:
            Border.all(color: Color.fromARGB(255, 60, 197, 135), width: 2.0),
      ),
      alignment: Alignment.center,
      child: TextField(
        controller: otpControllers[index],
        focusNode: focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          border: InputBorder.none,
          counterText: '',
        ),
        style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
