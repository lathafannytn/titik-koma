// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tikom/class/card/product/product_card.dart';

class DrinksMenuPage extends StatefulWidget {
  @override
  _DrinksMenuPageState createState() => _DrinksMenuPageState();
}

class _DrinksMenuPageState extends State<DrinksMenuPage> {
  List<String> categoryList = [
    'Coffee',
    'Tea',
    'Milk',
    'Bundle',
    'Merchandise',
    'Others'
  ];
  int currentSelected = 0;

  Future<List<dynamic>> fetchDrinks() async {
    try {
      final response = await http.get(
          Uri.parse('https://titik-koma.givenjeremia.com/api/product/menu'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception(
            'Failed to load drinks with status code: ${response.statusCode}');
      }
    } catch (e) {
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
            expandedHeight: 250.0,
            floating: false,
            pinned: true,
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                var top = constraints.biggest.height;
                return FlexibleSpaceBar(
                  title: Text('Drinks Menu',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(1.0, 1.0),
                              blurRadius: 3.0,
                              color: Color.fromARGB(150, 0, 0, 0),
                            ),
                          ],
                        ),
                      )),
                  centerTitle: true,
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        "https://example.com/banner.jpg",
                        fit: BoxFit.cover,
                        color: Colors.black45,
                        colorBlendMode: BlendMode.darken,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(
                              top == 250.0 ? 0.0 : (1 - (top - 80) / 170)),
                        ),
                      ),
                    ],
                  ),
                );
              },
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
                return FutureBuilder<List<dynamic>>(
                  future: fetchDrinks(),
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
                            name: drink['nama'],
                            price: drink['harga'],
                            imagePath:
                                'assets/images/${drink['nama'].replaceAll(' ', '_').toLowerCase()}.png',
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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: List<Widget>.generate(categoryList.length, (index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: ChoiceChip(
              label: Text(categoryList[index]),
              selected: currentSelected == index,
              onSelected: (bool selected) {
                setState(() {
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
