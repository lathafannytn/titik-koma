// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:tikom/screen/login/components/loginfooter.dart';
import 'package:tikom/screen/login/components/loginform.dart';
import 'package:tikom/screen/login/components/loginheader.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Get the size in LoginHeaderWidget()
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                LoginHeaderWidget(),
                LoginForm(),
                LoginFooterWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}