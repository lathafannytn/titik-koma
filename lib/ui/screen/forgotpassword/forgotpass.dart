// // ignore_for_file: prefer_const_constructors

// import 'package:flutter/material.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:tikom/screen/login/signin.dart';
// import 'package:google_fonts/google_fonts.dart';

// import '../../class/constant.dart';
// import '../../class/customtextfield.dart';

// class ForgotPassword extends StatelessWidget {
//   const ForgotPassword({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Image(
//                 image: const AssetImage(
//                     'assets/logos/logo_tikom_bulat_hijau_hitam.png'),
//                 height: 100.0,
//               ),
//               Text(
//                 'Forgot\nPassword',
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
//                 hintStyle: GoogleFonts.poppins(),
//               ),
//               GestureDetector(
//                 onTap: () {},
//                 child: Container(
//                   width: size.width,
//                   decoration: BoxDecoration(
//                     color: Constants.primaryColor,
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
//                   child: Center(
//                     child: Text(
//                       'Reset Password',
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
//               GestureDetector(
//                 onTap: () {
//                   Navigator.pushReplacement(
//                       context,
//                       PageTransition(
//                           child: const SignIn(),
//                           type: PageTransitionType.bottomToTop));
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
