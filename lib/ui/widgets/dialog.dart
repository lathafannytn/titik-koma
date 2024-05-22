import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:get/get.dart';

class DialogTemp {
  // ignore: non_constant_identifier_names
  void Konfirmasi(
      {required BuildContext context,
      required void Function() onYes,
      required String onYesText,
      required String title}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0)),
            child: Container(
              constraints: BoxConstraints(
                  maxWidth: !context.isPhone
                      ? 500
                      : MediaQuery.of(context).size.width),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: Text(
                      title,
                      style: const TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF21232C),
                      ),
                      textAlign: TextAlign.center,
                    ),),
                    
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              onYes();
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              primary: Color.fromARGB(255, 9, 76, 58),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            child: Text(
                              onYesText,
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            child: const Text(
                              'Tidak',
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

// ignore: non_constant_identifier_names
  void Informasi(
      {required BuildContext context,
      required void Function() onYes,
      required String onYesText,
      required String title}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0)),
            child: Container(
              constraints: BoxConstraints(
                  maxWidth: !context.isPhone
                      ? 500
                      : MediaQuery.of(context).size.width),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF21232C),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        onYes();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        primary: Color.fromARGB(255, 9, 76, 58),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      child: Text(
                        onYesText,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
