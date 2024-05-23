// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tikom/class/card/product/product_card.dart';
import 'package:tikom/common/shared_pref.dart';
import 'package:tikom/data/blocs/fetch_order/fetch_order_cubit.dart';
import 'package:tikom/data/blocs/fetch_order/fetch_order_state.dart';
import 'package:tikom/ui/screen/order/checkout.dart';
import 'package:tikom/utils/storage_service.dart';

import '../../../data/models/drinks.dart';
import 'category.dart';

class DrinksMenuPage extends StatefulWidget {
  @override
  _DrinksMenuPageState createState() => _DrinksMenuPageState();
}

class _DrinksMenuPageState extends State<DrinksMenuPage> {
  late OrderDataCubit _orderDataCubit;
  List<Category> categories = [];
  List<Drinks> drinks = [];

  int currentSelected = 0;
  String uuidCategory = "";
  String token = StorageService.getToken('token');

  @override
  void initState() {
    super.initState();
    _orderDataCubit = OrderDataCubit()..loadOrderData();
    // print(_orderDataCubit);
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

  void handleShowOrder() {}

  void handleDelete(String uuid) {}

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
                                    builder: (context) => CheckoutScreen()),
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

  Widget _buildCategories() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            categories.length,
            (index) => Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ChoiceChip(
                label:
                    Text(categories[index].name, style: GoogleFonts.poppins()),
                selected: currentSelected == index,
                onSelected: (bool selected) {
                  setState(() {
                    currentSelected = index;
                    uuidCategory = categories[index].uuid;
                  });
                },
                selectedColor: Color.fromARGB(255, 9, 76, 58),
                labelStyle: GoogleFonts.poppins(
                  color: currentSelected == index ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _orderDataCubit,
        ),
      ],
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white,
              expandedHeight: 200.0,
              floating: true,
              pinned: true,
              snap: true,
              flexibleSpace: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  var top = constraints.biggest.height;
                  bool scrolled = top < 120.0;

                  return FlexibleSpaceBar(
                    titlePadding:
                        EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    title: scrolled
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Pick up dari store',
                                style: GoogleFonts.poppins(
                                    color: Colors.black, fontSize: 12),
                              ),
                              Text(
                                'Jalan Sulawesi',
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  Text(
                                    '0.3km ',
                                    style: GoogleFonts.poppins(
                                        fontSize: 12, color: Colors.black),
                                  ),
                                  Text(
                                    '• Terdekat',
                                    style: GoogleFonts.poppins(
                                        fontSize: 12, color: Colors.green),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : null,
                    background: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!scrolled) ...[
                            Text(
                              'Pick Up',
                              style: GoogleFonts.poppins(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Text(
                              'Ambil di store tanpa antri',
                              style: GoogleFonts.poppins(
                                  fontSize: 16, color: Colors.black),
                            ),
                            SizedBox(height: 10),
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              child: ListTile(
                                leading: Icon(Icons.store,
                                    color: Color.fromARGB(255, 9, 76, 58)),
                                title: Text('Jalan Sulawesi',
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold)),
                                subtitle: Row(
                                  children: [
                                    Text(
                                      '0.3km ',
                                      style: GoogleFonts.poppins(fontSize: 14),
                                    ),
                                    Text(
                                      '• Terdekat',
                                      style: GoogleFonts.poppins(
                                          fontSize: 14, color: Colors.green),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.search, color: Colors.black),
                  onPressed: () {
                    // Implement search functionality here
                  },
                ),
              ],
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverAppBarDelegate(
                minHeight: 50.0,
                maxHeight: 50.0,
                child: _buildCategories(),
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
                        return Center(
                          child: Text(
                            "Error: //${snapshot.error}",
                            style: GoogleFonts.poppins(),
                          ),
                        );
                      } else if (snapshot.hasData) {
                        return ListView.builder(
                          padding: EdgeInsets.all(16),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            var drink = snapshot.data![index];
                            return ProductCard(
                              name: drink.name,
                              price: drink.price,
                              imagePath: drink.imgUrl,
                              uuid: drink.uuid,
                            );
                          },
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                        );
                      } else {
                        return Center(
                          child: Text(
                            "No data available",
                            style: GoogleFonts.poppins(),
                          ),
                        );
                      }
                    },
                  );
                },
                childCount: 1,
              ),
            ),
          ],
        ),
        bottomNavigationBar: BlocBuilder(
          bloc: _orderDataCubit,
          builder: (context, state) {
            if (state is OrderDataLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is OrderDataSuccess) {
              print(state.categories.length);
              
              if (state.categories.length > 0) {
                return BottomAppBar(
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
                                  Icon(Icons.shopping_bag,
                                      color: Color.fromARGB(255, 9, 76, 58),
                                      size: 30),
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
                                        "${state.categories[0].total_quantity}",
                                        style: GoogleFonts.poppins(
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
                                // ignore: prefer_interpolation_to_compose_strings
                                "Rp. ${state.categories[0].total_price}", 
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _showBottomSheet(context);
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
                        ],
                      ),
                    ),
                  ),
                );
              }
            }
            if (state is OrderDataFailure) {
              print('error');
              print(state.message);
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      elevation: 0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: child,
      ),
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
