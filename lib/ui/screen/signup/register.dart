import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back, // Replace with the desired icon
            color: Color.fromRGBO(33, 45, 82, 1),
          ),
        ),
        title: Text(
          "Sign Up",
          style: TextStyle(
            color: Color.fromRGBO(33, 45, 82, 1),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: _size.height - AppBar().preferredSize.height,
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Wrap(
                runAlignment: WrapAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 30.0,
                    ),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.5),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    width: double.infinity,
                    child: Column(
                      children: [
                        Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Color.fromRGBO(33, 45, 82, 1),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        // Removed RegisterForm placeholder
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                onPressed: () {
                  // Replace onPressed logic with your actual registration logic
                },
                child: Text("Get Started"),
              ),
              Center(
                child: Wrap(
                  runAlignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Color.fromRGBO(64, 74, 106, 1),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Replace onPressed logic with your login logic
                      },
                      child: Text(
                        "Log In",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.0,
                          color: Colors.blue, // Replace with your color
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                    },
                    child: Image.asset("assets/logos/logo_google.png"),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  GestureDetector(
                    onTap: () {
                    },
                    child: Image.asset("assets/logos/logo_google.png"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
