import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tikom/screen/login/signin.dart';
import '../../class/constant.dart';
import '../../class/customtextfield.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}


class _SignUpState extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _bornController = TextEditingController();

  // Method untuk menangani sign up
  Future<void> _handleSignUp() async {
    try {
      // Panggil metode signInOrRegister dari AuthApiService
      // final token = await AuthApiService.signInOrRegister(
      //   false, // Registrasi baru
      //   email: _emailController.text,
      //   password: _passwordController.text,
      //   name: _nameController.text,
      //   phoneNumber: '', // Kosongkan untuk registrasi
      //   address: '', // Kosongkan untuk registrasi
      //   born: '', // Kosongkan untuk registrasi
      // );

      // Jika token berhasil didapatkan, arahkan pengguna ke halaman login
      // if (token != null) {
      //   Navigator.pushReplacement(
      //     context,
      //     PageTransition(
      //       child: LoginScreen(),
      //       type: PageTransitionType.bottomToTop,
      //     ),
      //   );
      // }
    } catch (error) {
      // Tangani kesalahan jika registrasi gagal
      print('Error: $error');
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
              Text(
                'Sign Up',
                style: GoogleFonts.poppins(
                  fontSize: 35.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 30),
              CustomTextfield(
                obscureText: false,
                hintText: 'Enter Email',
                icon: Icons.alternate_email,
                controller: _emailController, // Masukkan controller email
              ),
              CustomTextfield(
                obscureText: false,
                hintText: 'Enter Full name',
                icon: Icons.person,
                controller: _nameController,
              ),
              CustomTextfield(
                obscureText: true,
                hintText: 'Enter Password',
                icon: Icons.lock,
                controller: _passwordController,
              ),
              CustomTextfield(
                obscureText: false,
                hintText: 'Enter Phone Number',
                icon: Icons.phone,
                controller: _phoneNumberController,
              ),
              TextField(
                controller: _bornController,
                readOnly: true, // User cannot manually enter date
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.calendar_today),
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
              Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text('OR', style: GoogleFonts.poppins()),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 20),
              Container(
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
                      height: 30,
                      child: Image.asset('assets/logos/logo_google.png'),
                    ),
                    Text(
                      'Sign Up with Google',
                      style: GoogleFonts.poppins(
                        color: Constants.blackColor,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                      child: SignIn(),
                      type: PageTransitionType.bottomToTop,
                    ),
                  );
                },
                child: Center(
                  child: Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: 'Have an Account? ',
                        style: GoogleFonts.poppins(
                          color: Constants.blackColor,
                        ),
                      ),
                      TextSpan(
                        text: 'Login',
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
