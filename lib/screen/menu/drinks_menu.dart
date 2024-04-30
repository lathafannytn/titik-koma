// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class DrinksMenuPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: Text(
//           'Drinks Menu',
//           style: GoogleFonts.poppins(
//             textStyle: TextStyle(
//               color: Colors.black,
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         centerTitle: true,
//         iconTheme: IconThemeData(color: Colors.black),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             _buildHeader(context),
//             _buildCategorySelector(),
//             _buildDrinkGrid(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader(BuildContext context) {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         Image.asset(
//           "assets/images/home.jpg",
//           height: 200,
//           width: double.infinity,
//           fit: BoxFit.cover,
//         ),
//         Column(
//           children: [
//             SizedBox(height: 16),
//             _buildOptionCard(context, "Pickup", Icons.store, "Pickup Location"),
//             _buildOptionCard(context, "Delivery", Icons.delivery_dining, "Choose Delivery")
//           ],
//         )
//       ],
//     );
//   }

//   Widget _buildOptionCard(BuildContext context, String title, IconData icon, String detail) {
//     return Card(
//       margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: ListTile(
//         leading: Icon(icon, size: 30),
//         title: Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
//         subtitle: Text(detail, style: GoogleFonts.poppins(fontSize: 12)),
//         onTap: () {
//           // Trigger navigation or state change based on title
//           Navigator.of(context).push(MaterialPageRoute(builder: (_) {
//             return DetailSelectionPage(detailType: title);
//           }));
//         },
//       ),
//     );
//   }

//   Widget _buildCategorySelector() {
//     return Container(
//       height: 50,
//       margin: EdgeInsets.symmetric(vertical: 10),
//       child: ListView(
//         scrollDirection: Axis.horizontal,
//         children: ['Coffee', 'Tea', 'Milk'].map((category) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: Chip(
//               label: Text(category, style: GoogleFonts.poppins(color: Colors.white)),
//               backgroundColor: Colors.blue,
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }

//   Widget _buildDrinkGrid() {
//     return GridView.count(
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       crossAxisCount: 2,
//       crossAxisSpacing: 20,
//       mainAxisSpacing: 20,
//       childAspectRatio: 0.85,
//       children: List.generate(10, (index) => DrinkMenuCard()),
//     );
//   }
// }

// class DrinkMenuCard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15.0),
//       ),
//       child: Stack(
//         clipBehavior: Clip.none,
//         alignment: Alignment.topLeft,
//         children: [
//           Padding(
//             padding: EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Spacer(),
//                 Text(
//                   'LATTE',
//                   style: GoogleFonts.poppins(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 4),
//                 Text(
//                   '\$20.000',
//                   style: GoogleFonts.poppins(
//                     fontSize: 16,
//                     color: Colors.black54,
//                   ),
//                 ),
//                 SizedBox(height: 15),
//               ],
//             ),
//           ),
//           Positioned(
//             right: 5,
//             top: -50,
//             child: Image.asset(
//               'assets/images/latte.png',
//               width: 85,
//               height: 130,
//               fit: BoxFit.cover,
//             ),
//           ),
//           Positioned(
//             right: 10,
//             bottom: 10,
//             child: FloatingActionButton(
//               onPressed: () => print('Add to cart'),
//               child: Icon(Icons.add, color: Colors.white),
//               backgroundColor: Colors.green,
//               mini: true,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Example detail selection page for Pickup or Delivery options
// class DetailSelectionPage extends StatelessWidget {
//   final String detailType;

//   DetailSelectionPage({required this.detailType});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(detailType + ' Details'),
//         backgroundColor: Colors.blue,
//       ),
//       body: Center(
//         child: Text('Details for ' + detailType),
//       ),
//     );
//   }
// }

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tikom/class/card/DrinkMenuCard.dart';

class DrinksMenuPage extends StatelessWidget {
  Future<List<dynamic>> fetchDrinks() async {
    try {
      final response = await http.get(
          Uri.parse('https://titik-koma.givenjeremia.com/api/product/menu'));
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception(
            'Failed to load drinks with status code: ${response.statusCode}');
      }
    } catch (e) {
      
      print('Exception caught: $e');
      throw Exception('Failed to connect to the server: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Drinks Menu',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchDrinks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.all(16),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 40,
                  childAspectRatio: 0.8,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var drink = snapshot.data![index];
                  return DrinkMenuCard(
                    name: drink['nama'],
                    price: drink['harga'],
                    imagePath:
                        'assets/images/${drink['nama'].replaceAll(' ', '_').toLowerCase()}.png',
                  );
                },
              ),
            );
          } else {
            return Center(child: Text("No data available"));
          }
        },
      ),
    );
  }
}

