// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tikom/class/card/product/product_card.dart';
import 'package:tikom/common/shared_pref.dart';
import 'package:tikom/common/storage_service.dart';

import '../../models/drinks.dart';
import 'category.dart';

// class DrinksMenuPage extends StatefulWidget {
//   @override
//   _DrinksMenuPageState createState() => _DrinksMenuPageState();
// }

// class _DrinksMenuPageState extends State<DrinksMenuPage> {
//   List<String> categoryList = [
//     'Coffee',
//     'Tea',
//     'Milk',
//     'Bundle',
//     'Merchandise',
//     'Others'
//   ];
//   int currentSelected = 0;

//   Future<List<dynamic>> fetchDrinks() async {
//     try {
//       final response = await http.get(
//           Uri.parse('https://titik-koma.givenjeremia.com/api/product/menu'));
//       if (response.statusCode == 200) {
//         return json.decode(response.body);
//       } else {
//         throw Exception(
//             'Failed to load drinks with status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Failed to connect to the server: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: <Widget>[
//           SliverAppBar(
//             backgroundColor: Colors.transparent,
//             expandedHeight: 250.0,
//             floating: false,
//             pinned: true,
//             flexibleSpace: LayoutBuilder(
//               builder: (BuildContext context, BoxConstraints constraints) {
//                 var top = constraints.biggest.height;
//                 return FlexibleSpaceBar(
//                   title: Text('Drinks Menu',
//                       style: GoogleFonts.poppins(
//                         textStyle: TextStyle(
//                           color: Colors.white,
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           shadows: <Shadow>[
//                             Shadow(
//                               offset: Offset(1.0, 1.0),
//                               blurRadius: 3.0,
//                               color: Color.fromARGB(150, 0, 0, 0),
//                             ),
//                           ],
//                         ),
//                       )),
//                   centerTitle: true,
//                   background: Stack(
//                     fit: StackFit.expand,
//                     children: [
//                       Image.network(
//                         "https://example.com/banner.jpg",
//                         fit: BoxFit.cover,
//                         color: Colors.black45,
//                         colorBlendMode: BlendMode.darken,
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                           color: Colors.black.withOpacity(
//                               top == 250.0 ? 0.0 : (1 - (top - 80) / 170)),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//             bottom: PreferredSize(
//               preferredSize: Size.fromHeight(48),
//               child: Container(
//                 color: Colors.white,
//                 child: categorySelection(),
//               ),
//             ),
//           ),
//           SliverList(
//             delegate: SliverChildBuilderDelegate(
//               (BuildContext context, int index) {
//                 return FutureBuilder<List<dynamic>>(
//                   future: fetchDrinks(),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return Center(child: CircularProgressIndicator());
//                     } else if (snapshot.hasError) {
//                       return Center(child: Text("Error: ${snapshot.error}"));
//                     } else if (snapshot.hasData) {
//                       return GridView.builder(
//                         padding: EdgeInsets.all(16),
//                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 2,
//                           crossAxisSpacing: 10,
//                           mainAxisSpacing: 20,
//                           childAspectRatio: 0.8,
//                         ),
//                         itemCount: snapshot.data!.length,
//                         itemBuilder: (context, index) {
//                           var drink = snapshot.data![index];
//                           return ProductCard(
//                             name: drink['nama'],
//                             price: drink['harga'],
//                             imagePath:
//                                 'assets/images/${drink['nama'].replaceAll(' ', '_').toLowerCase()}.png',
//                           );
//                         },
//                         shrinkWrap: true,
//                         physics: NeverScrollableScrollPhysics(),
//                       );
//                     } else {
//                       return Center(child: Text("No data available"));
//                     }
//                   },
//                 );
//               },
//               childCount: 1,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget categorySelection() {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       padding: EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         children: List<Widget>.generate(categoryList.length, (index) {
//           return Padding(
//             padding: EdgeInsets.symmetric(horizontal: 10),
//             child: ChoiceChip(
//               label: Text(categoryList[index]),
//               selected: currentSelected == index,
//               onSelected: (bool selected) {
//                 setState(() {
//                   currentSelected = index;
//                 });
//               },
//               backgroundColor: Colors.white,
//               selectedColor: Colors.blueAccent,
//               labelStyle: TextStyle(
//                   color:
//                       currentSelected == index ? Colors.white : Colors.black),
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }

class DrinksMenuPage extends StatefulWidget {
  @override
  _DrinksMenuPageState createState() => _DrinksMenuPageState();
}

class _DrinksMenuPageState extends State<DrinksMenuPage> {
  List<Category> categories = [];
  List<Drinks> drinks = [];

  int currentSelected = 0;
  String uuidCategory = "";
  String token = StorageService.getData('token');

  @override
  void initState() {
    super.initState();

    fetchCategories();
    print('Token $token');
  }

  Future<List<Category>> fetchCategories() async {
    print(token);
    try {
      final response = await http.get(
          Uri.parse(
            'https://titik-koma.givenjeremia.com/api/product/category',
          ),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
      if (response.statusCode == 200) {
        final List<Category> categories = [];
        final responseData = json.decode(response.body)['data'];
        if (responseData != null) {
          for (var categoryData in responseData) {
            categories.add(Category.fromJson(categoryData));
          }
        }
        return categories;
      } else {
        throw Exception(
            'Failed to load categories with status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server Category: $e');
    }
  }

  Future<List<Drinks>> fetchDrinksByCategory(String uuid) async {
    print('--- Ferarch ');
    print(uuid);
    try {
      final response = await http.get(
          Uri.parse(
              'https://titik-koma.givenjeremia.com/api/product/category/$uuid'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
      if (response.statusCode == 200) {
        print('Received successful response');
        final List<Drinks> drinks = [];

        // Decode the response body
        final decodedBody = json.decode(response.body);
        print('Decoded body: $decodedBody');

        // Extract the 'data' field from the decoded body
        final responseData = decodedBody['data'];
        print('Response data: $responseData');

        // Check if responseData is not null and is a list
        if (responseData != null && responseData is List) {
          for (var drinkData in responseData) {
            print('Processing drink data: $drinkData');

            // Create a Drink object from the JSON data and add it to the list
            drinks.add(Drinks.fromJson(drinkData));
          }
        } else {
          throw Exception('Invalid response data format');
        }

        print('Processed drinks: $drinks');
        return drinks;
      } else {
        throw Exception(
            'Failed to load drinks with status code: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to connect to the server: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.transparent,
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Drinks Menu',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
              background:
                  Image.asset("assets/images/home.jpg", fit: BoxFit.cover),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(48),
              child: Container(
                color: Colors.white,
                child: categorySelection(),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return FutureBuilder<List<Drinks>>(
                  future: fetchDrinksByCategory(categories[index].uuid),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    } else if (snapshot.hasData) {
                      return GridView.builder(
                        padding: EdgeInsets.all(16),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 20,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var drink = snapshot.data![index];
                          return ProductCard(
                            name: drink.name,
                            price: 12311211,
                            imagePath: drink.imgUrl,
                          );
                        },
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                      );
                    } else {
                      return Center(child: Text("No data available"));
                    }
                  },
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget categorySelection() {
    if (categories.isEmpty) {
      return Center(child: Text("No Categories Available"));
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: List<Widget>.generate(categories.length, (index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: ChoiceChip(
              label: Text(categories[index].name),
              selected: currentSelected == index,
              onSelected: (bool selected) {
                setState(() {
                  uuidCategory = categories[index].uuid;
                  currentSelected = index;
                });
              },
              backgroundColor: Colors.white,
              selectedColor: Colors.blueAccent,
              labelStyle: TextStyle(
                  color:
                      currentSelected == index ? Colors.white : Colors.black),
            ),
          );
        }),
      ),
    );
  }
}
