import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/illustration_otp.png'),
                const SizedBox(height: 20),
                const Text(
                  'Masukan kode OTP',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Text('Kode verifikasi telah terkirim melalui Email'),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    6,
                    (index) => _otpTextField(context, index),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _verifyOTP,
                  child: const Text('Verifikasi'),
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
      width: 40,
      child: TextField(
        controller: otpControllers[index],
        focusNode: focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
