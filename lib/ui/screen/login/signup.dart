import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:tikom/ui/screen/auth_tidak%20di_pakai/login.dart';
// import 'package:tikom/ui/screen/login/signin.dart';
import '../../../utils/constant.dart';
import '../../../utils/customtextfield.dart';

class SignUp extends StatefulWidget {
  final String email;
  const SignUp({Key? key, required this.email}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _bornController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  get http => null;

  // Method untuk menangani sign up
  Future<void> _handleSignUp() async {
    print(_bornController.text);
    // try{
    //  final response = await http.post(
    //       Uri.parse('https://titik-koma.givenjeremia.com/api/auth/register'),
    //       body: {
    //         'email': _emailController.text,
    //         'password': _passwordController.text
    //       });
    //   if (response.statusCode == 200) {
    //     if (json.decode(response.body)['status'] == 'success') {
    //       // ignore: use_build_context_synchronously
    //       // Navigator.pushReplacement(
    //       //   context,
    //       //   PageTransition(
    //       //     child: MyHomePage(),
    //       //     type: PageTransitionType.bottomToTop,
    //       //   ),
    //       // );
    //     } else {
    //       print('Login Gagal');
    //     }
    //   } else {
    //     throw Exception(
    //         'Failed to load categories with status code: ${response.statusCode}');
    //   }
    // } catch (e) {
    //   throw Exception('Failed to connect to the server Category: $e');
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
              const Image(
                image:
                    AssetImage('assets/logos/logo_tikom_bulat_hijau_hitam.png'),
                height: 100.0,
              ),
              Text(
                'Sign Up',
                style: GoogleFonts.poppins(
                  fontSize: 35.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Email : ${widget.email}',
                style: GoogleFonts.poppins(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              CustomTextfield(
                obscureText: false,
                hintText: 'Enter Full name',
                icon: Icons.person,
                controller: _nameController,
              ),
              const SizedBox(height: 5),
              CustomTextfield(
                obscureText: false,
                hintText: 'Enter Phone Number',
                icon: Icons.phone,
                controller: _phoneNumberController,
              ),
              const SizedBox(height: 5),
              CustomTextfield(
                obscureText: false,
                hintText: 'Enter Address',
                icon: Icons.home,
                controller: _addressController,
              ),

              const SizedBox(height: 5),
              TextField(
                controller: _bornController,
                readOnly: true, // User cannot manually enter date
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.calendar_today),
                  hintText: 'Enter Date of Birth',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );

                  if (pickedDate != null) {
                    String formattedDate =
                        "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                    setState(() {
                      _bornController.text = formattedDate;
                    });
                  }
                },
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: _handleSignUp,
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
                      'Sign Up',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Row(
              //   children: [
              //     const Expanded(child: Divider()),
              //     Padding(
              //       padding: const EdgeInsets.symmetric(horizontal: 10),
              //       child: Text('OR', style: GoogleFonts.poppins()),
              //     ),
              //     const Expanded(child: Divider()),
              //   ],
              // ),
              const SizedBox(height: 20),
              // Container(
              //   width: size.width,
              //   decoration: BoxDecoration(
              //     border: Border.all(color: Constants.primaryColor),
              //     borderRadius: BorderRadius.circular(20),
              //   ),
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       SizedBox(
              //         height: 30,
              //         child: Image.asset('assets/logos/logo_google.png'),
              //       ),
              //       Text(
              //         'Sign Up with Google',
              //         style: GoogleFonts.poppins(
              //           color: Constants.blackColor,
              //           fontSize: 18.0,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // const SizedBox(height: 20),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.pushReplacement(
              //       context,
              //       PageTransition(
              //         child: SignIn(),
              //         type: PageTransitionType.bottomToTop,
              //       ),
              //     );
              //   },
              //   child: Center(
              //     child: Text.rich(
              //       TextSpan(children: [
              //         TextSpan(
              //           text: 'Have an Account? ',
              //           style: GoogleFonts.poppins(
              //             color: Constants.blackColor,
              //           ),
              //         ),
              //         TextSpan(
              //           text: 'Login',
              //           style: GoogleFonts.poppins(
              //             color: Constants.primaryColor,
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
    );
  }
}
