// ignore_for_file: prefer_const_constructors, unnecessary_string_escapes, unused_field

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tikom/data/blocs/sign_in_email/sign_in_email_bloc.dart';
import 'package:tikom/ui/screen/login/otp.dart';
import 'package:tikom/ui/widgets/dialog.dart';
import 'package:tikom/ui/widgets/loading_dialog.dart';
import 'package:tikom/utils/customtextfield.dart';
import 'package:tikom/common/shared_pref.dart';
import 'package:tikom/utils/storage_service.dart';
import 'package:tikom/main.dart';
import 'package:tikom/ui/screen/dashboard/home.dart';
import 'package:tikom/ui/screen/forgotpassword/forgotpass.dart';
import 'package:tikom/ui/screen/login/signup.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:tikom/utils/extentions.dart' as AppExt;

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

final GoogleSignIn _googleSignIn = GoogleSignIn(
  clientId:
      '572012807540-msrv36ir11ubb0g21sh98ugjfthus452.apps.googleusercontent.com',
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class _SignInState extends State<SignIn> {
  bool _isObscured = true;
  GoogleSignInAccount? _currentUser;
  late SignInEmailBloc _signInBloc;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _toggleObscure() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  void initState() {
    _signInBloc = SignInEmailBloc();
    _googleSignIn.onCurrentUserChanged.listen((account) {
      setState(() {
        _currentUser = account;
      });
    });
    _googleSignIn.signInSilently();
    super.initState();
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
      final response = await http.post(
          Uri.parse('${Constants.baseURL}auth/login/google/callback'),
          body: {
            'email': _currentUser?.email,
            'id': _currentUser?.id,
            'displayName': _currentUser?.displayName
          });
      if (response.statusCode == 200) {
        if (json.decode(response.body)['status'] == 'success') {
          String token = json.decode(response.body)['token'];
          StorageService.saveData('token', token);
          final snackBar = SnackBar(
            content: Text('Berhasil Login'),
            backgroundColor: Colors.black,
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);

          Future.delayed(Duration(seconds: 2), () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      MyHomePage()), // Replace with your target screen
            );
          });
        } else {
          final snackBar = SnackBar(
            content: Text('Login Gagal'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } else {
        throw Exception(
            'Failed to load categories with status code: ${response.statusCode}');
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  Future<void> _handleLogin() async {
    try {
      AppExt.hideKeyboard(context);
      DialogTemp().Konfirmasi(
        context: context,
        onYes: () {
          LoadingDialog.show(context, barrierColor: Color(0xFF777C7E));
          _signInBloc.add(SignInButtonPressed(email: _emailController.text));
        },
        title: "Apakah Ingin Login?",
        onYesText: 'Ya',
      );
    } catch (e) {
      throw Exception('Error : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => _signInBloc,
      child: BlocListener<SignInEmailBloc, SignInEmailState>(
        listener: (context, state) {
          if (state is SignInSuccess) {
            AppExt.popScreen(context);
            final snackBar = SnackBar(
              content: Text('Login Success'),
              backgroundColor: Colors.black,
              duration: Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Future.delayed(Duration(seconds: 2), () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          OtpEmailScreen(email: _emailController.text)));
            });
          } else if (state is SignInFailure) {
            AppExt.popScreen(context);
            if (state.message == 'Email Not Found') {
              DialogTemp().Konfirmasi(
                context: context,
                onYes: () {
                  LoadingDialog.show(context, barrierColor: Color(0xFF777C7E));
                  // To Regis Page
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SignUp(
                                email: _emailController.text,
                              )));
                },
                title: "Email Tidak Terdaftar?",
                onYesText: 'Daftar',
              );
            } else {
              final snackBar = SnackBar(
                content: Text('Login Failed: ${state.error}'),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          }
        },
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 100.0),
                  Text(
                    'Email',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Color.fromARGB(255, 9, 76, 58),
                    ),
                  ),
                  CustomTextfield(
                    controller: _emailController,
                    obscureText: false,
                    hintText: 'Enter Email',
                    icon: Icons.alternate_email,
                    hintStyle: GoogleFonts.poppins(),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _handleLogin,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        primary: Color.fromARGB(255, 9, 76, 58),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      child: Text(
                        'Login',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Center(
                  //   child: Text.rich(
                  //     TextSpan(children: [
                  //       TextSpan(
                  //         text: 'Forgot Password? ',
                  //         style: GoogleFonts.poppins(
                  //           color: Colors.black,
                  //         ),
                  //       ),
                  //       TextSpan(
                  //         text: 'Reset Here',
                  //         style: GoogleFonts.poppins(
                  //           color: Color.fromARGB(255, 9, 76, 58),
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //     ]),
                  //   ),
                  // ),
                  // const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(child: Divider(color: Colors.grey)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'Or With',
                          style: GoogleFonts.poppins(color: Colors.grey),
                        ),
                      ),
                      Expanded(child: Divider(color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: _handleSignIn,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20,
                            child: Image.asset('assets/logos/logo_google.png'),
                          ),
                          Text(
                            ' sign in with Google',
                            style: GoogleFonts.poppins(
                              color: const Color.fromARGB(223, 0, 0, 0),
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // InkWell(
                  //   onTap: () {
                  //     // Navigator.pushReplacement(
                  //     //   context,
                  //     //   PageTransition(
                  //     //     child: SignUp(),
                  //     //     type: PageTransitionType.bottomToTop,
                  //     //   ),
                  //     // );
                  //   },
                  //   child: Center(
                  //     child: Text.rich(
                  //       TextSpan(children: [
                  //         TextSpan(
                  //           text: "Don't have any Account? ",
                  //           style: GoogleFonts.poppins(
                  //             color: Colors.black,
                  //           ),
                  //         ),
                  //         TextSpan(
                  //           text: 'Register',
                  //           style: GoogleFonts.poppins(
                  //             color: Color.fromARGB(255, 9, 76, 58),
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //         ),
                  //       ]),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
