import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tikom/ui/screen/order/checkout.dart';

void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.3,
          minChildSize: 0.1,
          maxChildSize: 0.8,
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              color: Colors.white,
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      controller: scrollController,
                      children: [
                        ListTile(
                          title: Text('Spanish Aren Latte',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold)),
                          subtitle: Text('Iced', style: GoogleFonts.poppins()),
                          leading: Image.asset(
                              'assets/images/kopi_aren_doppio.jpg',
                              width: 50),
                          trailing: Container(
                            width: 120,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    // Decrease item quantity logic here
                                  },
                                  icon: Icon(Icons.remove_circle_outline,
                                      color: Color.fromARGB(255, 9, 76, 58)),
                                ),
                                Text('1',
                                    style: GoogleFonts.poppins(fontSize: 16)),
                                IconButton(
                                  onPressed: () {
                                    // Increase item quantity logic here
                                  },
                                  icon: Icon(Icons.add_circle_outline,
                                      color: Color.fromARGB(255, 9, 76, 58)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text('Total: Rp 26.000',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold)),
                          trailing: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CheckoutScreen(uuid: '', count: 0)),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 9, 76, 58),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child:
                                Text("Checkout", style: GoogleFonts.poppins()),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }