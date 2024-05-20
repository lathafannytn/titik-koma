// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tikom/class/card/product/product_card.dart';
import 'package:tikom/common/shared_pref.dart';
import 'package:tikom/utils/storage_service.dart';

import '../../../data/models/drinks.dart';
import 'category.dart';

class DrinksMenuPage extends StatefulWidget {
  @override
  _DrinksMenuPageState createState() => _DrinksMenuPageState();
}

class _DrinksMenuPageState extends State<DrinksMenuPage> {
  List<Category> categories = [];
  List<Drinks> drinks = [];

  int currentSelected = 0;
  String uuidCategory = "";
  String token = StorageService.getToken('token');

  @override
  void initState() {
    super.initState();
    fetchCategories().then((data) {
      setState(() {
        categories = data as List<Category>;
        if (categories.isNotEmpty) {
          uuidCategory = categories[0].uuid;
        }
      });
    });
  }

  Future<List<Category>> fetchCategories() async {
    try {
      final response = await http.get(
          Uri.parse('https://titik-koma.givenjeremia.com/api/product/category'),
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
        final List<Drinks> drinks = [];
        final decodedBody = json.decode(response.body);
        final responseData = decodedBody['data'];
        if (responseData != null && responseData is List) {
          for (var drinkData in responseData) {
            drinks.add(Drinks.fromJson(drinkData));
          }
        } else {
          throw Exception('Invalid response data format');
        }
        return drinks;
      } else {
        throw Exception(
            'Failed to load drinks with status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }

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
                          title: Text('Spanish Aren Latte', style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text('Iced'),
                          leading: Image.asset('assets/images/kopi_aren_doppio.jpg', width: 50),
                          trailing: Container(
                            width: 120,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    // Decrease item quantity logic here
                                  },
                                  icon: Icon(Icons.remove_circle_outline, color: Colors.orange),
                                ),
                                Text('1', style: TextStyle(fontSize: 16)),
                                IconButton(
                                  onPressed: () {
                                    // Increase item quantity logic here
                                  },
                                  icon: Icon(Icons.add_circle_outline, color: Colors.orange),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text('Total: Rp 26.000', style: TextStyle(fontWeight: FontWeight.bold)),
                          trailing: ElevatedButton(
                            onPressed: () {
                              // Add your checkout logic here
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.orange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text("Checkout"),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
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
                      future: fetchDrinksByCategory(uuidCategory),
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
                                price: drink.price,
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
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: InkWell(
          onTap: () {
            _showBottomSheet(context);
          },
          child: Container(
            height: 60,
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                    Stack(
                      children: [
                        Icon(Icons.shopping_bag, color: Colors.orange, size: 30),
                        Positioned(
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            constraints: BoxConstraints(
                              minWidth: 12,
                              minHeight: 12,
                            ),
                            child: Text(
                              '1',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Rp 26.000",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    _showBottomSheet(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text("Checkout"),
                ),
              ],
            ),
          ),
        ),
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
                  currentSelected = index;
                  uuidCategory = categories[index].uuid;
                });
              },
              selectedColor: Colors.orange,
              labelStyle: TextStyle(
                  color: currentSelected == index ? Colors.white : Colors.black),
            ),
          );
        }),
      ),
    );
  }
}
