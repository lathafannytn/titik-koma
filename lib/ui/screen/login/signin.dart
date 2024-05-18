// ignore_for_file: prefer_const_constructors, unnecessary_string_escapes, unused_field

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tikom/data/blocs/sign_in/sign_in_bloc.dart';
import 'package:tikom/utils/customtextfield.dart';
import 'package:tikom/common/shared_pref.dart';
import 'package:tikom/utils/storage_service.dart';
import 'package:tikom/main.dart';
import 'package:tikom/ui/screen/dashboard/home.dart';
import 'package:tikom/ui/screen/forgotpassword/forgotpass.dart';
import 'package:tikom/ui/screen/signup/signup.dart';
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
  late SignInBloc _signInBloc;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _toggleObscure() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  void initState() {
    _googleSignIn.onCurrentUserChanged.listen((account) {
      setState(() {
        _currentUser = account;
        // print(_currentUser);
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

          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

          // Navigate after the SnackBar is closed
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

          // ignore: use_build_context_synchronously
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
    // Hidden Keyboards
    AppExt.hideKeyboard(context);
    try {
      _signInBloc.add(SignInButtonPressed(email: _emailController.text,password: _passwordController.text));
      final snackBar = SnackBar(
          content: Text('Login Success'),
          backgroundColor: Colors.black,
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Future.delayed(Duration(seconds: 2), () {
        AppExt.pushScreen(context,MyHomePage());
      });
    //   final response = await http.post(
    //       Uri.parse('https://titik-koma.givenjeremia.com/api/auth/login'),
    //       body: {
    //         'email': _emailController.text,
    //         'password': _passwordController.text
    //       });
    //   if (response.statusCode == 200) {
    //     if (json.decode(response.body)['status'] == 'success') {
    //       String token = json.decode(response.body)['token'];
    //       StorageService.saveData('token', token);
    //       final snackBar = SnackBar(
    //         content: Text('Login Success'),
    //         backgroundColor: Colors.black,
    //         duration: Duration(seconds: 2),
    //         behavior: SnackBarBehavior.floating,
    //       );

    //       // ignore: use_build_context_synchronously
    //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
    //     } else {
    //       final snackBar = SnackBar(
    //         content: Text('Login Success'),
    //         backgroundColor: Colors.red,
    //         duration: Duration(seconds: 2),
    //         behavior: SnackBarBehavior.floating,
    //       );

    //       // ignore: use_build_context_synchronously
    //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
    //     }
    //   } else {
    //     throw Exception(
    //         'Failed to load categories with status code: ${response.statusCode}');
    //   }
    } catch (e) {
      throw Exception('Failed to connect to the server Category: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: const AssetImage(
                    'assets/logos/logo_tikom_bulat_hijau_hitam.png'),
                height: 100.0,
              ),
              SizedBox(
                height: 12.0,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Welcome to ",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .fontSize,
                      ),
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.baseline,
                      baseline: TextBaseline.ideographic,
                      child: Baseline(
                        baseline: 0.0,
                        baselineType: TextBaseline.ideographic,
                        child: Image.asset(
                          'assets/logos/logo_tikom_hijau_hitam.png',
                          height: 20,
                          // sesuaikan lebar gambar
                        ),
                      ),
                    ),
                    TextSpan(
                      text: " !",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .fontSize,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextfield(
                controller: _emailController,
                obscureText: false,
                hintText: 'Enter Email',
                icon: Icons.alternate_email,
                hintStyle: GoogleFonts.poppins(),
              ),
              CustomTextfield(
                controller: _passwordController,
                obscureText: _isObscured,
                hintText: 'Enter Password',
                icon: Icons.lock,
                hintStyle: GoogleFonts.poppins(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isObscured ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: _toggleObscure,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: InkWell(
                  onTap: _handleLogin,
                  child: Container(
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Constants.primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Center(
                      child: Text(
                        'Sign In',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              //forgot pas
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                      child: const SignIn(),
                      type: PageTransitionType.bottomToTop,
                    ),
                  );
                },
                child: Center(
                  child: Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: 'Forgot Password? ',
                        style: GoogleFonts.poppins(
                          color: Constants.blackColor,
                        ),
                      ),
                      TextSpan(
                        text: 'Reset Here',
                        style: GoogleFonts.poppins(
                          color: Constants.primaryColor,
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'OR',
                      style: GoogleFonts.poppins(),
                    ),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: _handleSignIn,
                child: Container(
                  width: size.width,
                  decoration: BoxDecoration(
                    border: Border.all(color: Constants.primaryColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                        child: Image.asset('assets/logos/logo_google.png'),
                      ),
                      Text(
                        ' Sign In with Google',
                        style: GoogleFonts.poppins(
                          color: Constants.blackColor,
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                      child: SignUp(),
                      type: PageTransitionType.bottomToTop,
                    ),
                  );
                },
                child: Center(
                  child: Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: "Don't have any Account ? ",
                        style: GoogleFonts.poppins(
                          color: Constants.blackColor,
                        ),
                      ),
                      TextSpan(
                        text: 'Register',
                        style: GoogleFonts.poppins(
                          color: Constants.primaryColor,
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
