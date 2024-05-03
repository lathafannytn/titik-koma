

import 'package:flutter/material.dart';

class LoginFooterWidget extends StatefulWidget {
  const LoginFooterWidget({Key? key}) : super(key: key);

  @override
  _LoginFooterWidgetState createState() => _LoginFooterWidgetState();
}

class _LoginFooterWidgetState extends State<LoginFooterWidget> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("OR"),
        const SizedBox(height: 8.0),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            icon: ImageIcon(
              AssetImage('assets/logos/logo_google.png'),
              size: 20.0,
            ),
            onPressed: () {},
            label: const Text("Sign In With Google"),
          ),
        ),
        const SizedBox(height: 8.0),
        TextButton(
          onPressed: () {},
          child: Text.rich(
            TextSpan(
                text: "Dont have an Account ",
                style: Theme.of(context).textTheme.bodyText1,
                children: const [
                  TextSpan(
                      text: "Sign Up", style: TextStyle(color: Colors.blue))
                ]),
          ),
        ),
      ],
    );
  }


  
}

