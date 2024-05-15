// ignore_for_file: prefer_const_constructors, unnecessary_string_escapes, unused_field

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tikom/class/customtextfield.dart';
import 'package:tikom/main.dart';
import 'package:tikom/screen/dashboard/home.dart';
import 'package:tikom/screen/forgotpassword/forgotpass.dart';
import 'package:tikom/screen/signup/signup.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../class/constant.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class _SignInState extends State<SignIn> {
  bool _isObscured = true;
  GoogleSignInAccount? _currentUser;

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
      });
    });
    _googleSignIn.signInSilently();
    super.initState();
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  Future<void> _handleLogin() async {
    // try {
    //   final token = await AuthApiService.signInOrRegister(
    //     true,
    //     email: _emailController.text,
    //     password: _passwordController.text,
    //     name: '',
    //     phoneNumber: '',
    //     address: '',
    //     born: '',
    //   );

    //   if (token != null) {
    //     final SharedPreferences prefs = await SharedPreferences.getInstance();
    //     await prefs.setString('token', token);

    //     // Setelah login berhasil, navigasi ke halaman HomePage
    //     Navigator.pushReplacement(
    //       context,
    //       PageTransition(
    //         child: HomePage(), // Navigasi ke halaman HomePage
    //         type: PageTransitionType.bottomToTop,
    //       ),
    //     );
    //   }
    // } catch (error) {
    //   // Tangani kesalahan jika login gagal
    //   print('Error: $error');
    // }
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
                  onTap:
                      _handleLogin, 
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
                      child: const SignUp(),
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

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:tikom/screen/dashboard/home.dart';
// import 'package:tikom/screen/signup/signup.dart';

// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   late TextEditingController _emailController;
//   late TextEditingController _passwordController;
//   late bool _isObscured;
//   late String _errorMessage;

//   @override
//   void initState() {
//     super.initState();
//     _emailController = TextEditingController();
//     _passwordController = TextEditingController();
//     _isObscured = true;
//     _errorMessage = '';
//   }

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   Future<void> _handleLogin() async {
//     try {
//       final response = await http.post(
//         Uri.parse("https://titik-koma.givenjeremia.com/api/auth/login"),
//         body: {
//           'email': _emailController.text,
//           'password': _passwordController.text,
//         },
//       );

//       if (response.statusCode == 200) {
//         final responseData = json.decode(response.body);
//         final token = responseData['token'];

//         if (token != null) {
//           final prefs = await SharedPreferences.getInstance();
//           prefs.setString("token", token);
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => HomePage()),
//           );
//         } else {
//           setState(() {
//             _errorMessage = 'Failed to get token';
//           });
//         }
//       } else {
//         setState(() {
//           _errorMessage = 'Failed to login';
//         });
//       }
//     } catch (error) {
//       print('Error: $error');
//       setState(() {
//         _errorMessage = 'An error occurred';
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Login'),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               TextFormField(
//                 controller: _emailController,
//                 decoration: InputDecoration(labelText: 'Email'),
//               ),
//               SizedBox(height: 20),
//               TextFormField(
//                 controller: _passwordController,
//                 obscureText: _isObscured,
//                 decoration: InputDecoration(
//                   labelText: 'Password',
//                   suffixIcon: IconButton(
//                     icon: Icon(
//                       _isObscured ? Icons.visibility : Icons.visibility_off,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _isObscured = !_isObscured;
//                       });
//                     },
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _handleLogin,
//                 child: Text('Login'),
//               ),
//               SizedBox(height: 10),
//               if (_errorMessage.isNotEmpty)
//                 Text(
//                   _errorMessage,
//                   style: TextStyle(color: Colors.red),
//                 ),
//               SizedBox(height: 10),
//               TextButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => SignUpScreen()),
//                   );
//                 },
//                 child: Text('Don\'t have an account? Sign Up'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

