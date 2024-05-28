import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tikom/data/blocs/sign_in_email/sign_in_email_bloc.dart';
import 'package:tikom/data/blocs/sign_up/sign_up_bloc.dart';
import 'package:tikom/ui/screen/login/otp.dart';
import 'package:tikom/ui/widgets/dialog.dart';
import 'package:tikom/ui/widgets/loading_dialog.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:tikom/ui/screen/auth_tidak%20di_pakai/login.dart';
// import 'package:tikom/ui/screen/login/signin.dart';
import '../../../utils/constant.dart';
import '../../../utils/customtextfield.dart';
import 'package:tikom/utils/extentions.dart' as AppExt;

class SignUp extends StatefulWidget {
  final String email;
  const SignUp({Key? key, required this.email}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late SignUpBloc _signUpBloc;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _bornController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _referralController = TextEditingController();


  get http => null;

  @override
  void initState() {
    _signUpBloc = SignUpBloc();

    super.initState();
  }

  Future<void> _handleSignUp() async {
    AppExt.hideKeyboard(context);
    DialogTemp().Konfirmasi(
      context: context,
      onYes: () {
        LoadingDialog.show(context, barrierColor: const Color(0xFF777C7E));
        _signUpBloc.add(SignUpButtonPressed(
            email: widget.email,
            name: _nameController.text,
            phone: _phoneNumberController.text,
            bornDate: _bornController.text,
            address: _addressController.text,
            code: _referralController.text ?? '--'
            ));
      },
      title: "Apakah Ingin Melakukan Pendaftaran?",
      onYesText: 'Ya',
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => _signUpBloc,
      child: BlocListener<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SignUpSuccess) {
            AppExt.popScreen(context);
            const snackBar = SnackBar(
              content: Text('Login Success'),
              backgroundColor: Colors.black,
              duration: Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Future.delayed(const Duration(seconds: 2), () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          OtpEmailScreen(email: widget.email)));
            });
          } else if (state is SignUpFailure) {
            AppExt.popScreen(context);
            final snackBar = SnackBar(
                content: Text('Login Failed: ${state.error}'),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                  const Image(
                    image: AssetImage(
                        'assets/logos/logo_tikom_bulat_hijau_hitam.png'),
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
                  CustomTextfield(
                    obscureText: false,
                    hintText: 'Enter Referral Code',
                    icon: Icons.money,
                    controller: _referralController ,
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 10),
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
        ),
      ),
    );
  }
}
