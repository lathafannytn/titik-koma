// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:tikom/screen/login/signin.dart';
// import '../../class/constant.dart';
// import '../../class/customtextfield.dart';
// import '../login/auth_api.dart';

// class SignUp extends StatelessWidget {
//   const SignUp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     // Controllers untuk field email, nama, dan password
//     final TextEditingController _emailController = TextEditingController();
//     final TextEditingController _nameController = TextEditingController();
//     final TextEditingController _passwordController = TextEditingController();

//     // Method untuk menangani sign up
//     Future<void> _handleSignUp() async {
//       try {
//         // Panggil metode signInOrRegister dari AuthApiService
//         final token = await AuthApiService.signInOrRegister(
//           false, // Registrasi baru
//           email: _emailController.text,
//           password: _passwordController.text,
//           name: _nameController.text,
//           phoneNumber: '', // Kosongkan untuk registrasi
//           address: '', // Kosongkan untuk registrasi
//           born: '', // Kosongkan untuk registrasi
//         );

//         // Jika token berhasil didapatkan, arahkan pengguna ke halaman login
//         if (token != null) {
//           Navigator.pushReplacement(
//             context,
//             PageTransition(
//               child: const SignIn(),
//               type: PageTransitionType.bottomToTop,
//             ),
//           );
//         }
//       } catch (error) {
//         // Tangani kesalahan jika registrasi gagal
//         print('Error: $error');
//       }
//     }

//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Image(
//                 image: const AssetImage('assets/logos/logo_tikom_bulat_hijau_hitam.png'),
//                 height: 100.0,
//               ),
//               Text(
//                 'Sign Up',
//                 style: GoogleFonts.poppins(
//                   fontSize: 35.0,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               CustomTextfield(
//                 obscureText: false,
//                 hintText: 'Enter Email',
//                 icon: Icons.alternate_email,
//                 controller: _emailController, // Masukkan controller email
//               ),
//               CustomTextfield(
//                 obscureText: false,
//                 hintText: 'Enter Full name',
//                 icon: Icons.person,
//                 controller: _nameController, // Masukkan controller nama
//               ),
//               CustomTextfield(
//                 obscureText: true,
//                 hintText: 'Enter Password',
//                 icon: Icons.lock,
//                 controller: _passwordController, // Masukkan controller password
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               GestureDetector(
//                 onTap: _handleSignUp, // Panggil method handleSignUp saat tombol ditekan
//                 child: Container(
//                   width: size.width,
//                   decoration: BoxDecoration(
//                     color: Constants.primaryColor,
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
//                   child: Center(
//                     child: Text(
//                       'Sign Up',
//                       style: GoogleFonts.poppins(
//                         color: Colors.white,
//                         fontSize: 18.0,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Row(
//                 children: [
//                   Expanded(child: Divider()),
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 10),
//                     child: Text('OR', style: GoogleFonts.poppins()),
//                   ),
//                   Expanded(child: Divider()),
//                 ],
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Container(
//                 width: size.width,
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Constants.primaryColor),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SizedBox(
//                       height: 30,
//                       child: Image.asset('assets/logos/logo_google.png'),
//                     ),
//                     Text(
//                       'Sign Up with Google',
//                       style: GoogleFonts.poppins(
//                         color: Constants.blackColor,
//                         fontSize: 18.0,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.pushReplacement(
//                     context,
//                     PageTransition(
//                       child: const SignIn(),
//                       type: PageTransitionType.bottomToTop,
//                     ),
//                   );
//                 },
//                 child: Center(
//                   child: Text.rich(
//                     TextSpan(children: [
//                       TextSpan(
//                         text: 'Have an Account? ',
//                         style: GoogleFonts.poppins(
//                           color: Constants.blackColor,
//                         ),
//                       ),
//                       TextSpan(
//                         text: 'Login',
//                         style: GoogleFonts.poppins(
//                           color: Constants.primaryColor,
//                         ),
//                       ),
//                     ]),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tikom/screen/login/signin.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _addressController;
  late TextEditingController _bornController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _addressController = TextEditingController();
    _bornController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    _bornController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    final String name = _nameController.text.trim();
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();
    final String phoneNumber = _phoneNumberController.text.trim();
    final String address = _addressController.text.trim();
    final String born = _bornController.text.trim();

    try {
      final response = await http.post(
        Uri.parse("https://titik-koma.givenjeremia.com/api/auth/register"),
        body: {
          'name': name,
          'email': email,
          'password': password,
          'phone_number': phoneNumber,
          'address': address,
          'born': born,
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);

        if (json['result'] == 'success') {
          print("Sign up berhasil!");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        } else {
          print("Sign up gagal: ${json['message']}");
        }
      } else {
        print("Gagal terhubung ke server");
      }
    } catch (error) {
      print("Error: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Full Name'),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(labelText: 'Phone Number'),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Address'),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _bornController,
                readOnly: true,
                onTap: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _bornController.text =
                          "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
                    });
                  }
                },
                decoration: InputDecoration(labelText: 'Date of Birth'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _signUp,
                child: Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
